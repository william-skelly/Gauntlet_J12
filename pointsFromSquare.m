% Returns a set of points that discretly represent a square
%
% PARAMS: theta        = the angle at which the square is oriented
%         side_length  = the length of the side of the square
%         center_point = the point at the center of the square
% RETURN: a 2xn matrix where each row is a point x,y on the edge of the
%         square

function res = pointsFromSquare(theta, side_length, center_point)
    %create central horizontal side_length line segment to use as archtype
    %for all sides
    start_point = [0,0] - [side_length / 2; 0];
    end_point   = [0,0] + [side_length / 2; 0];
    archLine    = pointsFromLine([1,0], start_point, end_point);
    archLine    = [archLine,ones(length(archLine), 1)]'; %add column of 
                                                    %ones and transpose
    
    %create transformation matices for sides 1,2,3,4
    transform1 = [1,0,side_length/2; 0,1,0; 0,0,1] * [0,-1,0;1,0,0;0,0,1];
    transform2 = [1,0,-side_length/2; 0,1,0; 0,0,1] * [0,-1,0;1,0,0;0,0,1];
    transform3 = [1,0,0; 0,1,side_length/2; 0,0,1];
    transform4 = [1,0,0; 0,1,-side_length/2; 0,0,1];
    rotate_theta = [cos(theta), -sin(theta), 0; sin(theta), cos(theta), 0; 0, 0, 1];
    transformCenter = [1,0,center_point(1); 0,1,center_point(2); 0,0,1];
    
    %transform archside to create sides 1,2,3,4
    line1 = rotate_theta * transform1 * archLine;
    line2 = rotate_theta * transform2 * archLine;
    line3 = rotate_theta * transform3 * archLine;
    line4 = rotate_theta * transform4 * archLine;
    
    %stack all lines into an nx3 matrix
    all_lines = [line1, line2, line3, line4];
    all_lines = transformCenter * all_lines; %translate to new center
    all_lines = all_lines(1:2,:); %crop off the Z=1 entries
    all_lines = all_lines'; %transpose into column
    
    %return
    res = all_lines;
end