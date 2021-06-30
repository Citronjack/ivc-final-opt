function [avail_xmv_ymv] = get_AvaidableLogSearchEndModes(x_mv, y_mv, loc, max_displacement_vec, img_size, block_size)
%GET_AVAIDABLELOGSEARCHENDMODES gives back which of the 9 possible modes in
%for n = 1 are avaidable with corresponding movement vectors
k = 1;

y_mv_mat = repmat([-1;0;1], [1,3]);
x_mv_mat = repmat([-1,0,1], [3,1]);

row = loc(1);
col = loc(2);
row_max = img_size(1);
col_max = img_size(2);

for i = 1:9
    x_mv_tmp = x_mv_mat(i);
    y_mv_tmp = y_mv_mat(i);
    
    if ((col+(x_mv+ x_mv_tmp)) >= -block_size(2)+1) && ((col+(x_mv+ x_mv_tmp)) <= col_max) && ...
            ((row+(y_mv+y_mv_tmp)) >= -block_size(1)+1) && ((row+(y_mv+y_mv_tmp)) <= row_max) && ...
            (abs(x_mv+ x_mv_tmp) <= max_displacement_vec) && (abs(y_mv+ y_mv_tmp) <= max_displacement_vec)
        avail_xmv_ymv(k,1) = i;
        avail_xmv_ymv(k,3) = y_mv_tmp;
        avail_xmv_ymv(k,2) = x_mv_tmp;
        k = k+1;
        
    end
    

end

end

