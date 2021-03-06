function rgb = ictYCbCr2RGB(yuv)
% Input         : yuv (Original YCbCr image)
% Output        : rgb (RGB Image after transformation)
    rgb = zeros(size(yuv));
    yuv = double(yuv);
    rgb(:,:,1) = yuv(:,:,1) + 1.402*yuv(:,:,3);
    rgb(:,:,2) = yuv(:,:,1) - 0.344*yuv(:,:,2) - 0.714*yuv(:,:,3);
    rgb(:,:,3) = yuv(:,:,1) + 1.772*yuv(:,:,2);

end