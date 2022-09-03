% display the linkage on a plot
%
% pts = 8x2 array with rows:
%   x, y, p, a, b, c, d, e

function h = plot_linkage(pts, add_markers, h, newfigure)
    if nargin < 2
        add_markers = true;
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
    if nargin < 3
        h = figure();
    elseif newfigure
        figure(h);
    end
    hold on;
    % lines
    addline(x,p);
    addline(p,a);
    addline(p,b);
    addline(a,y);
    addline(a,c);
    addline(y,c);
    addline(y,b);
    addline(c,d);
    addline(b,d);
    addline(b,e);
    addline(d,e);
    % markers
    if add_markers
        addmarker(x);
        addmarker(y);
        addmarker(p);
        addmarker(a);
        addmarker(b);
        addmarker(c);
        addmarker(d);
        addmarker(e);
        
        text(x(1), x(2), 'x');
        text(y(1), y(2), 'y');
        text(p(1), p(2), 'p');
        text(a(1), a(2), 'a');
        text(b(1), b(2), 'b');
        text(c(1), c(2), 'c');
        text(d(1), d(2), 'd');
        text(e(1), e(2), 'e');
    end
    if nargin >= 4 && newfigure
        hold off;
    end
end

function addline(pt1, pt2)
    line([pt1(1) pt2(1)], [pt1(2) pt2(2)]);
end

function addmarker(pt1)
    line([pt1(1) pt1(1)], [pt1(2) pt1(2)], 'Marker', 'o');
end