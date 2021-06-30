%% Chapter 4 and 5 curves

bpp_img_4 =  struct2array(load('bpp_img_final.mat'))
psnr_img_4 = struct2array(load('psnr_img_final.mat'))

bpp_vid_5 = struct2array(load('bpp_video_final.mat'))
psnr_vid_5 = struct2array(load('psnr_video_final.mat'))

bpp_vid_opt_8x8 = struct2array(load('bpp_vid_only8x8.mat'))
psnr_vid_opt_8x8 = struct2array(load('psnr_P_vid_only8x8.mat'))
psnr_img_opt_8x8 = psnr_vid_opt_8x8(1:2:end);
psnr_vid_opt_8x8 = psnr_vid_opt_8x8(2:2:end);
bpp_img_opt_8x8 = struct2array(load('bpp_img_only8x8.mat'))

bpp_img_opt_4x4 = struct2array(load('bpp_img_hfac105.mat'))
bpp_vid_opt_4x4 = struct2array(load('bpp_vid_hfac105.mat'))
psnr_vid_opt_4x4 = struct2array(load('psnr_vid_hfac105.mat'))
psnr_img_opt_4x4 = struct2array(load('psnr_img_hfac105.mat'))

grid on
figure(11)
hold on 
    plot(bpp_img_4,psnr_img_4 ,'-*', 'linewidth', 2, 'color', 'r')    
    plot(bpp_vid_5, psnr_vid_5,'-*', 'linewidth', 2, 'color', 'b')
    
    plot(bpp_img_opt_8x8,psnr_img_opt_8x8 ,'--x', 'linewidth', 2, 'color', 'g')    
    plot(bpp_vid_opt_8x8, psnr_vid_opt_8x8,'--x', 'linewidth', 2, 'color', 'c')
    
    plot(bpp_img_opt_4x4,psnr_vid_opt_4x4 ,':s', 'linewidth', 2, 'color', 'm')
    plot(bpp_vid_opt_4x4, psnr_img_opt_4x4,':s', 'linewidth', 2, 'color', 'k')
    
    
    legend('Image Codec Chap 4', 'Video Codec Chap 5','Image Codec Opt. only 8x8', 'Video Codec Opt. only 8x8', 'Image Codec Opt. h\_fac = 1.05', 'Video Codec Opt. h\_fac = 1.05', 'FontSize',25)

title('BPP to PSNR Plot for qScales [0.07, 0.2, 0.4, 0.8, 1.0, 1.5, 2, 3, 4.1, 4.5]', 'FontSize',25)
xlabel('BPP [bit/pixel]', 'FontSize',30)
ylabel('PSNR [dB]', 'FontSize',30)
ax = gca;
ax.YAxis.FontSize = 20;
ax.XAxis.FontSize = 20;


