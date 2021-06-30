% This script is the final optimazation for the IVC LAB
% © Alexander Prommesberger August 2020
% ----------------------------- Read Me --------------------------------- 
% 1. Select the path to your images and add myfunctions folder to path!
% 2. Press Run to run with default Parameters --> only 8x8 PRediction is used!
% 3. Play arount with the parameters, describtion below
clear
%% Loading images to encode
% path = uigetdir()
path = 'D:\Desktop\IVC Lab\IVC_labs_starting_point\data\videos\foreman20_40_RGB';
direc = dir(fullfile(path, '*.bmp'));

%% Init parameters
% Recommended qScales if 4x4 pred is used!
%qScales = [0.07, 0.2, 0.4];
%Recommended qScales for 8x8 pred
qScales = [0.07, 0.2, 0.4, 0.8, 1.0, 1.5, 2, 3, 4.1, 4.5];

% This is a parameter only used in the intra mode, as explained in the
% presentation, I use the AVC 8x8 and AVC 4x4 prediction. I decide which one to use by calculating the Entropy of all 8x8 blocks, take the mean over it, compare this mean to all 8x8 blocks and make the following destinction: where the 8x8 block entropy is lower than the mean 8x8 Prediciton is used, where the block 8x8 entropy is higher than the mean, the 4x4 prediciton is used
% if h_fac > 2 only 8x8 prediciton is used!
% Problem: The issue with the 4x4 prediciton is the quantazation - unfortunately I didnt have enough time to fix this
% if 4x4 PRed should be used: h_fac = 1.05 is recommended -- qScale should
% be below 0.5!
% h_fac = 1.05;
h_fac = 5;

% Defines the search area of the logarithmic search algo - if set to high runtime problems! =4 is recommended
max_displacement = 4;

% EOB of of zero run encode, should not be lowered
EOB = 4000;

bpp_vid = [];
psnr_vid = [];
bpp_img = [];
psnr_img = [];

img_train = ictRGB2YCbCr(imread(fullfile(path, direc(1).name)));%ictRGB2YCbCr(imread('D:\Desktop\IVC Lab\IVC_labs_starting_point\data\images\lena_small.tif'));
img = ictRGB2YCbCr(imread(fullfile(path, direc(1).name)));

for i = 1:length(qScales)

%% First P Frame
decoded_frame = zeros([size(img), length(direc)]);
qScale = qScales(i);
[I, P_psnr, P_bpp] = IntraMode3X(img, img, qScale, EOB, h_fac);
decoded_frame(:,:,:,1) = I;

bpp_img = [bpp_img, P_bpp];

psnr_img = [psnr_img, P_psnr];

%% Loop for Video
bitPerPixel_vid(1) = P_bpp;
PSNR_vid(1) = P_psnr;
for i = 2:numel(direc)
    ref_img = ictRGB2YCbCr(decoded_frame(:,:,:,i-1));
    img_rgb = double(imread(fullfile(path, direc(i).name)));
    img_ycc = ictRGB2YCbCr(img_rgb);
    
    %[ err_im, mv_coeffs] = LogMotEst( ref_img, img_ycc, max_displacement);
    [ err_img, mv_coeffs, mot_mode_coeffs] = LogMotEst_4_8( ref_img, img_ycc, max_displacement);
    
    zeroRun = InterEnc3X(err_img, qScale, EOB);
    
    
    %% Huffman Code buidling step
    
    % Build Huffman for Error Image im_err
    zeroRun_pmf = stats_marg(zeroRun, min(zeroRun):max(zeroRun));
    [BinaryTree_zeroRun, ~, BinCode_zeroRun, Codelengths_zeroRun] = ...
        buildHuffman( zeroRun_pmf);
    min_num = min(zeroRun);
    % Build Huffman for MV and mot_mode
    if isequal(i,2)
        %MV
        mv_pmf = stats_marg(mv_coeffs(:), min(mv_coeffs(:)):max(mv_coeffs(:)));
        [BinaryTree_mv, ~, BinCode_mv, Codelengths_mv] = buildHuffman(mv_pmf);
        
        %mod_mode
        mot_mode_coeffs_pmf = stats_marg(mot_mode_coeffs(:), min(mot_mode_coeffs(:)):max(mot_mode_coeffs(:)));
        [BinaryTree_mot_mode_coeffs, ~, BinCode_mot_mode_coeffs, Codelengths_mot_mode_coeffs] = ...
            buildHuffman( mot_mode_coeffs_pmf);
        
    end
    
    %% Encoding --> Generate Bytestream
    bytestream1 = enc_huffman_new(zeroRun-min(zeroRun)+1, BinCode_zeroRun, Codelengths_zeroRun);
    bytestream2 = enc_huffman_new(mv_coeffs(:), BinCode_mv, Codelengths_mv);
    bytestream3 = enc_huffman_new(mot_mode_coeffs(:), BinCode_mot_mode_coeffs, Codelengths_mot_mode_coeffs);
    
    %% Caluclate bpp
    bitPerPixel_vid(i) = (numel(bytestream1)*8) / (numel(img_rgb)/3) + (numel(bytestream2)*8) / (numel(img_rgb)/3) + (numel(bytestream3)*8) / (numel(img_rgb)/3)
    
    
    %% Decoding
    zeroRun_dec = dec_huffman_new(bytestream1, BinaryTree_zeroRun, max(size(zeroRun(:))))+min(zeroRun)-1;
    mv_dec = dec_huffman_new(bytestream2, BinaryTree_mv, max(size(mv_coeffs(:))));
    mot_mode_coeffs_dec = dec_huffman_new(bytestream3, BinaryTree_mot_mode_coeffs, max(size(mot_mode_coeffs(:))));
    
    mv_dec = reshape(mv_dec, size(mv_coeffs));
    
    
    err_im_dec = InterDec3X(zeroRun_dec, size(img_rgb), qScale, EOB);
    
    rec_img = LogMotRec_4_8(err_im_dec, ref_img, mv_dec, mot_mode_coeffs_dec, max_displacement);
    rec_img = ictYCbCr2RGB(rec_img);

    decoded_frame(:,:,:,i) = (rec_img);
    PSNR_vid(i) = calcPSNR((img_rgb),decoded_frame(:,:,:,i))
    
    %imshow(uint8(decoded_frame(:,:,:,i)))
    
    
end

bpp_vid = [bpp_vid, mean(bitPerPixel_vid)];
psnr_vid = [psnr_vid, mean(PSNR_vid)];


end

figure(2)


bpp_img_4 =  struct2array(load('bpp_img_final.mat'));
psnr_img_4 = struct2array(load('psnr_img_final.mat'));

bpp_vid_5 = struct2array(load('bpp_video_final.mat'));
psnr_vid_5 = struct2array(load('psnr_video_final.mat'));
hold on 

    plot(bpp_img_4,psnr_img_4 ,'-*', 'linewidth', 2, 'color', 'r')
    plot(bpp_vid_5, psnr_vid_5,'-*', 'linewidth', 2, 'color', 'b')
    
    plot(bpp_img, psnr_img ,'--*', 'linewidth', 2, 'color', 'c')    
    plot(bpp_vid, psnr_vid,'--*', 'linewidth', 2, 'color', 'm')
    legend('Image Codec Chap. 4', 'Video Codec Chap. 5', 'Image Codec Opt.', 'Video Codec Opt.')


title('BPP to PSNR Plot', 'FontSize',25)
xlabel('BPP [bit/pixel]', 'FontSize',30)
ylabel('PSNR [dB]', 'FontSize',30)
ax = gca;
ax.YAxis.FontSize = 20;
ax.XAxis.FontSize = 20;

