function score = score_foot_trajectory(pts, show)
    if nargin<2
        show = false;
    end
    x = pts(1,:);
    y = pts(2,:);
    if max(y) > 0
        score = 0; return;
    end
    
    % triangleness
    [~, ni] = min(x);
    [~, xi] = max(x);
    
    range1 = min(ni,xi):max(ni,xi);
    vals1 = y(range1);
    vals2 = [y(range1(end)+1:end) y(1:range1(1)-1)];
    
    lo = vals1;
    hi = vals2;
    xlo = x(range1);
    xhi = [x(range1(end)+1:end) x(1:range1(1)-1)];
    
    if mean(vals1) > mean(vals2)
        lo = vals2;
        hi = vals1;
        temp = xlo;
        xlo = xhi;
        xhi = temp;
    end
    
    if show
        figure();
        plot(xlo, lo);
        hold on;
        plot(xhi, hi, 'Color', [1 0 0]);
        hold off;
    end
    
    spikes = sum(abs(lo - mean(lo))) / length(lo);
    flat_bottom_score = exp(-spikes/10); % div by 10 means closer to 0, meaning more sensitiv eto change.
    ydiff = max(hi)-mean([hi(end) hi(1)]);
    height_score = 1 - exp(-ydiff * 4);

    if show
        fprintf('spikes = %f\n', spikes);
        fprintf('flat_bottom_score = %f\n', flat_bottom_score);
        fprintf('ydiff = %f\n', ydiff);
        fprintf('height_score = %f\n', height_score);
    end
    
    spike_hi = max(abs(diff(hi,2)));
    score_diff2 = exp(-spike_hi);
    spike_x = max(abs(diff(x,2)));
    score_xdiff2 = exp(-spike_x);
    
    walk_to_recover_score = 1 - exp(-(length(lo) / length(hi)));
    wide_stance_score = 1 - exp(-(mean(x)));
    
    score = flat_bottom_score ^ 8 * walk_to_recover_score * height_score * wide_stance_score * score_diff2 * score_xdiff2;
    
    if hi(floor(end/2)) < hi(end) || hi(floor(end/2)) < hi(1)
        score = score*0.1;
    end

%     xrange = xx - nx;
%     yrange = max(y) - min(y);
%     area = abs(polyarea(x,y));
%     score = area / (xrange^2);
%     score = score / (mean(x)+eps); % prefer closer to 0
end