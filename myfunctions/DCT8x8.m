function coeff = DCT8x8(block)
%  Input         : block    (Original Image block, 8x8x3)
%
%  Output        : coeff    (DCT coefficients after transformation, 8x8x3)
%     coeff = zeros(size(block));
%     for z = 1:3
%         coeff(:,:,z) = dct(dct(block(:,:,z), [], 1), [], 2);
%     end
    coeff = permute(dct(permute(dct(block),[2 1 3])), [2, 1, 3]);
    
end