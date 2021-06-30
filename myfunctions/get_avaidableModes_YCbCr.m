function avail = get_avaidableModes_YCbCr(vertYCbCr, horzYCbCr)

avail = zeros(4,1);
if ~isnan(horzYCbCr(1,1,1)) && ~isnan(vertYCbCr(1,1,1))
    avail(1:end) = 1;

elseif  ~isnan(horzYCbCr(1,1,1))
    avail(1) = 1;

elseif ~isnan(vertYCbCr(1,1,1))
    avail(2) = 1;
end

end