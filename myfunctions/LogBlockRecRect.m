function rec_block = LogBlockRecRect(row, col, row_step, col_step, ref_img, mv, err_block, max_displacement)

k = 1;
[row_max, col_max] = size(err_block,1,2);
rec_block = zeros(size(err_block));
for row_tmp = 1:row_step:row_max
    
    for col_tmp = 1:col_step:col_max
        rowEnd_tmp = row_tmp+row_step-1;
        colEnd_tmp = col_tmp+col_step-1;
        mv_tmp = mv(k);
        
        rec_Smallblock = LogarithmicComp(ref_img, err_block(row_tmp:rowEnd_tmp, col_tmp:colEnd_tmp, :), mv_tmp, [row, col], max_displacement);
        
        rec_block(row_tmp:rowEnd_tmp, col_tmp:colEnd_tmp, :) = rec_Smallblock;
        k = k+1;
        
    end
end

end