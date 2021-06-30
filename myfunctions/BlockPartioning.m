% path = 'D:\Desktop\IVC Lab\IVC_labs_starting_point\data\videos\foreman20_40_RGB';
% direc = dir(fullfile(path, '*.bmp'));%
function [mask] = BlockPartioning(im1, h_fac)
%BLOCKPARTIONING partions the given image into 16x16 and 4x4 blocks
% im1 is a YCbCr image

%im1 = imread(fullfile(path, direc(1).name));
%H_im1 = calc_entropy(stats_marg(double(im1), 0:255));

fracSize = 8;
%h_fac =1.1;

im1 = ictYCbCr2RGB(im1);
H_im1_frac = zeros(size(im1,1,2)/fracSize);

for row = 1:fracSize:size(im1,1)
    
    for col = 1:fracSize:size(im1, 2)
        
        rowEnd = min(row+fracSize-1, size(im1,1));
        colEnd = min(col+fracSize-1, size(im1,2));
        
        H_im1_frac(ceil((row-1)/8)+1, ceil((col-1)/8)+1) = ...
            calc_entropy(stats_marg(im1(row:rowEnd, col:colEnd, 1), 0:255));
    end
end

%H_im1_frac = reshape(H_im1_frac, ceil(size(im1(:,:,1))/fracSize));


H_mean = mean2(H_im1_frac);

% [rows, cols] = find(H_im1_frac < H_mean);

mask = zeros(size(H_im1_frac));

mask(H_im1_frac>=h_fac*H_mean) = 1;
%mask = mask'; %%%% Transposed
%% Debug
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ---------------------------------------------------------------------------------------

mask(:,1) = 0;
mask(1,:) = 0;

%% Visulazation for better understanding the partioning

% x = mask';
% x = x(:);
% k = 1;
% bigMask = zeros(size(im1(:,:,1)));
% for row = 1:fracSize:size(im1,1)
%     
%     for col = 1:fracSize:size(im1, 2)
%         rowEnd = min(row+fracSize-1, size(im1,1));
%         colEnd = min(col+fracSize-1, size(im1,2));
%         if x(k) == 1
%             bigMask(row:rowEnd , col:colEnd) = 1;
%         end
%         k = k+1;
%     end
% end
%  bigMask = repmat(bigMask, 1,1,3);
%  imshow(uint8(double(im1(:,:,1).*bigMask)))


end

