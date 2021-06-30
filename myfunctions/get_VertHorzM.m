function [vert, horz, M] = get_VertHorzM(img, frac_size, col, row)


if row>1
%     if col+7<=size(img,2)
%         horz = img(row-1, col:col+7, :);
%     else
        horz = zeros(1, 8,3);
        horz(1,1:4,:) = img(row-1, col:col+3, :);
%         horzEnd = size(img,2)-col+1;
%         horz(1, 1:horzEnd, :) = img(row-1, col:size(img,2), :);
%         left = 8-horzEnd;
        horz(1, 5:end, :) = repmat(horz(1, 4, :),1,4,1);
%     end
else
    horz = NaN;
end

if col>1
    vert = img(row:row+3, col-1, :);
else
    vert = NaN;
end

if (col > 1) && (row > 1)
    M = img(row-1, col-1, :);
else
    M = NaN;
end

end

