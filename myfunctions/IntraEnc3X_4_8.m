% Has additional functionality of choosing between three prediction modes
function [ I_run, pred_vec ] = IntraEnc3X_4_8(img2enc, qScale, EOB, h_fac)
%  Function Name : IntraEncX.m
%  Input         : image (Original YCbCr Image)
%                  qScale(quantization scale)
%  Output        : dst   (sequences after zero-run encoding, 1xN)
% Has additional functionality of choosing between three prediction modes
    %% Spatial Prediciton
%     I_spatPred= blockproc(img2enc, [16, 16], ...
%         @(block_struct) adjH264IntraPred2X( block_struct.data, block_struct.location, img2enc));
    
    %% Dct
    I_dct = blockproc((img2enc), [8,8], @(block_struct) DCT8x8(block_struct.data));
    %% Quantazation
    I_quant = blockproc(I_dct, [8,8], @(block_struct) Quant8x8(block_struct.data, qScale, h_fac));
    %% Dequantize
    I_dequant = blockproc(I_quant, [8,8], @(block_struct) DeQuant8x8(block_struct.data, qScale, h_fac));
    %% IDCT
     img = blockproc(I_dequant, [8,8], @(block_struct) IDCT8x8(block_struct.data)); 
%     %% Spatial Prediciton
    mask = BlockPartioning(img, h_fac);
    [I_err, pred_vec]  =  IntraPred3X_4_8(img, mask);
    
    %% Dct
    I_dct = blockproc((I_err), [8,8], @(block_struct) DCT8x8(block_struct.data));
    %% Quantazation
    I_quant =blockproc(I_dct, [8,8], @(block_struct) Quant8x8(block_struct.data, qScale, h_fac));
    
    %% Transform Coeff Prediction
%     [I_pred, ~] = IntraPredX(I_quant);
    
    %% Zig Zag Scan
    I_zig_zag = blockproc(I_quant, [8,8], @(block_struct) ZigZag8x8(block_struct.data));
    %% Zero Run encoding
    I_run = ZeroRunEnc_EoB_new(I_zig_zag(:), EOB);   


end



function [img_pred, pred_mode] = IntraPredX(img_quant)

    block_size = 8;
    pred_mode = [];
    img_pred = img_quant;
    k = 1;
    for row = block_size+1:block_size:size(img_quant,1)
        
        for col = block_size+1:block_size:size(img_quant,2)
%             m1 = mean2(abs(img_quant(row, col, :) -floor((img_quant(row-block_size, col, :) + img_quant(row, col-block_size, :))./2)));
%             m2 = mean2(abs(img_pred(row:row+block_size-1, col, :) -img_quant(row:row+block_size-1, col-block_size, :)));
%             m3 = mean2(abs(img_pred(row, col:col+block_size-1, :)  -img_quant(row-block_size, col:col+block_size-1, :)));
%             
%             m = abs([m1, m2, m3 ]);
            if true%m1 == min(m) %isequal(pred_mode, 1)
                est = floor((img_quant(row-block_size, col, :) + img_quant(row, col-block_size, :))./2);
                img_pred(row, col, :) =  (img_quant(row, col, :) - est);
                mean2( img_pred(row, col, :));
                pred_mode(k) = 1;
%             elseif m2 == min(m) %isequal(pred_mode, 2)
%                 est = img_quant(row:row+block_size-1, col-block_size, :);
%                 img_pred(row:row+block_size-1, col, :) = img_pred(row:row+block_size-1, col, :) - est;
%                 mean2(img_pred(row:row+block_size-1, col, :));
%                 pred_mode(k) = 2;
%             elseif m3 == min(m) %isequal(pred_mode, 3)
%                 est = img_quant(row-block_size, col:col+block_size-1, :);
%                 img_pred(row, col:col+block_size-1, :) = img_pred(row, col:col+block_size-1, :)  - est;
%                 pred_mode(k) = 3;
            end           
%             rec = img_pred(row, col, :) + floor((img_pred(row-block_size, col, :) + img_pred(row, col-block_size, :))/2);
%             diff = rec - img_quant(row, col, :)
        k = k+1;
        end
        
    end
    
    


end

