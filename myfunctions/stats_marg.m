function pmf = stats_marg(image, range)
%     I_m = reshape(double(image),[1, numel(image)]);
%     pmf = hist(I_m, range)/numel(I_m);
    a = hist(image(:), range);
    pmf = a/sum(a);
    
end

