function res = TakenLine()
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
data = load("encoderData(5).csv");
wheelBase = 0.235;  
vL = data(:,2);
vR = data(:,3);
time = data(:, 1);

Vel = (vL + vR)/2;
omega = (vR + vL)/wheelBase;

dt = diff(time);
dV = diff(Vel);
dO = diff(do)

p = [0,0];
a = zeros(2, length(dV));
a(1)=p;
for n = 2:length(Vel);
   a(n) = [p(1)+; p(2)+ 
end
res = [x, y];
end

