function [DX,DY] = MakeQuiverPlot()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
Z = getPotField;   
%domain limit coordinates (m)
    x_min = -1.5;
    x_max = 2.5;
    y_min = -3.37;
    y_max = 1;
    
    %create meshgrid
    boundry_step = 0.01; %domain step size (m)
    x_boundry = x_min:boundry_step:x_max;
    y_boundry = y_min:boundry_step:y_max;
    [x_space, y_space] = meshgrid(x_boundry, y_boundry);
[dX,dY] = gradient(Z,boundry_step);
clf
quiver(x_space,y_space,x_space+dX,y_space+dY)
DX = dX;
DY = dY;
%hold on
%contour(X,Y,Z)
%axis equal
%hold off
end

