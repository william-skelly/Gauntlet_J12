% returns the x and y limits of the domain
%
% PARAMS: none
% RETURN: a 4x1 column vector containing the x and y limits in the format 
%         [x_min; x_max; y_min; y_max]

function res = getLimits()
    %domain limit coordinates (m)
    x_min = -2;%-1.5;
    x_max = 3;%2.5;
    y_min = -4;%-3.37;
    y_max = 1.5;%1;

    res = [x_min; x_max; y_min; y_max];
end