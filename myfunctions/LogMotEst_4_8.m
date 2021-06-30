function [ err_img, mv_coeffs, mot_mode_coeffs] = LogMotEst_4_8( ref_img, curr_img, max_displacement)

block_size = [8,8];
err_img = zeros(size(curr_img));
k = 1;
t = 1;

for row = 1:block_size(1):size(curr_img, 1)
    
    for col = 1:block_size(2):size(curr_img, 2)
        
        rowEnd = min(row+block_size(1)-1,size(curr_img, 1));
        colEnd = min(col+block_size(2)-1,size(curr_img, 2));
        
        %[mv, err_block] = LogarithmicSearch(ref_img, curr_img(row:rowEnd, col:colEnd,:), [row, col], max_displacement_vec);
        [mv, err_block, mot_mode] = LogarithmicSearchEnhanced(ref_img, curr_img(row:rowEnd, col:colEnd,:), [row, col], max_displacement);
        
        err_img(row:rowEnd, col:colEnd, :) = err_block;
        mot_mode_coeffs(t) = mot_mode;
        m = length(mv);
        mv_coeffs(k:k+m-1) = mv;
        k = k+m;
        t=t+1;
           
    end
    
end


end