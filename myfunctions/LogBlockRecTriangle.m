function rec_block = LogBlockRecTriangle(row, col, ref_img, mv, err_block, max_displacement, do_flip)

curr_triangle = zeros(size(err_block));
rec_block = zeros(size(err_block));

for i = 1:2
    
    if i ==1
        for j = 1:3
            if ~do_flip
                curr_triangle(:,:,j) = triu(ones(size(err_block,1,2))).*err_block(:,:,j)+ tril(NaN*ones(size(err_block,1,2)),-1);
                
            else
                curr_triangle(:,:,j) = flip(triu(ones(size(err_block,1,2)))).*err_block(:,:,j) +  flip(tril(NaN*ones(size(err_block,1,2)),-1));
            end
        end
    else
        for j = 1:3
            if ~do_flip
            curr_triangle(:,:,j) = tril(err_block(:,:,j),-1) + triu(NaN*ones(size(err_block,2)),0);
            else
                curr_triangle(:,:,j) =  flip(tril(ones(size(err_block,1,2)),-1)).*err_block(:,:,j)+  flip(triu(NaN*ones(size(err_block,2)),0));
            end
            
        end
    end
    
    mv_tmp = mv(i);
    rec_Smallblock = LogarithmicComp(ref_img, curr_triangle, mv_tmp, [row, col], max_displacement);

    rec_Smallblock(isnan(rec_Smallblock)) = 0;
    
    rec_block =rec_block + rec_Smallblock ;

    
end


end