function avail_xmv_ymv  = get_AvaidableLogSearchModes(n_curr, x_mv, y_mv, loc, max_displacement_vec, img_size, block_size)
%% This function checks if the different displacements (called modes) are avaidable 
k  = 2;
avail_xmv_ymv = [0, x_mv, y_mv];

row_max = img_size(1);
col_max = img_size(2);

row = loc(1);
col = loc(2);

%% Check if modes are avaidable
if ((row+(y_mv-n_curr)) >= -block_size(1)+1) && (abs(y_mv-n_curr) <= max_displacement_vec)
    avail_xmv_ymv(k,1) = 1;
    avail_xmv_ymv(k,2) = x_mv;
    avail_xmv_ymv(k,3) = y_mv-n_curr;
    k = k+1;
end

if ((col+(x_mv+n_curr)) <= col_max) && (abs(x_mv+n_curr) <= max_displacement_vec)
    avail_xmv_ymv(k,1) = 2;
    avail_xmv_ymv(k,2) = x_mv+n_curr;
    avail_xmv_ymv(k,3) = y_mv;
    k = k+1;
end

if ((row+(y_mv+n_curr)) <= row_max) && (abs(y_mv+n_curr) <= max_displacement_vec)
    avail_xmv_ymv(k,1) = 3;
    avail_xmv_ymv(k,2) = x_mv;
    avail_xmv_ymv(k,3) = y_mv+n_curr;
    k = k+1;
end

if ((col+(x_mv-n_curr)) >= -block_size(2)+1) && (abs(x_mv-n_curr) <= max_displacement_vec)
    avail_xmv_ymv(k,1) = 4;
    avail_xmv_ymv(k,2) = x_mv-n_curr;
    avail_xmv_ymv(k,3) = y_mv;
    k = k+1;
end




end