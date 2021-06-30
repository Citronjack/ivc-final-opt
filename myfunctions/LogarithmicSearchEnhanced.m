function [mv, err_block, mot_mode] = LogarithmicSearchEnhanced(ref_img, curr_block, loc, max_displacement)

row = loc(1);
col = loc(2);
sad = inf;
for i = 1:6
    mot_mode_tmp = i;
    switch i
        
        % 8x8 block
        case 1
            [mv_tmp, err_block_tmp] = LogarithmicSearch(ref_img, curr_block, [row, col], max_displacement);
            sad_tmp = sum(abs(err_block_tmp), 'all');
            
            % 2 times 4x8
        case 2
            row_step = 4;
            col_step = 8;
            
            % 2 times 8x4
        case 3
            row_step = 8;
            col_step = 4;
            % 4 times 4x4
        case 4
            row_step = 4;
            col_step = 4;
            % diagonal from top left to bottom right i.e upper triangle
        case 5
            do_flip = false;
            [err_block_tmp, mv_tmp, sad_tmp] = LogBlockCalcTriangle(row, col, ref_img, curr_block, max_displacement, do_flip);
            % diagonal from bottom left to top right
        case 6
            do_flip = true;
            [err_block_tmp, mv_tmp, sad_tmp] = LogBlockCalcTriangle(row, col, ref_img, curr_block, max_displacement, do_flip);
    end
    if i >  1 && i<=4
%         
        [err_block_tmp, mv_tmp, sad_tmp] = LogBlockCalcRect(row, col, row_step, col_step, ref_img, curr_block, max_displacement);
    end
    
    if sad_tmp < sad
        sad = sad_tmp;
        mv = mv_tmp;
        err_block = err_block_tmp;
        mot_mode = mot_mode_tmp;
    end
    
    
    
end

end