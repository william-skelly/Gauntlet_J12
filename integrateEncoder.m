% Returns the positions of the Neato from encoder data
%
% RETURN: an nx2 matrix of [x,y] points

function res = integrateEncoder()
    wheel_base = 0.235; %(m)
    measured_data = table2array(readtable("encoderData(5).csv"));
    measured_time                  = (measured_data(:,1) - measured_data(1,1));
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
    total_distance = 0;
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
        
        %update total distance
        total_distance = total_distance + sqrt(x_delta^2 + y_delta^2);
    end

    % quiver(curve_i,curve_j,left_wheel_position(1:length(left_wheel_position) - 1)',...
    %     right_wheel_position(1:length(right_wheel_position) - 1)','red');
    plot(position_measured(1,:),position_measured(2,:),'red');
    axis equal
    xlabel('x-axis of robot plane (m)');
    ylabel('y-axis of robot plane (m)');
    title('Robot Path Plot');
    subtitle({['Visualizing the actual path that the '], ...
        'NEATO took in the simulator'});
    grid on
end