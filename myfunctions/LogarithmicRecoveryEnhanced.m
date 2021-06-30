function rec_block = LogarithmicRecoveryEnhanced(ref_img, err_block, mv, mot_mode, loc, max_displacement)

row = loc(1);
col = loc(2);

switch mot_mode
    
    % 8x8 block
    case 1
        %[mv_tmp, err_block_tmp] = LogarithmicSearch(ref_img, curr_block, [row, col], max_displacement);
        rec_block =  LogarithmicComp(ref_img, err_block, mv, loc, max_displacement);
        
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
        %[err_block_tmp, mv_tmp, sad_tmp] = LogBlockCalcTriangle(row, col, ref_img, curr_block, max_displacement, do_flip);
        rec_block = LogBlockRecTriangle(row, col, ref_img, mv, err_block, max_displacement, do_flip);
        % diagonal from bottom left to top right
    case 6
        do_flip = true;
        rec_block = LogBlockRecTriangle(row, col, ref_img, mv, err_block, max_displacement, do_flip);
        %[err_block_tmp, mv_tmp, sad_tmp] = LogBlockCalcTriangle(row, col, ref_img, curr_block, max_displacement, do_flip);
end
if mot_mode >  1 && mot_mode<=4
    %
    rec_block = LogBlockRecRect(row, col, row_step, col_step, ref_img, mv, err_block, max_displacement);
    %[err_block_tmp, mv_tmp, sad_tmp] = LogBlockCalcRect(row, col, row_step, col_step, ref_img, curr_block, max_displacement);
end





end