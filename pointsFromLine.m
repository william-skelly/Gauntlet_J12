% Returns a set of points that discretly represent a line
%
% PARAMS: slope_vector = the slope of the line as a unit tangent vector
%         start_point  = a row vector containing the first point [x,y] on 
%                        the line
%         end_point    = a row vector containing the second point [x,y] on 
%                        the line
% RETURN: a 2xn matrix where each row is a point x,y on the line

function res = pointsFromLine(slope_vector, start_point, end_point)
    % initialize paramers
    u_step    = 0.01; %the step size for the parameter u
    u_initial = 0; %the line is parametrized such that the start is at u=0
    u_final   = ((end_point(1) - start_point(1)) / slope_vector(1); %the 
        %value of the parameter that corresponds to the end of the line
    u_sweep   = u_initial:u_step:u_final; %note that because slope_vector 
        %is a unit vector, the parameter u is in meters
    
    res = u_sweep;   
         
    %r(u) = [start_point(1) + slope_vector(1) * u, start_point(2) + slope_vector(2) * u];
    
end