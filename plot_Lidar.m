% Plots a set of R, theta polar coordinate values from LIDAR in global
% frame of reference
%
% PARAMS: Rs          = a column vector of polar radii from the sensor
%         Thetas      = a column vector of polar angles from the sensor
%         phi = the angle of the robot in the global frame
%         robot_x  = the x coordinate of the robot's center of rotation
%         robot_y  = the y coordinate of the robot's center of rotation
% RETURNS: a matrix whose first column is the X coordinates in the global
%          reference frame, and whose second column is the Y values

function res = plot_Lidar(Rs, Thetas, phi, robot_x, robot_y)
    %setup
    sensor_loc = 0.084; % the distance between the sensor and the robot
                        % center of rotation
    %transformation into robot frame of reference (translate)
    R_l = [Rs .* cos(Thetas), Rs .* sin(Thetas), ones(length(Rs), 1)]'; %change to cartisian
    size(R_l)
    T   = [1,0,-sensor_loc; 0,1,0;0,0,1]; %transformation matrix
    R_n = T * R_l;
    
    %transformation into global frame (translation and rotation)
    T   = [1,0,-robot_x; 0,1,robot_y;0,0,1];
    R   = [cos(phi), -sin(phi), 0; sin(phi), cos(phi), 0; 0,0,1];
    R_g = T * R * R_n;
    
    %display
    %scatter(R_g(1,:), R_g(2,:));

    %return
    res = R_g;
end