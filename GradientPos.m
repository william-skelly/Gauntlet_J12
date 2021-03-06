function res = GradientPos(X,Y)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    domainLimits = getLimits();
    
    %create meshgrid
    boundry_step = domainLimits(5); %domain step size (m)
    x_boundry = domainLimits(1):boundry_step:domainLimits(2);
    y_boundry = domainLimits(3):boundry_step:domainLimits(4);
    [x_space, y_space] = meshgrid(x_boundry, y_boundry);
    
    xNum = false;
    n = 1;
    while ~xNum
        if x_boundry(n) == X
           xNum = true;
           Xpos = n;
        end
        
    	if x_boundry(n)>X
           xNum = true;
           Xpos = n;
        end
        n = n+1;
    end
    yNum = false;
    n = 1;
    while ~yNum
        if y_boundry(n) == Y
           yNum = true;
           Ypos = n;
        end
        if y_boundry(n)>Y
                yNum = true;
                Ypos = n;
        end
        n = n+1;
    end
    res = [Xpos, Ypos];
    %res = [x_space, y_space];
end

