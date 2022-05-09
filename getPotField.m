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
    domainLimits = getLimits();
    
    %create meshgrid
    boundry_step = domainLimits(5); %domain step size (m)
    x_boundry = domainLimits(1):boundry_step:domainLimits(2);
    y_boundry = domainLimits(3):boundry_step:domainLimits(4);
    [x_space, y_space] = meshgrid(x_boundry, y_boundry);
    
    %%%%%%%%%%%%%%%%%%%
    % Get Source Points
    %%%%%%%%%%%%%%%%%%%
    
    top_wall      = pointsFromLine([0;1], [-1.5,-3.37], [-1.5,1]);
    bottom_wall   = pointsFromLine([0;1], [2.5,-3.37], [2.5,1]);
    left_wall     = pointsFromLine([1;0], [-1.5,-3.37], [2.5,-3.37]);
    right_wall    = pointsFromLine([1;0], [-1.5,1], [2.5,1]);
    corner_points = [-1.5, -3.37; -1.5, 1; 2.5, -3.37; 2.5, 1];
    box1_points   = pointsFromSquare(pi/4, 0.5, [-0.25; -1]);
    box2_points   = pointsFromSquare(pi/4, 0.5, [1; -0.7]);
    box3_points   = pointsFromSquare(0, 0.5, [1.41; -2]);
    
    %%%%%%%%%%%%%%%%
    % Create Sources
    %%%%%%%%%%%%%%%%
    
    z_field = zeros(size(x_space, 1), size(x_space, 2)); %initialize z_field
    
    %top wall
    for index = 1:length(top_wall)
        x_source = top_wall(index, 1);
        y_source = top_wall(index, 2);
        %distToMid = sqrt((x_source + 1.5).^2 + (y_source + 1).^2);
        new_source = -1 * make_sink(x_source, y_source, x_space, y_space) * 1.2/(length(top_wall));
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
    
    %box1
    for index = 1:length(box1_points)
        x_source = box1_points(index, 1);
        y_source = box1_points(index, 2);
        %distToMid = sqrt((x_source - 0.5).^2 + (y_source - 1).^2);
        new_source = -1 * make_sink(x_source, y_source, x_space, y_space) * 0.5/(length(box1_points));
        z_field = z_field + new_source;
    end
    
    %box2
    for index = 1:length(box2_points)
        x_source = box2_points(index, 1);
        y_source = box2_points(index, 2);
        %distToMid = sqrt((x_source - 0.5).^2 + (y_source - 1).^2);
        new_source = -1 * make_sink(x_source, y_source, x_space, y_space) * 0.5/(length(box2_points));
        z_field = z_field + new_source;
    end
    
    %box3
    for index = 1:length(box3_points)
        x_source = box3_points(index, 1);
        y_source = box3_points(index, 2);
        %distToMid = sqrt((x_source - 0.5).^2 + (y_source - 1).^2);
        new_source = -1 * make_sink(x_source, y_source, x_space, y_space) * 1/(length(box3_points));
        z_field = z_field + new_source;
    end
    
    %corners
    for index = 1:length(corner_points)
        x_source = corner_points(index, 1);
        y_source = corner_points(index, 2);
        new_source = -1 * make_sink(x_source, y_source, x_space, y_space) / 4;
        % magnitude of corners compensates for sinks created by lines
        z_field = z_field + new_source;
    end
    
    %%%%%%%%%%%%%%%%%%
    % Add Sink for BoB
    %%%%%%%%%%%%%%%%%%
    
    BoB_points = pointsFromCircle([.75,-2.5], .25);
    
    for index = 1:length(BoB_points)
        x_source = BoB_points(index, 1);
        y_source = BoB_points(index, 2);
        new_sink = make_sink(x_source, y_source, x_space, y_space) * 2/(length(BoB_points));
        z_field = z_field + new_sink;
    end
    
    %%%%%%%%%%%%%%%%%%%%
    % Display and return
    %%%%%%%%%%%%%%%%%%%%
    
    s = surf(x_space,y_space,z_field, 'FaceAlpha', 0.5);
    s.EdgeColor = 'none';
    figure
    contour(x_space,y_space,z_field)
    
    res = z_field; %return
end