% Returns a set of points that discretly represent a circle
%
% PARAMS: center_point = the center of the circle as a row vector [x,y]
%         radius       = the radius of the circle
% RETURN: a 2xn matrix where each row is a point x,y on the circle edge

function res = pointsFromCircle(center_point, radius)
    % initialize paramers
    u_step    = 0.01; %the step size for the parameter u
    u_initial = 0; %the line is parametrized such that the start is at u=0
    u_final   = 2 * pi;
    u_sweep   = u_initial:u_step:u_final;
    
    %calculate circle
    x_circ = radius .* cos(u_sweep) + center_point(1);
    y_circ = radius .* sin(u_sweep)  + center_point(2);
    res    = [x_circ', y_circ']; %return
end