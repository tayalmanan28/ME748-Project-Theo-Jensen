% verify that pts respect the linkage lengths within tol
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


function valid = verify_linkage(linkage, pts, reverse, tol)
    if nargin < 3
        reverse = 1;
    end
    if nargin < 4
        tol = 0.001;
    end
    % get pts
    x = pts(1,:);
    y = pts(2,:);
    p = pts(3,:);
    a = pts(4,:);
    b = pts(5,:);
    c = pts(6,:);
    d = pts(7,:);
    e = pts(8,:);
    % validity checks
    valid = true;
    if (~all(x == [0 0]))
        % fprintf('x pt invalid\n');
        valid = false; return;
    end
    if (~all(y == [linkage(1)*reverse linkage(2)]))
        % fprintf('y pt invalid\n');
        valid = false; return;
    end
    if (tol <= norm(norm(x-p) - linkage(3)))
        % fprintf('r = xp length invalid\n');
        valid = false; return;
    end
    if (tol <= norm(norm(p-a) - linkage(4)))
        % fprintf('pa length invalid\n');
        valid = false; return;
    end
    if (tol <= norm(norm(p-b) - linkage(5)))
        % fprintf('pb length invalid\n');
        valid = false; return;
    end
    if (tol <= norm(norm(a-y) - linkage(6)))
        % fprintf('ay length invalid\n');
        valid = false; return;
    end
    if (tol <= norm(norm(a-c) - linkage(7)))
        % fprintf('ac length invalid\n');
        valid = false; return;
    end
    if (tol <= norm(norm(y-c) - linkage(8)))
        % fprintf('yc length invalid\n');
        valid = false; return;
    end
    if (tol <= norm(norm(y-b) - linkage(9)))
        % fprintf('yb length invalid\n');
        valid = false; return;
    end
    if (tol <= norm(norm(c-d) - linkage(10)))
        % fprintf('cd length invalid\n');
        valid = false; return;
    end
    if (tol <= norm(norm(b-d) - linkage(11)))
        % fprintf('bd length invalid\n');
        valid = false; return;
    end
    if (tol <= norm(norm(b-e) - linkage(12)))
        % fprintf('be length invalid\n');
        valid = false; return;
    end
    if (tol <= norm(norm(d-e) - linkage(13)))
        % fprintf('de length invalid\n');
        valid = false; return;
    end
end