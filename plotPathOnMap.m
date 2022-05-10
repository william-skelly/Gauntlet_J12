% plots the path taken in the simulator on top of the LIDAR map
%
% PARAMS: none
% RETURN: none

function res = plotPathOnMap()
    % Plots the LIDAR map data for QEA HW6
    clear 

    % Input data
    load("scan5.mat");

    % Get map data vectors
    map1 = plot_Lidar(r_all(:,1), theta_all(:,1), 0, 0, 0);
    map2 = plot_Lidar(r_all(:,2), theta_all(:,2), - pi/2, 0, 0);
    map3 = plot_Lidar(r_all(:,3), theta_all(:,3), 0, 0, -2);
    map4 = plot_Lidar(r_all(:,4), theta_all(:,4), pi, -1.5, -1);
    map5 = plot_Lidar(r_all(:,5), theta_all(:,5), pi, -1.75, -2.5);
    map6 = plot_Lidar(r_all(:,6), theta_all(:,6), -pi/2, -1.5, .25);
    map7 = plot_Lidar(r_all(:,7), theta_all(:,7), -pi/4, 0, -2.5);

    %display on one plot
    figure(1)
    clf
    hold on
    scatter(map1(1,:), map1(2,:));
    scatter(map2(1,:), map2(2,:));
    scatter(map3(1,:), map3(2,:));
    scatter(map4(1,:), map4(2,:));
    scatter(map5(1,:), map5(2,:));
    scatter(map6(1,:), map6(2,:));
    scatter(map7(1,:), map7(2,:)); 
    xlabel("î_G (m)")
    ylabel("ĵ_G (m)")
    title("Map of Gauntlet")
    axis equal
    
    wheel_base = 0.235; %(m)
    measured_data = table2array(readtable("encoderData(5).csv"));
    measured_time                  = (measured_data(:,1) - 9257);
    measured_time                  = measured_time(63:1:end-30);
    left_wheel_position            = (measured_data(:,2)- 2155);
    left_wheel_position            = left_wheel_position(63:1:end-30);
    right_wheel_position           = (measured_data(:,3)- 3459); 
    right_wheel_position           = right_wheel_position(63:1:end-30);
    measured_right_wheel_velocity  = diff(right_wheel_position) ...
        ./ diff(measured_time);
    measured_left_wheel_velocity   = diff(left_wheel_position) ...
        ./ diff(measured_time);
    measured_angular_speed = (measured_right_wheel_velocity - measured_left_wheel_velocity) / wheel_base;
    measured_linear_speed = (measured_right_wheel_velocity + measured_left_wheel_velocity) / 2;
    
    %Calculate actual path via Euler's Method
    position_initial  = [0;0];
    angle_initial     = [1,0];
    position_measured = position_initial;
    angle_measured     = angle_initial;
    for index = 1:length(measured_linear_speed)
        %calculate deltas for x,y, and angle
        t_delta     = measured_time(index + 1) - measured_time(index);
        x_delta     = t_delta .* measured_linear_speed(index) .* cos(angle_measured(index));
        y_delta     = t_delta .* measured_linear_speed(index) .* sin(angle_measured(index));
        delta_theta = t_delta .* measured_angular_speed(index);

        %update position and angle
        position_measured(1, index + 1) = position_measured(1,index) + x_delta;
        position_measured(2, index + 1) = position_measured(2,index) + y_delta;
        angle_measured(index + 1)       = angle_measured(index) + delta_theta;
    end

    % quiver(curve_i,curve_j,left_wheel_position(1:length(left_wheel_position) - 1)',...
    %     right_wheel_position(1:length(right_wheel_position) - 1)','red');
    plot(-position_measured(2,:),-position_measured(1,:),'red');
    axis equal
    xlabel('x-axis of robot plane (m)');
    ylabel('y-axis of robot plane (m)');
    grid on
end