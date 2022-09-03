% this function initializes the points (x,y,p,a..e) based on the given
% linkage and start-angle
%
% pts = 8x2 array with rows:
%   x, y, p, a, b, c, d, e
%
% LINKAGE contains the length of components of half of the walking machine:
%     the following points are defined in linkage.png
% [1,2] - y coordinate
% 3 - r = (x,p)
% 4 - (p,a)
% 5 - (p,b)
% 6 - (a,y)
% 7 - (a,c)
% 8 - (y,c)
% 9 - (y,b)
% 10 - (c,d)
% 11 - (b,d)
% 12 - (b,e)
% 13 - (d,e)

function [pts] = init_pts(linkage, start_a, reverse)
    if nargin < 3
        reverse = 1;
    end
    pts = zeros(8,2);
    r = linkage(3);
    y = linkage(1:2);
    y(1) = y(1) * reverse;
    p = [r*cos(start_a), r*sin(start_a)];
    a = solve_triangle(p, y, linkage(6), linkage(4), +1*reverse);
    b = solve_triangle(p, y, linkage(9), linkage(5), -1*reverse);
    c = solve_triangle(y, a, linkage(7), linkage(8), -1*reverse);
    d = solve_triangle(b, c, linkage(10), linkage(11), -1*reverse);
    e = solve_triangle(b, d, linkage(13), linkage(12), -1*reverse);
    
    pts(2,:) = y;
    pts(3,:) = p;
    pts(4,:) = a;
    pts(5,:) = b;
    pts(6,:) = c;
    pts(7,:) = d;
    pts(8,:) = e;
end

function ptC = solve_triangle(ptA, ptB, LA, LB, posneg)
    if any(~isreal(ptA) + ~isreal(ptB))
        ptC=[0 0]; return;
    end
    LC = norm(ptA-ptB);
    theta = atan2(ptB(2)-ptA(2), ptB(1)-ptA(1)); % angle off horz. of AB
    A = acos((LB^2+LC^2-LA^2)/(2*LB*LC)); % internal angle at ptA
    alpha = theta + posneg*A; % angle of AC from horizontal *posneg determins which of 2 solutions to select*
    ptC = ptA + [LB*cos(alpha) LB*sin(alpha)];
end