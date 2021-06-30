function [err_block, pred_mode] = H264_pred_YCbCr(img_block, vertYCbCr, horzYCbCr)
%H264_PRED8X8_YCBCR This function predicts and computes the error to an prediction of the given
%block, function is writen such that either only CbCr or Y or YCbCr are
%predicted
%   Detailed explanation goes here

%% Init variables
err_block = img_block;
best_cost = inf;
pred_mode = 0;
pred_size = size(img_block, 1);
try_block = zeros(pred_size,pred_size, 3);
%% Check avaidability of modes
avail = get_avaidableModes_YCbCr(vertYCbCr, horzYCbCr);

%% To prediciton
for i = 1:4
   mode = i*avail(i);
   
   switch mode
       case 0 %incase the mode is not avaidable
           true;%err_block = img_block;
       case 1
           try_block = repmat(horzYCbCr, [pred_size,1]);
       case 2
           try_block = repmat(vertYCbCr, [1, pred_size]);
       case 3
           try_block = repmat((mean(vertYCbCr)+ mean(horzYCbCr))./2, [pred_size, pred_size]);
%        case 4
%            try_block = 1;
                  
   end
   
   if mode > 0
       try_cost = sum(abs(img_block - try_block), 'all');
       
       if try_cost < best_cost
           best_cost = try_cost;
           err_block = (img_block - try_block);
           pred_mode = mode;
       end
   end  
    
    
end


end

