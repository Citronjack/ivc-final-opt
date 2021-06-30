function H = calc_entropy(pmf)
    pmf = pmf(pmf >0);
    H = -sum(pmf.*log2(pmf));
end

