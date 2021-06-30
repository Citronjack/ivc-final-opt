function [I_rec] = DePred_V2(err_img, pred_vec)
%DEPRED_V2 Summary of this function goes here
%   Detailed explanation goes here
I_rec = err_img;
k = 1;
img_size = size(I_rec);
pred_size = 8;

%% Debug
pred_vec = pred_vec+10;

%% DePrediciton loop
for row = 1:pred_size:img_size(1)

    for col = 1:pred_size:img_size(2)
        
        pred_mode = pred_vec(k);
        rowEnd = min(img_size(1), row+7);
        colEnd = min(img_size(2), col+7);
        row_offset = double(row>1);
        col_offset =  double(col>1);
        if pred_mode <= 9
            pred_mode = pred_vec(k:k+15);
            rowStart = max(1, row-1);
            colEnd2 = min(img_size(2), colEnd+4);
            colStart = max(1, col-1);
            I_rec(row:rowEnd, col:colEnd,:) = DecPred_4x4(pred_mode, [row, col], ...
                I_rec(rowStart:rowEnd, colStart:colEnd2,:), [row_offset, col_offset]);
            k = k+16;
        elseif pred_mode >= 10
            
            [vert, horz] = get_VertHorzM_YCbCr(I_rec, pred_size, col, row);
            I_rec(row:rowEnd, col:colEnd,:) = DecPred_8x8(I_rec(row:rowEnd, col:colEnd,:), ...
                pred_mode, vert, horz);
            k = k+1;
        else
            disp('Error occured')
        end
         
        
        
    end
   
end


end

