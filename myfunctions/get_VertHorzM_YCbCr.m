function [vertYCbCr, horzYCbCr] = get_VertHorzM_YCbCr(img, frac_size, col, row)
%GET_VERTHORZM_8X8_YCBCR Gives the Vertical and Horzizontal vectros on
%which the prediciton is based on - supports all sizes
rowEnd = row+frac_size-1;
colEnd = col+frac_size-1;

vertYCbCr = NaN;
horzYCbCr = NaN;

if col>1 && colEnd <= size(img,2)
    vertYCbCr = img(row:rowEnd, col-1, :);
end 

if row > 1 && rowEnd <= size(img,1)
    horzYCbCr = img(row-1, col:colEnd, :);
end

end

