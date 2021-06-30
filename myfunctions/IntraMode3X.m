function [ I_rec, PSNR, bitPerPixel ] = IntraMode3X(img, img_train, qScale, EOB, h_fac)
%INTRAMODEX Encodes an Intraframe, uses spatial prediction
%   Detailed explanation goes here


%% Intra & Huffman train & encode

[img_enc, pred_modes] = IntraEnc3X_4_8(img, qScale, EOB, h_fac);
img_train_pmf = stats_marg(img_enc, min(img_enc):max(img_enc) );
[BinaryTree, ~, BinCode, Codelengths] = buildHuffman( img_train_pmf );
bytestream_img = enc_huffman_new(img_enc(:)-min(img_enc)+1, BinCode, Codelengths);

pred_modes_pmf = stats_marg(pred_modes, min(pred_modes):max(pred_modes));
[BinaryTree_pred_modes, ~, BinCode_pred_modes, Codelengths_pred_modes] = buildHuffman( pred_modes_pmf );
bytestream_pred_modes = enc_huffman_new(pred_modes(:)-min(pred_modes)+1, BinCode_pred_modes, Codelengths_pred_modes);

bitPerPixel(1) = (numel(bytestream_img)*8) / (numel(img)/3) + (numel(bytestream_pred_modes)*8) / (numel(img)/3)

%% Huffman & Intra Decode

img_dec_huff = dec_huffman_new(bytestream_img, BinaryTree, length(img_enc(:))) +min(img_enc(:))-1;
pred_modes_dec_huff = dec_huffman_new(bytestream_pred_modes, BinaryTree_pred_modes, length(pred_modes(:))) + min(pred_modes(:)) - 1;

I_rec = IntraDec3X_4_8(img_dec_huff, pred_modes_dec_huff, size(img), qScale, EOB, h_fac);
I_rec = ictYCbCr2RGB(I_rec);
PSNR(1) = calcPSNR(ictYCbCr2RGB(img), I_rec)

imshow(uint8((I_rec)))

end