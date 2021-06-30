function rec_block = LogarithmicComp(ref_img, err_block, mv, loc, max_displacement_vec)

[y_mv, x_mv] = ind2sub((2*max_displacement_vec+1).*[1,1], mv);
normali = ceil((2*max_displacement_vec+1)/2);
y_mv = y_mv - normali; 
x_mv =  x_mv - normali;
block_size = size(err_block,1,2);
pad_size = max(block_size-1, max_displacement_vec);
block_size = size(err_block,1,2);

loc = loc + pad_size;
row = loc(1);
col = loc(2);



ref_img = padarray(ref_img, pad_size,  'symmetric');

block_tmp = ref_img(row+y_mv:row+y_mv+block_size(1)-1, col+x_mv:col+x_mv+block_size(2)-1, :);

rec_block = block_tmp + err_block;


end