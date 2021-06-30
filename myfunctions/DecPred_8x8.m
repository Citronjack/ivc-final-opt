function [rec_block] = DecPred_8x8(err_block, pred_mode, vert, horz)
%DECPRED_8X8 This function inverts the previously made prediction
%   Detailed explanation goes here

pred_mode = pred_mode - 10;
pred_block = zeros(8,8,3);
pred_size = 8;


switch pred_mode
    case 0 %incase the mode is not avaidable
        pred_block = zeros(pred_size,pred_size,3);
    case 1
        pred_block = repmat(horz, [pred_size,1]);
    case 2
        pred_block = repmat(vert, [1, pred_size]);
    case 3
        pred_block = repmat((mean(vert)+ mean(horz))./2, [pred_size, pred_size]);
        %        case 4
        %            try_block = 1;
end      

rec_block = err_block + pred_block;


end

