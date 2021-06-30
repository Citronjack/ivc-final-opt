
function countDoku = numberOfMVs(mot_mode)

switch mot_mode
    case 1
        countDoku = 1;
    case {2, 3, 5, 6} 
        countDoku = 2;
    case 4
        countDoku = 4;
    otherwise
        disp('Error occured in numberOfMVs')
end

end