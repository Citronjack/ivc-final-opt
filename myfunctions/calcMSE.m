function MSE = calcMSE(Image, recImage)
% Input         : Image    (Original Image)
%                 recImage (Reconstructed Image)
% Output        : MSE      (Mean Squared Error)
% YOUR CODE HERE
   %w,h,c = size(Image)
   %simulated input
   %Image = imread('smandril.tif');
   %recImage = imread('smandril_rec.tif');
   
   [w,h,c] = size(Image);
   diff_Y = (double(Image) - double(recImage)).^2;
   sum_Y = sum(sum(sum(diff_Y)));
   MSE = 1/(w*h*c)*sum_Y;

end





