function block = IDCT8x8(coeff)
%  Function Name : IDCT8x8.m
%  Input         : coeff (DCT Coefficients) 8*8*3
%  Output        : block (original image block) 8*8*3

%     block =  zeros(size(coeff));
%     for z = 1:3
%         block(:,:,z) = idct(idct(coeff(:,:,z), [], 2), [], 1);
%     end
    block = permute(idct(permute(idct(coeff),[2 1 3])), [2, 1, 3]);

end

