function [valid, trajectories] = simulate_rotation(linkage, start_a, end_a, n, reverse)

if nargin < 5
    reverse = 1;
    if nargin < 4
        n = 128;
        if nargin < 3
            end_a = 2*pi;
            if nargin < 2
                start_a = 0;
            end
        end
    end
end

% LINKAGE is 1x13 and contains the length of components of half of the
%   walking machine. The following points are defined in linkage.png
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

% pts = init_pts(linkage, start_a, reverse);
angles = linspace(start_a, end_a, n);

trajectories = zeros(8,2,length(angles));
valid = true;

for i=1:length(angles)
    a = angles(i);
    % fprintf('solving for a=%f\n', a*180/pi);
    pts = init_pts(linkage,a,reverse);
    trajectories(:,:,i) = pts;
    if ~verify_linkage(linkage, pts, reverse)
        % fprintf('invalid!\n');
        trajectories = trajectories(:,:,1:i);
        valid = false;
        return;
    end
end

end