function [score stresses] = score_stress(tr)
    % define each rod as pair of 2 endpoints
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
    
    rod_pairs = [[1 3]; % x-p
                 [3 4]; % p-a
                 [3 5]; % p-b
                 [4 2]; % a-y
                 [4 6]; % a-c
                 [2 6]; % y-c
                 [2 5]; % y-b
                 [6 7]; % c-d
                 [5 7]; % b-d
                 [5 8]; % b-e
                 [7 8]];% d-e
    
	pt_diffs = diff(tr, 1, 3);
             
    stresses = zeros(11,1);
    
	n = size(tr, 3);
             
    for r=1:11
        % extract trajectory for this rod's first endpoint
        a = rod_pairs(r,1);
        A = reshape(tr(a,:,:), 2, n);
        dA = reshape(pt_diffs(a,:,:), 2, n-1);
        
        % extract trajectory for this rod's second endpoint
        b = rod_pairs(r,2);
        B = reshape(tr(b,:,:), 2, n);
        dB = reshape(pt_diffs(b,:,:), 2, n-1);
        
        % get the vector describing the rod itself (A-B) over time and
        %   average it
        rod = A-B;
        rod_avgs = (rod(:,2:end) + rod(:,1:end-1))/2;
        
        % stress is minimum at 90 degrees and max at 0 or 180 and is also
        % proportional to the magnitude of the movement and the length of
        % the lever arm
        %   dot product express exactly that..
        % this takes the dot product of the rod's orientation with the
        %   movement vector of its endpoints, at each pt in time, averaged
        stress_A = sum(abs(dot(dA, rod_avgs))) / (n-1);
        stress_B = sum(abs(dot(dB, rod_avgs))) / (n-1);
        
        % this is hacky - total stress is just avg of stress at two endpts
        stresses(r) = (stress_A + stress_B) / 2;
    end
    
    total_stress = mean(stresses);
    
    score = exp(-total_stress);
end