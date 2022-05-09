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
    x_min = -1.5;
    x_max = 2.5;
    y_min = -3.37;
    y_max = 1;
    
    %create meshgrid
    boundry_step = 0.01; %domain step size (m)
    x_boundry = x_min:boundry_step:x_max;
    y_boundry = y_min:boundry_step:y_max;
    [x_space, y_space] = meshgrid(x_boundry, y_boundry);
    
    %%%%%%%%%%%%%%%%%%%
    % Get Source Points
    %%%%%%%%%%%%%%%%%%%
    
    top_wall    = pointsFromLine([0;1], [-1.5,-3.37], [-1.5,1]);
    bottom_wall = pointsFromLine([0;1], [2.5,-3.37], [2.5,1]);
    left_wall   = pointsFromLine([1;0], [-1.5,-3.37], [2.5,-3.37]);
    right_wall  = pointsFromLine([1;0], [-1.5,1], [2.5,1]);
    
    all_sources = [top_wall; bottom_wall; left_wall; right_wall];
    
    
    %%%%%%%%%%%%%%%%
    % Create Sources
    %%%%%%%%%%%%%%%%
    
    z_field = zeros(size(x_space, 1), size(x_space, 2)); %initialize z_field
    
    %loop through all source points and create sources there
    for index = 1:length(all_sources)
        x_source = all_sources(index, 1);
        y_source = all_sources(index, 2);
        new_source = -1 * make_sink(x_source, y_source, x_space, y_space) * 1/(length(top_wall));
        z_field(1,1)
        z_field = z_field + new_source;
    end
   
    
    %%%%%%%%%%%%%%%%%%%%
    % Display and return
    %%%%%%%%%%%%%%%%%%%%
    
    contour(x_space,y_space,z_field)
    
    res = z_field; %return
end