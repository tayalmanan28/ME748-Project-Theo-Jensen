% make and play movie of motion given trajectory

function M = traj_to_movie(trajectory, trajectory2)
    num_frames = size(trajectory,3);
    h = figure('visible', 'off');
    foot_pts = extract_pt_from_tr(trajectory, 8);
    % calculate frame limits
    if nargin == 2
        foot_pts2 = extract_pt_from_tr(trajectory2, 8);
        xmin = min( min(min(trajectory(:,1,:))), min(min(trajectory2(:,1,:))) );
        xmax = max( max(max(trajectory(:,1,:))), max(max(trajectory2(:,1,:))) );
        ymin = min( min(min(trajectory(:,2,:))), min(min(trajectory2(:,2,:))) );
        ymax = max( max(max(trajectory(:,2,:))), max(max(trajectory2(:,2,:))) );
    else
        xmin = min(min(trajectory(:,1,:)));
        xmax = max(max(trajectory(:,1,:)));
        ymin = min(min(trajectory(:,2,:)));
        ymax = max(max(trajectory(:,2,:)));
    end
    if (xmax-xmin) > (ymax-ymin)
        ymax = ymin + (xmax-xmin);
    else
        xmax = xmin + (ymax-ymin);
    end
    frame_limits = [floor(xmin) ceil(xmax) floor(ymin) ceil(ymax)];
    for i=1:num_frames
        clf;
        plot_linkage(trajectory(:,:,i), true, h, true);
        hold on;
        plot(foot_pts(1,:), foot_pts(2,:), '-', 'Color', [1 0 0]);
        if nargin == 2
            plot_linkage(trajectory2(:,:,i), true, h, false);
            plot(foot_pts2(1,:), foot_pts2(2,:), '-', 'Color', [0 0.6 0.6]);
        end
        hold off;
    	axis(frame_limits);
        axis square;
        M(i) = getframe();
    end
end