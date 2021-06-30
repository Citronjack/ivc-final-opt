function coeffs = DeZigZag8x8(zz)
%  Function Name : DeZigZag8x8.m
%  Input         : zz    (Coefficients in zig-zag order)
%
%  Output        : coeffs(DCT coefficients in original order)

    for i = 1:3
        coeffs(:,:,i) = dezigzagscan(zz(:,i));
    end

end

function A = dezigzagscan(vec)
%ZIGZAGSCAN Performs a zig-zag scan on a matrix
%   input: 
%       A: is a symmetric  input matrix
%   output
%       vec = is an outout vector which holds the elements of A in as the
%       zig zag scan
    
    A = zeros(8,8);
    right = true;
    A(1,1) = vec(1);
    coor = [1,2];
    i = 2;
    m = 0;
    while(i < numel(A))
       
        if right            
            for l = (coor(2)-m):-1:1
                A(coor(1), coor(2)) = vec(i);
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
               A(coor(1), coor(2)) = vec(i);
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
    A(end) = vec(end);
end


