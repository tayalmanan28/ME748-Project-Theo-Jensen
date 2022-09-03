figure();
plot(max_fits);
hold on;
plot(min_fits, 'Color', [0.8 0 0]);
hold off;
legend('max fit', 'min fit');
xlabel('generation');

animate_linkage(L_best(end,:));

% threshold based on increase..
% divisions = 20;
% thresholds = linspace(min(max_fits), max(max_fits), divisions);
% 
% f = figure();
% for d=1:divisions
%     t = thresholds(d);
%     i = find(max_fits >= t, 1);
%     if isempty(i)
%         L = L_best(end,:);
%     else   
%         L = L_best(i,:);
%     end
%     [v, tr] = simulate_rotation(L);
%     clf;
%     plot_linkage(tr, true, f);
%     hold on;
%     ft = extract_pt_from_tr(tr, 8);
%     plot(ft(1,:), ft(2,:), 'Color', [0.8 0 0]);
%     b = extract_pt_from_tr(tr, 5);
%     plot(b(1,:), b(2,:), 'Color', [0.1 0.7 0.7]);
%     d = extract_pt_from_tr(tr, 7);
%     plot(d(1,:), d(2,:), 'Color', [0.7 0.1 0.7]);
%     hold off;
%     title(['best in generation ' num2str(i) ': ' num2str(max_fits(i))]);
%     drawnow;
%     pause;
%     if isempty(i) || t == max(max_fits)
%         break;
%     end
% end