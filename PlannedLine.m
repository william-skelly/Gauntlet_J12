function res = PlannedLine()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
f = getPotField();
[px,py] = gradient(f);
a = .1;
px = -1.*px;
py = -1.*py;

p = [0;0];
x = p(1);
b = zeros(2, 10000);
for n = 1:10000
    b(1,n) = p(1);
    b(2,n) = p(2);
    gradPos = GradientPos(p(1),p(2));
    gradValue = [px(gradPos(1)); py(gradPos(2))];
      crossProd = cross([heading; 0], [gradValue; 0]);

    % if the z-component of the crossProd vector is negative that means we
    % should be turning clockwise and if it is positive we should turn
    % counterclockwise
    turnDirection = sign(crossProd(3));

    % as stated above, we can get the turn angle from the relationship
    % between the magnitude of the cross product and the angle between the
    % vectors
    turnAngle = asin(norm(crossProd)/(norm(heading)*norm(gradValue)));
    p = [p(1)+a*gradValue(1)*turnDirection, p(2)+a*gradValue(2)];
   
end

res = b;
end

