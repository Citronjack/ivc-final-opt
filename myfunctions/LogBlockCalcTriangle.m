function [err_block, mv, sad] = LogBlockCalcTriangle(row, col, ref_img, curr_block, max_displacement, do_flip)

sad = 0;
k = 1;
[row_max, col_max] = size(curr_block,1,2);
curr_triangle = zeros(size(curr_block));
err_block = curr_triangle;
for i = 1:2
    
    if i ==1
        for j = 1:3
            if ~do_flip
                curr_triangle(:,:,j) = triu(ones(size(curr_block,1,2))).*curr_block(:,:,j) + tril(NaN*ones(size(curr_block,1,2)),-1);
                
            else
                curr_triangle(:,:,j) = flip(triu(ones(size(curr_block,1,2)))).*curr_block(:,:,j) +  flip(tril(NaN*ones(size(curr_block,1,2)),-1));
            end
        end
    else
        for j = 1:3
            if ~do_flip
            curr_triangle(:,:,j) = tril(curr_block(:,:,j),-1) + triu(NaN*ones(size(curr_block,2)),0);
            else
                curr_triangle(:,:,j) =  flip(tril(ones(size(curr_block,1,2)),-1)).*curr_block(:,:,j) +  flip(triu(NaN*ones(size(curr_block,2)),0));
            end
            
        end
    end
    
    
    [mv_part_tmp, err_Smallblock_tmp] = LogarithmicSearch(ref_img, curr_triangle, ...
        [row, col], max_displacement);
    sad = sad + sum(abs(err_Smallblock_tmp), 'all', 'omitnan');
    err_Smallblock_tmp(isnan(err_Smallblock_tmp)) = 0;
    err_block =err_block + err_Smallblock_tmp;
    mv(i) = mv_part_tmp;
    k = k+1;
    
end


end