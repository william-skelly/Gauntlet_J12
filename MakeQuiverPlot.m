function [DX,DY] = MakeQuiverPlot()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
scale = 0.05;
threshold = 0.25;
Z = getPotField;
%domain limit coordinates (m)
    domainLimits = getLimits;
    
    %create meshgrid
    boundry_step = 0.01; %domain step size (m)
    x_boundry = domainLimits(1):boundry_step:domainLimits(2);
    y_boundry = domainLimits(3):boundry_step:domainLimits(4);
    [x_space, y_space] = meshgrid(x_boundry, y_boundry);
    
[dX,dY] = gradient(Z,boundry_step);

% Downsample the original spaces and deltas
for row=10:10:length(dX(:, 1))
    for col = 10:10:length(dX(1, :))
        new_dX(row/10, col/10) = dX(row, col);
        new_dY(row/10, col/10) = dY(row, col);
        new_x_space(row/10, col/10) = x_space(row, col);
        new_y_space(row/10, col/10) = y_space(row, col);
    end
end

clf
hold on
xlim([domainLimits(1) domainLimits(2)])
ylim([domainLimits(3) domainLimits(4)])

% Plot all the vectors
for row=1:length(new_dX(:, 1))
    for col = 1:length(new_dX(1, :))
        if abs(new_dY(row, col))*scale < threshold && abs(new_dX(row, col))*scale < threshold
            quiver(new_x_space(row, col), new_y_space(row, col), new_dX(row, col)*scale, new_dY(row, col)*scale, 'b');
        end
    end
end

DX = dX;
DY = dY;

%contour(X,Y,Z)
%axis equal
hold off
end

