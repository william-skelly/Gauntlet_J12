% Plots the LIDAR map data for QEA HW6

% Input data from CSV
ralldata = readmatrix("r_all_data.csv");
thetaalldata = readmatrix("theta_all_data.csv");

% Get map data vectors
map1 = plot_Lidar(ralldata(:,1), thetaalldata(:,1), 0, 0, 0);
map2 = plot_Lidar(ralldata(:,2), thetaalldata(:,2), - pi/2, 0, 0);
map3 = plot_Lidar(ralldata(:,3), thetaalldata(:,3), 0, 0, -2);
map4 = plot_Lidar(ralldata(:,4), thetaalldata(:,4), pi, -1.5, -1);
map5 = plot_Lidar(ralldata(:,4), thetaalldata(:,4), pi, 2, -2.5);
map6 = plot_Lidar(ralldata(:,4), thetaalldata(:,4), -pi/2, 1.5, .5);

%display on one plot
hold on
scatter(map1(1,:), map1(2,:));
scatter(map2(1,:), map2(2,:));
scatter(map3(1,:), map3(2,:));
scatter(map4(1,:), map4(2,:));
scatter(map5(1,:), map5(2,:));
scatter(map6(1,:), map6(2,:));
hold off 
axis equal