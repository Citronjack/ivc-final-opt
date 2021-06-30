function dst = ZeroRunDec_EoB_new(src, EOB)

dst = [];

i_dec = 1;
k_dec = 1;
left = 64;

while i_dec <= length(src)
    
    if src(i_dec) ~= EOB && src(i_dec) ~=0
        dst(k_dec) = src(i_dec);
        k_dec = k_dec+1;
        i_dec = i_dec+1;
        left = left - 1;
    elseif isequal(src(i_dec), EOB)
        for j = 0:left-1
           dst(k_dec+j) = 0; 
        end
        k_dec = k_dec+j+1;
        i_dec = i_dec+1;
        left = 0;
        
    elseif src(i_dec) == 0
        zer = src(i_dec+1);
        for j = 0:zer
           dst(k_dec+j) = 0;
        end
        i_dec = i_dec+2;
        k_dec = k_dec + zer+1;
        left = left - zer-1;
        
%     else
%         disp("Some motherfucking error occured")
    end

    if left  == 0
        left = 64;
    end
    
    if left<-1
        disp('left smaller 0')
    end


end