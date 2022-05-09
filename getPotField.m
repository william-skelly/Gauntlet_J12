% Creates the potential field drescribing the Gauntlet using
% the locations of the walls and obstacles
%
% PARAMS: None
% RETURN: A meshgrid containing the Z values of the potential field
%         describing the Gauntlet

function res = getPotField()
    %%%%%%%%%%%%%%%
    % Define Domain
    %%%%%%%%%%%%%%%
    
    %domain limit coordinates (m)
    [x_min; x_max; y_min; y_max] = getLimits()
    
    %create meshgrid
    boundry_step = 0.01; %domain step size (m)
    x_boundry = x_min:boundry_step:x_max;
    y_boundry = y_min:boundry_step:y_max;
    [x_space, y_space] = meshgrid(x_boundry, y_boundry);
    
    %%%%%%%%%%%%%%%%%%%
    % Get Source Points
    %%%%%%%%%%%%%%%%%%%
    
    top_wall      = pointsFromLine([0;1], [-1.5,-3.37], [-1.5,1]);
    bottom_wall   = pointsFromLine([0;1], [2.5,-3.37], [2.5,1]);
    left_wall     = pointsFromLine([1;0], [-1.5,-3.37], [2.5,-3.37]);
    right_wall    = pointsFromLine([1;0], [-1.5,1], [2.5,1]);
    corner_points = [-1.5, -3.37; -1.5, 1; 2.5, -3.37; 2.5, 1];
    
    %%%%%%%%%%%%%%%%
    % Create Sources
    %%%%%%%%%%%%%%%%
    
    z_field = zeros(size(x_space, 1), size(x_space, 2)); %initialize z_field
    
    %top wall
    for index = 1:length(top_wall)
        x_source = top_wall(index, 1);
        y_source = top_wall(index, 2);
        %distToMid = sqrt((x_source + 1.5).^2 + (y_source + 1).^2);
        new_source = -1 * make_sink(x_source, y_source, x_space, y_space) * 1/(length(top_wall));
        z_field = z_field + new_source;
    end
    
    %bottom wall
    for index = 1:length(bottom_wall)
        x_source = bottom_wall(index, 1);
        y_source = bottom_wall(index, 2);
        %distToMid = sqrt((x_source - 2.5).^2 + (y_source + 1).^2);
        new_source = -1 * make_sink(x_source, y_source, x_space, y_space) * 1/(length(bottom_wall));
        z_field = z_field + new_source;
    end
    
    %left wall
    for index = 1:length(left_wall)
        x_source = left_wall(index, 1);
        y_source = left_wall(index, 2);
        %distToMid = sqrt((x_source - 0.5).^2 + (y_source + 3.37).^2);
        new_source = -1 * make_sink(x_source, y_source, x_space, y_space) * 1/(length(left_wall));
        z_field = z_field + new_source;
    end
    
    %right wall
    for index = 1:length(right_wall)
        x_source = right_wall(index, 1);
        y_source = right_wall(index, 2);
        %distToMid = sqrt((x_source - 0.5).^2 + (y_source - 1).^2);
        new_source = -1 * make_sink(x_source, y_source, x_space, y_space) * 1/(length(right_wall));
        z_field = z_field + new_source;
    end
    
    %add to corners
    for index = 1:length(corner_points)
        x_source = corner_points(index, 1);
        y_source = corner_points(index, 2);
        new_source = -1 * make_sink(x_source, y_source, x_space, y_space) / 4;
        % magnitude of corners compensates for sinks created by lines
        z_field = z_field + new_source;
    end
    
    %%%%%%%%%%%%%%%%%%%%
    % Display and return
    %%%%%%%%%%%%%%%%%%%%
    
    s = surf(x_space,y_space,z_field, 'FaceAlpha', 0.5);
    s.EdgeColor = 'none';
    
    res = z_field; %return
end