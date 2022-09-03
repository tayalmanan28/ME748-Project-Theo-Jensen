% given a trajectory, gives it a score in [0,1]
%   0 if it failed or broke

function score = score_trajectory(tr, n, verbose)
    if nargin < 3
        verbose = false;
    end
    if size(tr,3) < n
        score = 0;
        if verbose
            disp('simulation incomplete. invalid linkage.');
        end
        return;
    end
    pts_e = extract_pt_from_tr(tr, 8);
    s_foot = score_foot_trajectory(pts_e);
    s_stress = score_stress(tr) ^ 1;
    score = s_foot * s_stress;
    if verbose
        fprintf('s_foot = %f\ns_stress = %f\n', s_foot, s_stress);
    end
    
    % if the heel goes below the foot, penalize heavily
    pts_b = extract_pt_from_tr(tr, 5);
    pts_d = extract_pt_from_tr(tr, 7);
    if (~isempty(find(pts_b(2,:) < pts_e(2,:), 1)) || ~isempty(find(pts_d(2,:) < pts_e(2,:), 1)))
        score = score*0.01;
        if verbose
            disp('heel too low - big pentalty.');
        end
    end
end