function [ rec_img] = LogMotRec_4_8( err_img, ref_img, mv_coeffs, mot_mode_coeffs, max_displacement)

block_size = [8,8];
rec_img = zeros(size(err_img));
k = 1;
t = 1;

for row = 1:block_size(1):size(rec_img, 1)
    
    for col = 1:block_size(2):size(rec_img, 2)
        
        rowEnd = min(row+block_size(1)-1,size(err_img, 1));
        colEnd = min(col+block_size(2)-1,size(err_img, 2));
        
        mot_mode = mot_mode_coeffs(t);
        countDoku = numberOfMVs(mot_mode);
        mv = mv_coeffs(k:k+countDoku-1);
        k = k+countDoku;
        t = t+1;
        
        rec_block = LogarithmicRecoveryEnhanced(ref_img, err_img(row:rowEnd, col:colEnd,:), mv, mot_mode, [row, col], max_displacement);
        rec_img(row:rowEnd, col:colEnd, :) = rec_block;           

        
    end
    
end


end
