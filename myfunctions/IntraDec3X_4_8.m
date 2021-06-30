function [I_rec] = IntraDec3X_4_8( I_run, pred_vec, img_size , qScale, EOB, h_fac )
%INTRADECX Decodes the run length code encoded 
%   Detailed explanation goes here
    
    %% DE-ZigZag
    I_dec_zero_run = ZeroRunDec_EoB_new(I_run, EOB);
    %% Zero Run decode
    I_dec_zero_run = reshape(I_dec_zero_run, [img_size(1)*8, prod(img_size)/(img_size(1)*8)]); 
    I_zig_zag = blockproc(I_dec_zero_run, [64,3], @(block_struct) DeZigZag8x8(block_struct.data));
    %% DCT DC Depredict
%     I_depred = IntraDePredX(I_zig_zag, 1);
    %% Dequantize
    I_dequant = blockproc(I_zig_zag, [8,8], @(block_struct) DeQuant8x8(block_struct.data, qScale, h_fac));
    %% IDCT
    err_im = blockproc(I_dequant, [8,8], @(block_struct) IDCT8x8(block_struct.data)); 
    %% Depred Spatial
    %I_rec = DePredX(img, pred_vec, img_size);
    I_rec = IntraDePred3X_4_8(err_im, pred_vec);
    %dst = ictYCbCr2RGB(dst);
    
    
end

function img_depred = IntraDePredX(img_err, pred_mode_2)

    block_size = 8;
    img_depred = img_err;
%     for row = block_size+1:block_size:size(img_err,1)
%         
%         for col = block_size+1:block_size:size(img_err,2)
%             est =  floor((img_depred(row-block_size, col, :) + img_depred(row, col-block_size, :))./2);
%             img_depred(row, col, :) =  img_err(row, col, :) + est;
%         end
%         
%     end

    k = 1;
%     load('pred_mode')
    for row = block_size+1:block_size:size(img_depred,1)
        
        for col = block_size+1:block_size:size(img_depred,2)
%             m1 = mean2(abs(img_err(row, col, :) +floor((img_depred(row-block_size, col, :) + img_depred(row, col-block_size, :))./2)));
%             m2 = mean2(abs(img_err(row:row+block_size-1, col, :) +img_depred(row:row+block_size-1, col-block_size, :)));
%             m3 = mean2(abs(img_err(row, col:col+block_size-1, :)  +img_depred(row-block_size, col:col+block_size-1, :)));
%             m1 = mean2(abs(img_err(row, col, :)));
%             m2 = mean2(abs(img_err(row:row+block_size-1, col, :)));
%             m3 = mean2(abs(img_err(row, col:col+block_size-1, :)));
%             m = abs([m1, m2, m3 ]);
% 
%             pred_mode_2 =pred_mode(k);
            if true %isequal(pred_mode_2, 1)
                est = floor((img_depred(row-block_size, col, :) + img_depred(row, col-block_size, :))./2);
                img_depred(row, col, :) =  (img_err(row, col, :) + est);
                mean2(img_depred(row, col, :));
                %pred_mode(k) = 1;
%             elseif isequal(pred_mode_2, 2)
%                 est = img_depred(row:row+block_size-1, col-block_size, :);
%                 img_depred(row:row+block_size-1, col, :) = img_err(row:row+block_size-1, col, :) + est;
%                 mean2(img_depred(row:row+block_size-1, col, :));
%                 %pred_mode(k) = 2;
%             elseif isequal(pred_mode_2, 3)
%                 est = img_depred(row-block_size, col:col+block_size-1, :);
%                 img_depred(row, col:col+block_size-1, :) = img_err(row, col:col+block_size-1, :) + est;
%                 %pred_mode(k) = 3;
            end           
%             rec = img_pred(row, col, :) + floor((img_pred(row-block_size, col, :) + img_pred(row, col-block_size, :))/2);
%             diff = rec - img_quant(row, col, :)
        k = k+1;
        end
    end

end