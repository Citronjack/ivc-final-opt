function [ err_block, pred_mode ] = H264_predY(img_block, horz, vert,  M, avail_vec)
%H264_PREDY This funciton finds the optimal prediciton block and
% calculates the error to the image block, ONLY FOR Y
%   Detailed explanation goes here
err_block = img_block;
try_block = zeros(4,4,3);
best_cost = inf;
pred_mode = 0;

for i = 1:length(avail_vec)
    mode = i*avail_vec(i);
    %% switch mode to go through all avaidable prediciton modes
    switch mode
        case 0 % in case the mode is not avaidable
            true;
            
        case 1 %vertical mode
            try_block = repmat(horz(1, 1:4, :), [4,1]);
            
        case 2 % horizontal mode
            try_block = repmat(vert(1:4, 1, :), [1,4]);
            
        case 3
            m_vert_horz = mean([horz(1, 1:4, :), permute(vert, [2,1,3])]);
            try_block = repmat(m_vert_horz, [4,4,1]);
            
        case 4
            try_block(1,1) = horz(1, 2,1);
            try_block([2;5]) = horz(1,3,1);
            try_block([3;6;9]) = horz(1,4,1);
            try_block([4;7;10;13]) = horz(1,5,1);
            try_block([8;11;14]) = horz(1,6,1);
            try_block([12;15]) = horz(1,7,1);
            try_block([16]) = horz(1,8,1);
            
            offset = 16;
            try_block(1 + offset) = horz(1,2,2);
            try_block([2;5] + offset) = horz(1,3,2);
            try_block([3;6;9] + offset) = horz(1,4,2);
            try_block([4;7;10;13] + offset) = horz(1,5,2);
            try_block([8;11;14] + offset) = horz(1,6,2);
            try_block([12;15] + offset) = horz(1,7,2);
            try_block([16] + offset) = horz(1,8,2);
            
            offset = 32;
            try_block(1 + offset) = horz(1,2,3);
            try_block([2;5] + offset) = horz(1,3,3);
            try_block([3;6;9] + offset) = horz(1,4,3);
            try_block([4;7;10;13] + offset) = horz(1,5,3);
            try_block([8;11;14] + offset) = horz(1,6,3);
            try_block([12;15] + offset) = horz(1,7,3);
            try_block([16] + offset) = horz(1,8,3);
            
        case 5
            try_block([4]) = vert(3,1,1);
            try_block([3;8]) = vert(2,1,1);
            try_block([2;7;12]) = vert(1,1,1);
            try_block([1;6;11;16]) = M(1,1,1);
            try_block([5;10;15]) = horz(1,1,1);
            try_block([9;14]) = horz(1,2,1);
            try_block([13]) =  horz(1,3,1);
            
            offset = 16;
            try_block([4] + offset) = vert(3,1,2);
            try_block([3;8] + offset) = vert(2,1,2);
            try_block([2;7;12] + offset) = vert(1,1,2);
            try_block([1;6;11;16] + offset) =  M(1,1,2);
            try_block([5;10;15] + offset) = horz(1,1,2);
            try_block([9;14] + offset) = horz(1,2,2);
            try_block([13] + offset) =  horz(1,3,2);
            
            offset = 32;
            try_block([4] + offset) = vert(3,1,3);
            try_block([3;8] + offset) = vert(2,1,3);
            try_block([2;7;12] + offset) = vert(1,1,3);
            try_block([1;6;11;16] + offset) = M(1,1,3);
            try_block([5;10;15] + offset) = horz(1,1,3);
            try_block([9;14] + offset) = horz(1,2,3);
            try_block([13] + offset) =  horz(1,3,3);
            
        case 6
            
            try_block([4]) = vert(2,1,1);
            try_block([3]) = vert(1,1,1);
            try_block([2;8]) = M(1,1,1);
            try_block([1;7]) = mean([M(1,1,1), horz(1,1,1)]);
            try_block([6;12]) = horz(1,1,1);
            try_block([5;11]) = mean(horz(1,1:2,1));
            try_block([10;16]) = horz(1,2,1);
            try_block([9;15]) = mean([horz(1,2,1), horz(1,3,1)]);
            try_block([14]) = horz(1,3,1);
            try_block([13]) = mean(horz(1,3:4,1));
            
            offset = 16;
            try_block([4]+offset) = vert(2,1,2);
            try_block([3]+offset) = vert(1,1,2);
            try_block([2;8]+offset) = M(1,1,2);
            try_block([1;7]+offset) = mean([M(1,1,2), horz(1,1,2)]);
            try_block([6;12]+offset) = horz(1,1,2);
            try_block([5;11]+offset) = mean(horz(1,1:2,2));
            try_block([10;16]+offset) = horz(1,2,2);
            try_block([9;15]+offset) = mean([horz(1,2,2), horz(1,3,2)]);
            try_block([14]+offset) = horz(1,3,2);
            try_block([13]+offset) = mean(horz(1,3:4,2));
            
            offset = 32;
            try_block([4]+offset) = vert(2,1,3);
            try_block([3]+offset) = vert(1,1,3);
            try_block([2;8]+offset) = M(1,1,3);
            try_block([1;7]+offset) = mean([M(1,1,3), horz(1,1,3)]);
            try_block([6;12]+offset) = horz(1,1,1);
            try_block([5;11]+offset) = mean(horz(1,1:2,3));
            try_block([10;16]+offset) = horz(1,2,3);
            try_block([9;15]+offset) = mean([horz(1,2,3), horz(1,3,3)]);
            try_block([14]+offset) = horz(1,3,3);
            try_block([13]+offset) = mean(horz(1,3:4,3));
            
        case 7
            offset = 0;
            try_block([4+offset]) = mean(vert(3:4,1,1));
            try_block([8]+offset) = vert(3,1,1);
            try_block([3;12]+offset) = mean(vert(2:3,1,1));
            try_block([7;16]+offset) = vert(2,1,1);
            try_block([2;11]+offset) = mean(vert(1:2,1,1));
            try_block([6;15]+offset) = vert(1,1,1);
            try_block([1;10]+offset) = mean([M(1,1,1), vert(1,1,1)]);
            try_block([5;14]+offset) = M(1,1,1);
            try_block([9]+offset) = horz(1,1,1);
            try_block([13]+offset) = horz(1,2,1);
            
            offset = 16;
            try_block([4+offset]) = mean(vert(3:4,1,2));
            try_block([8]+offset) = vert(3,1,2);
            try_block([3;12]+offset) = mean(vert(2:3,1,2));
            try_block([7;16]+offset) = vert(2,1,2);
            try_block([2;11]+offset) = mean(vert(1:2,1,2));
            try_block([6;15]+offset) = vert(1,1,2);
            try_block([1;10]+offset) = mean([M(1,1,2), vert(1,1,2)]);
            try_block([5;14]+offset) = M(1,1,2);
            try_block([9]+offset) = horz(1,1,2);
            try_block([13]+offset) = horz(1,2,2);
            
            offset = 32;
            try_block([4+offset]) = mean(vert(3:4,1,3));
            try_block([8]+offset) = vert(3,1,3);
            try_block([3;12]+offset) = mean(vert(2:3,1,3));
            try_block([7;16]+offset) = vert(2,1,3);
            try_block([2;11]+offset) = mean(vert(1:2,1,3));
            try_block([6;15]+offset) = vert(1,1,3);
            try_block([1;10]+offset) = mean([M(1,1,3), vert(1,1,3)]);
            try_block([5;14]+offset) = M(1,1,3);
            try_block([9]+offset) = horz(1,1,3);
            try_block([13]+offset) = horz(1,2,3);
            
        case 8
            offset = 0;
            try_block([1]+offset) = mean(horz(1,1:2,1));
            try_block([2]+offset) = horz(1,2,1);
            try_block([3;5]+offset) = mean(horz(1,2:3,1));
            try_block([6;4]+offset) = horz(1,3,1);
            try_block([7;9]+offset) = mean(horz(1,3:4,1));
            try_block([8;10]+offset) = horz(1,4,1);
            try_block([11;13]+offset) = mean(horz(1,4:5,1));
            try_block([12;14]+offset) = horz(1,5,1);
            try_block([15]+offset) = mean(horz(1,5:6,1));
            try_block([16]+offset) = horz(1,6,1);
            
            offset = 16;
            try_block([1]+offset) = mean(horz(1,1:2,2));
            try_block([2]+offset) = horz(1,2,2);
            try_block([3;5]+offset) = mean(horz(1,2:3,2));
            try_block([6;4]+offset) = horz(1,3,2);
            try_block([7;9]+offset) = mean(horz(1,3:4,2));
            try_block([8;10]+offset) = horz(1,4,2);
            try_block([11;13]+offset) = mean(horz(1,4:5,2));
            try_block([12;14]+offset) = horz(1,5,2);
            try_block([15]+offset) = mean(horz(1,5:6,2));
            try_block([16]+offset) = horz(1,6,2);
            
            offset = 32;
            try_block([1]+offset) = mean(horz(1,1:2,3));
            try_block([2]+offset) = horz(1,2,3);
            try_block([3;5]+offset) = mean(horz(1,2:3,3));
            try_block([6;4]+offset) = horz(1,3,3);
            try_block([7;9]+offset) = mean(horz(1,3:4,3));
            try_block([8;10]+offset) = horz(1,4,3);
            try_block([11;13]+offset) = mean(horz(1,4:5,3));
            try_block([12;14]+offset) = horz(1,5,3);
            try_block([15]+offset) = mean(horz(1,5:6,3));
            try_block([16]+offset) = horz(1,6,3);
            
        case 9
            offset = 0;
            try_block([1]+offset) = mean(vert(1:2,1,1));
            try_block([5]+offset) = vert(2,1,1);
            try_block([2;9]+offset) = mean(vert(2:3,1,1));
            try_block([6;13]+offset) = vert(3,1,1);
            try_block([3;10]+offset) = mean(vert(3:4,1,1));
            try_block([4;8;12;16;15;11;7;14]+offset) = vert(4,1,1);
            
            offset = 16;
            try_block([1]+offset) = mean(vert(1:2,1,2));
            try_block([5]+offset) = vert(2,1,2);
            try_block([2;9]+offset) = mean(vert(2:3,1,2));
            try_block([6;13]+offset) = vert(3,1,2);
            try_block([3;10]+offset) = mean(vert(3:4,1,2));
            try_block([4;8;12;16;15;11;7;14]+offset) = vert(4,1,2);
            
            offset = 32;
            try_block([1]+offset) = mean(vert(1:2,1,3));
            try_block([5]+offset) = vert(2,1,3);
            try_block([2;9]+offset) = mean(vert(2:3,1,3));
            try_block([6;13]+offset) = vert(3,1,3);
            try_block([3;10]+offset) = mean(vert(3:4,1,3));
            try_block([4;8;12;16;15;11;7;14]+offset) = vert(4,1,3);
    end
    
    %% Find best prediction block
    if mode > 0
        try_cost = sum(abs(img_block(:,:,1)-try_block(:,:,1)), 'all');
        
        if try_cost < best_cost
            best_cost = try_cost;
            err_block  = (img_block-try_block);
            pred_mode = mode;
        end
    end
    
    
end


end

