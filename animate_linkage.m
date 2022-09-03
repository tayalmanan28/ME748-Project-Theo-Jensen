function [] = animate_linkage(L, twoside)
    if nargin < 2
        twoside = false;
    end
    [v tr] = simulate_rotation(L);
    if twoside
        [~, tr2] = simulate_rotation(L, 0, 2*pi, 128, -1);
    end
    if v
        if twoside        
            m = traj_to_movie(tr, tr2);
        else
            m = traj_to_movie(tr);
        end
        movie(m, 50, 30);
    else
        disp('invalid dimensions');
    end
end