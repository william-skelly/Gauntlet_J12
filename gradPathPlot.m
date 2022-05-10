% Creates plot of path of gradient descent
%
% PARAMS: none
% RETURN: the planned positions of the Neato

function res = gradPathPlot()

    % this is the scaling factor we apply to the gradient when calculating our
    % step size
    lambda = .05;

    % setup symbolic expressions for the function and gradient
    f = getPotField();
    [px,py] = gradient(f);
    px = -1.*px;
    py = -1.*py;
    
    % the problem description tells us to the robot starts at position 0,0
    position = [0; 0];

    % set a flag to control when we are sufficiently close to the maximum of f
    shouldStop = false;
    index = 1;

    while ~shouldStop
        % get the gradient
        gradPos = GradientPos(position(1),position(2));
        gradValue = [px(gradPos(1)); py(gradPos(2))];
        
        % update the position for the next iteration
        position = position + gradValue*lambda;
        positionData(index,:) = position;
        % if our step is too short, flag it so we break out of our loop
        shouldStop = index > 10000;
        index = index + 1;
    end
    
    res = positionData;
    hold on
    plot(positionData(:,1), positionData(:,2))
end