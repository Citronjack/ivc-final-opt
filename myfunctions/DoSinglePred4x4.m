function rec_block = DoSinglePred4x4(err_block_4x4, pred_mode, vert, horz, M)

pred_block  = zeros(4,4,3);


switch pred_mode
    case 0 % in case the mode is not avaidable
        pred_block = zeros(4,4,3);
        
    case 1 %vertical mode
        pred_block = repmat(horz(1, 1:4, :), [4,1]);
        
    case 2 % horizontal mode
        pred_block = repmat(vert(1:4, 1, :), [1,4]);
        
    case 3
        m_vert_horz = mean([horz(1, 1:4, :), permute(vert, [2,1,3])]);
        pred_block = repmat(m_vert_horz, [4,4,1]);
        
    case 4
        pred_block(1,1) = horz(1, 2,1);
        pred_block([2;5]) = horz(1,3,1);
        pred_block([3;6;9]) = horz(1,4,1);
        pred_block([4;7;10;13]) = horz(1,5,1);
        pred_block([8;11;14]) = horz(1,6,1);
        pred_block([12;15]) = horz(1,7,1);
        pred_block([16]) = horz(1,8,1);
        
        offset = 16;
        pred_block(1 + offset) = horz(1,2,2);
        pred_block([2;5] + offset) = horz(1,3,2);
        pred_block([3;6;9] + offset) = horz(1,4,2);
        pred_block([4;7;10;13] + offset) = horz(1,5,2);
        pred_block([8;11;14] + offset) = horz(1,6,2);
        pred_block([12;15] + offset) = horz(1,7,2);
        pred_block([16] + offset) = horz(1,8,2);
        
        offset = 32;
        pred_block(1 + offset) = horz(1,2,3);
        pred_block([2;5] + offset) = horz(1,3,3);
        pred_block([3;6;9] + offset) = horz(1,4,3);
        pred_block([4;7;10;13] + offset) = horz(1,5,3);
        pred_block([8;11;14] + offset) = horz(1,6,3);
        pred_block([12;15] + offset) = horz(1,7,3);
        pred_block([16] + offset) = horz(1,8,3);
        
    case 5
        pred_block([4]) = vert(3,1,1);
        pred_block([3;8]) = vert(2,1,1);
        pred_block([2;7;12]) = vert(1,1,1);
        pred_block([1;6;11;16]) = M(1,1,1);
        pred_block([5;10;15]) = horz(1,1,1);
        pred_block([9;14]) = horz(1,2,1);
        pred_block([13]) =  horz(1,3,1);
        
        offset = 16;
        pred_block([4] + offset) = vert(3,1,2);
        pred_block([3;8] + offset) = vert(2,1,2);
        pred_block([2;7;12] + offset) = vert(1,1,2);
        pred_block([1;6;11;16] + offset) =  M(1,1,2);
        pred_block([5;10;15] + offset) = horz(1,1,2);
        pred_block([9;14] + offset) = horz(1,2,2);
        pred_block([13] + offset) =  horz(1,3,2);
        
        offset = 32;
        pred_block([4] + offset) = vert(3,1,3);
        pred_block([3;8] + offset) = vert(2,1,3);
        pred_block([2;7;12] + offset) = vert(1,1,3);
        pred_block([1;6;11;16] + offset) = M(1,1,3);
        pred_block([5;10;15] + offset) = horz(1,1,3);
        pred_block([9;14] + offset) = horz(1,2,3);
        pred_block([13] + offset) =  horz(1,3,3);
        
    case 6
        
        pred_block([4]) = vert(2,1,1);
        pred_block([3]) = vert(1,1,1);
        pred_block([2;8]) = M(1,1,1);
        pred_block([1;7]) = mean([M(1,1,1), horz(1,1,1)]);
        pred_block([6;12]) = horz(1,1,1);
        pred_block([5;11]) = mean(horz(1,1:2,1));
        pred_block([10;16]) = horz(1,2,1);
        pred_block([9;15]) = mean([horz(1,2,1), horz(1,3,1)]);
        pred_block([14]) = horz(1,3,1);
        pred_block([13]) = mean(horz(1,3:4,1));
        
        offset = 16;
        pred_block([4]+offset) = vert(2,1,2);
        pred_block([3]+offset) = vert(1,1,2);
        pred_block([2;8]+offset) = M(1,1,2);
        pred_block([1;7]+offset) = mean([M(1,1,2), horz(1,1,2)]);
        pred_block([6;12]+offset) = horz(1,1,2);
        pred_block([5;11]+offset) = mean(horz(1,1:2,2));
        pred_block([10;16]+offset) = horz(1,2,2);
        pred_block([9;15]+offset) = mean([horz(1,2,2), horz(1,3,2)]);
        pred_block([14]+offset) = horz(1,3,2);
        pred_block([13]+offset) = mean(horz(1,3:4,2));
        
        offset = 32;
        pred_block([4]+offset) = vert(2,1,3);
        pred_block([3]+offset) = vert(1,1,3);
        pred_block([2;8]+offset) = M(1,1,3);
        pred_block([1;7]+offset) = mean([M(1,1,3), horz(1,1,3)]);
        pred_block([6;12]+offset) = horz(1,1,1);
        pred_block([5;11]+offset) = mean(horz(1,1:2,3));
        pred_block([10;16]+offset) = horz(1,2,3);
        pred_block([9;15]+offset) = mean([horz(1,2,3), horz(1,3,3)]);
        pred_block([14]+offset) = horz(1,3,3);
        pred_block([13]+offset) = mean(horz(1,3:4,3));
        
    case 7
        offset = 0;
        pred_block([4+offset]) = mean(vert(3:4,1,1));
        pred_block([8]+offset) = vert(3,1,1);
        pred_block([3;12]+offset) = mean(vert(2:3,1,1));
        pred_block([7;16]+offset) = vert(2,1,1);
        pred_block([2;11]+offset) = mean(vert(1:2,1,1));
        pred_block([6;15]+offset) = vert(1,1,1);
        pred_block([1;10]+offset) = mean([M(1,1,1), vert(1,1,1)]);
        pred_block([5;14]+offset) = M(1,1,1);
        pred_block([9]+offset) = horz(1,1,1);
        pred_block([13]+offset) = horz(1,2,1);
        
        offset = 16;
        pred_block([4+offset]) = mean(vert(3:4,1,2));
        pred_block([8]+offset) = vert(3,1,2);
        pred_block([3;12]+offset) = mean(vert(2:3,1,2));
        pred_block([7;16]+offset) = vert(2,1,2);
        pred_block([2;11]+offset) = mean(vert(1:2,1,2));
        pred_block([6;15]+offset) = vert(1,1,2);
        pred_block([1;10]+offset) = mean([M(1,1,2), vert(1,1,2)]);
        pred_block([5;14]+offset) = M(1,1,2);
        pred_block([9]+offset) = horz(1,1,2);
        pred_block([13]+offset) = horz(1,2,2);
        
        offset = 32;
        pred_block([4+offset]) = mean(vert(3:4,1,3));
        pred_block([8]+offset) = vert(3,1,3);
        pred_block([3;12]+offset) = mean(vert(2:3,1,3));
        pred_block([7;16]+offset) = vert(2,1,3);
        pred_block([2;11]+offset) = mean(vert(1:2,1,3));
        pred_block([6;15]+offset) = vert(1,1,3);
        pred_block([1;10]+offset) = mean([M(1,1,3), vert(1,1,3)]);
        pred_block([5;14]+offset) = M(1,1,3);
        pred_block([9]+offset) = horz(1,1,3);
        pred_block([13]+offset) = horz(1,2,3);
        
    case 8
        offset = 0;
        pred_block([1]+offset) = mean(horz(1,1:2,1));
        pred_block([2]+offset) = horz(1,2,1);
        pred_block([3;5]+offset) = mean(horz(1,2:3,1));
        pred_block([6;4]+offset) = horz(1,3,1);
        pred_block([7;9]+offset) = mean(horz(1,3:4,1));
        pred_block([8;10]+offset) = horz(1,4,1);
        pred_block([11;13]+offset) = mean(horz(1,4:5,1));
        pred_block([12;14]+offset) = horz(1,5,1);
        pred_block([15]+offset) = mean(horz(1,5:6,1));
        pred_block([16]+offset) = horz(1,6,1);
        
        offset = 16;
        pred_block([1]+offset) = mean(horz(1,1:2,2));
        pred_block([2]+offset) = horz(1,2,2);
        pred_block([3;5]+offset) = mean(horz(1,2:3,2));
        pred_block([6;4]+offset) = horz(1,3,2);
        pred_block([7;9]+offset) = mean(horz(1,3:4,2));
        pred_block([8;10]+offset) = horz(1,4,2);
        pred_block([11;13]+offset) = mean(horz(1,4:5,2));
        pred_block([12;14]+offset) = horz(1,5,2);
        pred_block([15]+offset) = mean(horz(1,5:6,2));
        pred_block([16]+offset) = horz(1,6,2);
        
        offset = 32;
        pred_block([1]+offset) = mean(horz(1,1:2,3));
        pred_block([2]+offset) = horz(1,2,3);
        pred_block([3;5]+offset) = mean(horz(1,2:3,3));
        pred_block([6;4]+offset) = horz(1,3,3);
        pred_block([7;9]+offset) = mean(horz(1,3:4,3));
        pred_block([8;10]+offset) = horz(1,4,3);
        pred_block([11;13]+offset) = mean(horz(1,4:5,3));
        pred_block([12;14]+offset) = horz(1,5,3);
        pred_block([15]+offset) = mean(horz(1,5:6,3));
        pred_block([16]+offset) = horz(1,6,3);
        
    case 9
        offset = 0;
        pred_block([1]+offset) = mean(vert(1:2,1,1));
        pred_block([5]+offset) = vert(2,1,1);
        pred_block([2;9]+offset) = mean(vert(2:3,1,1));
        pred_block([6;13]+offset) = vert(3,1,1);
        pred_block([3;10]+offset) = mean(vert(3:4,1,1));
        pred_block([4;8;12;16;15;11;7;14]+offset) = vert(4,1,1);
        
        offset = 16;
        pred_block([1]+offset) = mean(vert(1:2,1,2));
        pred_block([5]+offset) = vert(2,1,2);
        pred_block([2;9]+offset) = mean(vert(2:3,1,2));
        pred_block([6;13]+offset) = vert(3,1,2);
        pred_block([3;10]+offset) = mean(vert(3:4,1,2));
        pred_block([4;8;12;16;15;11;7;14]+offset) = vert(4,1,2);
        
        offset = 32;
        pred_block([1]+offset) = mean(vert(1:2,1,3));
        pred_block([5]+offset) = vert(2,1,3);
        pred_block([2;9]+offset) = mean(vert(2:3,1,3));
        pred_block([6;13]+offset) = vert(3,1,3);
        pred_block([3;10]+offset) = mean(vert(3:4,1,3));
        pred_block([4;8;12;16;15;11;7;14]+offset) = vert(4,1,3);    
end

rec_block = err_block_4x4 + pred_block;


end

