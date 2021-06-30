function [err_block, mv, sad] = LogBlockCalcRect(row, col, row_step, col_step, ref_img, curr_block, max_displacement)

sad = 0;
k = 1;
[row_max, col_max] = size(curr_block,1,2);

for row_tmp = 1:row_step:row_max
    
    for col_tmp = 1:col_step:col_max
        rowEnd_tmp = row_tmp+row_step-1;
        colEnd_tmp = col_tmp+col_step-1;
        
        [mv_part_tmp, err_Smallblock_tmp] = LogarithmicSearch(ref_img, curr_block(row_tmp:rowEnd_tmp, col_tmp:colEnd_tmp, :), ...
            [row, col], max_displacement);
        sad = sad + sum(abs(err_Smallblock_tmp), 'all', 'omitnan');
        err_block(row_tmp:rowEnd_tmp, col_tmp:colEnd_tmp, :) = err_Smallblock_tmp;
        mv(k) = mv_part_tmp;
        k = k+1;
        
    end
end

end