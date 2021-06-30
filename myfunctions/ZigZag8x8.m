function zz = ZigZag8x8(quant)
%  Input         : quant (Quantized Coefficients, 8x8x3)
%
%  Output        : zz (zig-zag scaned Coefficients, 64x3)
    for i=1:3
    zz(:,i) = zigzagscan(quant(:,:,i));
    end
end


function vec = zigzagscan(A)
%ZIGZAGSCAN Performs a zig-zag scan on a matrix
%   input: 
%       A: is a symmetric  input matrix
%   output
%       vec = is an outout vector which holds the elements of A in as the
%       zig zag scan

    vec = zeros([1, numel(A)]);
    right = true;
    vec(1) = A(1,1);
    coor = [1,2];
    i = 2;
    m = 0;
    while(i < numel(A))
       
        if right            
            for l = (coor(2)-m):-1:1
                vec(i) = A(coor(1), coor(2));
                i = i+1;
                if l ~= 1
                    coor = coor + [+1,-1];
                elseif coor(1) < size(A,2)
                    coor = coor + [+1,0];
                    right = false;
                    
                elseif coor(1) == size(A,2)
                    coor = coor + [0,+1];
                    right = false;
                    m = m +1;
                end
            end
            
        elseif ~right
            for l = (coor(1)-m):-1:1
               vec(i) = A(coor(1), coor(2));
               i = i+1;
                if l ~= 1
                    coor =  coor + [-1,+1];                    
                elseif coor(2) < size(A,2)
                    coor = coor + [0,+1];
                    right = true;
                elseif coor(2) == size(A,2)
                    coor = coor + [1,0];
                    right = true;
                    m = m +1;
                end
                
            end 
        end
        
    end  
    vec(end) = A(end);
end
