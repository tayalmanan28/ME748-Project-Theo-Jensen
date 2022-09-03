% test each function

%% TEST INIT
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

% a = 38, b = 41.5, c = 39.3, d = 40.1, e = 55.8, f = 39.4, g = 36.7, 
%   h = 65.7, i = 49, j = 50, k = 61.9, l=7.8, m=15

linkage = [38, ... % a
           -7.8, ... % l
           15, ... % m
           50, ... % j
           61.9, ... % k
           41.5, ... % b
           55.8, ... % e
           40.1, ... % d
           39.3, ... % c
           39.4, ... % f
           36.7, ... % g
           49, ... % i
           65.7]; % h
       
linkage = linkage / linkage(3); % normalize to motor radius of 1

% linkage = [.5, ... 1
%            0, ... 2
%            .3, ... 3
%            1.5, ... 4
%            1.5, ... 5
%            1.5, ... 6
%            1.5, ... 7
%            .5, ... 8
%            1.5, ... 9
%            1.25, ... 10
%            .75, ... 11
%            1, ... 12
%            1.5]; % 13
start_a = 3*pi/2;
pts = init_pts(linkage, start_a);
plot_linkage(pts, true);
fprintf('valid = %d\n', verify_linkage(linkage,pts));

%% TEST SIMULATION

% use linkage from above
animate_linkage(linkage, true);