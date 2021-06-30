function [rec_img] =  IntraDePred3X_4_8(err_img, pred_vec)

pred_size = 8;
img_size = size(err_img);
rec_img = zeros(img_size);
k = 1;

for row = 1:pred_size:img_size(1)

    for col = 1:pred_size:img_size(2)
        
        rowEnd = min(img_size(1), row+pred_size-1);
        colEnd = min(img_size(2), col+pred_size-1);
        
        %% 4x4 PRediction
        if pred_vec(k) <= 9
            
            for row_4x4 = 1:4:8
                
                for col_4x4 = 1:4:8
                    rowEnd_4x4 = row_4x4+3;
                    colEnd_4x4 = col_4x4+3;
                                        
                    pred_mode= pred_vec(k);
                    k = k+1;
                    
                    [vert, horz, M] = get_VertHorzM(rec_img, pred_size, col+col_4x4-1, row+row_4x4-1);
                    avail = get_avaidableModes(vert, horz, M);
                    
                    rec_block = DoSinglePred4x4(err_img(row+row_4x4-1:row-1+ rowEnd_4x4, col+col_4x4-1:col-1+colEnd_4x4, :), ...
                        pred_mode, vert, horz, M);
                    
                    rec_img(row+row_4x4-1:row-1+ rowEnd_4x4, col+col_4x4-1:col-1+colEnd_4x4, :)= ...
                        rec_block;

                end
                
            end
            
        
        %% 8x8 PRediction
        elseif pred_vec(k) >= 10
            pred_mode = pred_vec(k);
            k = k+1;
            [vert, horz] = get_VertHorzM_YCbCr(rec_img, pred_size, col, row);
            
            rec_block = DecPred_8x8(err_img(row:rowEnd, col:colEnd,:), ...
                pred_mode, vert, horz);
            
            rec_img(row:rowEnd, col:colEnd,:) = rec_block;
            

        end
    end
    
end
        




end