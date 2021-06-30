function [avid_vec] = get_avaidableModes(vert, horz, M)

avid_vec = zeros(9,1);

if ~isnan(vert(1))
    avid_vec(2) = 1;
end
if ~isnan(horz(1))
   avid_vec(1) = 1; 
end

if ~isnan(horz(1)) && ~isnan(vert(1))
    avid_vec([3,4,7,8,9]) = 1;    
end

if ~isnan(M(1)) && ~isnan(horz(1)) && ~isnan(vert(1))
    avid_vec([5,6]) = 1;
end

end
