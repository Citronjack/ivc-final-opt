function [err_img, pred_vec] =  IntraPred3X_4_8(img, mask)

pred_size = 8;
img_size = size(img);
err_img = zeros(size(img));
k = 1;
pred_vec = [];
for row = 1:pred_size:img_size(1)

    for col = 1:pred_size:img_size(2)
        
        rowEnd = min(img_size(1), row+pred_size-1);
        colEnd = min(img_size(2), col+pred_size-1);
        
        %% 4x4 PRediction
        if mask(floor(row/8)+1, floor(col/8)+1) == 1
            
            for row_4x4 = 1:4:8
                
                for col_4x4 = 1:4:8
                    rowEnd_4x4 = row_4x4+3;
                    colEnd_4x4 = col_4x4+3;
                    
                    [vert, horz, M] = get_VertHorzM(img, pred_size, col+col_4x4-1, row+row_4x4-1);
                    avail = get_avaidableModes(vert, horz, M);
                    
                    [err_block, pred_mode] = H264_predY( img(row+row_4x4-1:row-1+ rowEnd_4x4, col+col_4x4-1:col-1+colEnd_4x4, :),...
                        horz, vert, M, avail);
                    
                    err_img(row+row_4x4-1:row-1+ rowEnd_4x4, col+col_4x4-1:col-1+colEnd_4x4, :)= ...
                        err_block;
                    
                    pred_vec(k) = pred_mode;
                    k = k+1;
                end
                
            end
            
        end
        %% 8x8 PRediction
        if mask(floor(row/8)+1, floor(col/8)+1) == 0
            [vertY, horzY] = get_VertHorzM_YCbCr(img, pred_size, col, row);
            
            [err_8x8, pred_mode_8x8] = H264_pred_YCbCr(img(row:rowEnd, col:colEnd, :), ...
                vertY, horzY);
            %H264_pred8x8_YCbCr(img vert8, horz8)
            err_img(row:rowEnd, col:colEnd, :) = err_8x8;
            pred_vec(k) = pred_mode_8x8+10;
            k = k+1;
        end
    end
    
end
        




end