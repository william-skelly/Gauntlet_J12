% Calculates the Z values for a sink at a point
%
% PARAMS: x_sink      = the x coordinate of the sink point
%         y_sink      = the y_coordinate of the sink point
%         x_space   = a meshgrid x space describing the x limits
%         y_space   = a meshgrid x space describing the y limits
% RETURN: a meshgrid containing the Z values of the potential field created
%         by the sink

function res = make_sink(x_sink, y_sink, x_space, y_space)
    res = log(sqrt((x_space - x_sink).^2 + (y_space - y_sink).^2));
end