function [mv, err_block] = LogarithmicSearch(ref_img, curr_block, loc, max_displacement_vec)

n = max(2, 2^(ceil(log2(max_displacement_vec))-1));
x_mv = 0;
y_mv = 0;
img_size = size(ref_img);
block_size = size(curr_block,1,2);
pad_size = max(block_size-1, max_displacement_vec);
ref_img = padarray(ref_img, pad_size,  'symmetric');
pos = loc + pad_size;
row = pos(1);
col = pos(2);

sad = inf;
sad_prev = -666;
for n_curr = n:-1:1
    
    while n_curr>1
    
        avail_xmv_ymv = get_AvaidableLogSearchModes(n_curr, y_mv, x_mv, loc, max_displacement_vec, img_size, block_size);
        for i = 1:size(avail_xmv_ymv,1)
            
            mode = avail_xmv_ymv(i,1);
            x_mv_tmp = avail_xmv_ymv(i,2);
            y_mv_tmp = avail_xmv_ymv(i,3);
            
            block_tmp = ref_img(row+y_mv_tmp:row+y_mv_tmp+block_size(1)-1, col+x_mv_tmp:col+x_mv_tmp+block_size(2)-1, :);
            sad_tmp = sum(abs(block_tmp(:,:,1) - curr_block(:,:,1)), 'all', 'omitnan');
            if sad_tmp<sad
                x_mv = x_mv_tmp;
                y_mv = y_mv_tmp;
                sad = sad_tmp;
            end
        end
        if sad_prev == sad 
            break;
        else
            sad_prev = sad;
        end
    end
    
    if isequal(n_curr,1)
       
        avail_xmv_ymv =  get_AvaidableLogSearchEndModes(x_mv, y_mv, loc, max_displacement_vec, img_size, block_size);
        sad = inf;
        for i = 1:size(avail_xmv_ymv,1)
            
            mode = avail_xmv_ymv(i,1);
            x_mv_tmp = avail_xmv_ymv(i,2);
            y_mv_tmp = avail_xmv_ymv(i,3);
            block_tmp = ref_img(row+y_mv+y_mv_tmp:row+y_mv+y_mv_tmp+block_size(1)-1, col+x_mv+x_mv_tmp:col+x_mv+x_mv_tmp+block_size(2)-1, :);
            sad_tmp = sum(abs(block_tmp(:,:,1) - curr_block(:,:,1)), 'all','omitnan');
            
            if sad_tmp < sad
                err_block = curr_block - block_tmp;
                % vertauscht
                mv = sub2ind((2*max_displacement_vec+1).*[1,1], y_mv+y_mv_tmp+max_displacement_vec+1, x_mv+x_mv_tmp+max_displacement_vec+1);
                sad = sad_tmp;
            end
            
        end
        
    end
    
end



end


