function zze = ZeroRunEnc_EoB_new(zz, EOB)
%  Input         : zz (Zig-zag scanned sequence, 1xN)
%                  EOB (End Of Block symbol, scalar)
%
%  Output        : zze (zero-run-level encoded sequence, 1xM)

%  Input         : zz (Zig-zag scanned sequence, 1xN)
%                  EOB (End Of Block symbol, scalar)
%
%  Output        : zze (zero-run-level encoded sequence, 1xM)

% delete last zeros
% delete last zeros
zze = [];
plus = 63;
for i = 1:64:length(zz)
    if length(zz(i:end)) <63
        plus = length(zz(i:end))-1;
    end
    zzt = ZeroRunEnc_EoB_new_seq(zz(i:i+plus), EOB);
    zze(end+1:end+length(zzt)) = zzt;
end
% zze = blockproc(zz, [1, 64], @(block_struct) ...
%    ZeroRunEnc_EoB_new_seq(block_struct.data, EOB));

end

function seq_out = ZeroRunEnc_EoB_new_seq(seq_in, EOB)
set_EOB = false;
i = 1;
k = 1;
while isequal(seq_in(end), 0)
    seq_in(end) = [];
    set_EOB = true;
    if isempty(seq_in)
        seq_out = EOB;
        i = length(seq_in)+1;
        set_EOB = false;
        break;
    end
end


while i <= length(seq_in)
    if seq_in(i) ~= 0
        seq_out(k) = seq_in(i);
        i = i+1;
        k = k+1;
    else
        for j = i:length(seq_in)
           if seq_in(j) ~= 0
               break;
           end
        end
        seq_out(k:k+1) = [0 , j-i-1];
        k = k+2;
        i = j;
    end

end

if set_EOB
    seq_out(end+1) = EOB; 
end

end