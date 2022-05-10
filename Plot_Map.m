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
hold off 
xlabel("î_G (m)")
ylabel("ĵ_G (m)")
title("Map of Gauntlet")
axis equal