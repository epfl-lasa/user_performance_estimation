

%% Stiffness of the passive arm

% First plot per user

load('../S2_task_analysis/metrics_all_per_subject_Segm2_NVR.mat');
load('../S2_task_analysis/headers_metrics_all_per_user_NVR.mat');


% col 18 - 19 - 20 - Stiffness passive arm X, Y, Z
% auto_skill column 3

for axs = 1:3
    
    figure; hold on; %ftitle = sprintf('Max F dir %d per user', axs); title(ftitle);
    

    % Plot separately a sk and unsk subject to generate a proper legend 
    stem(6, S2_metrics_all(6,17+axs), 'r', 'Marker', 'diamond', ...
        'MarkerFaceColor', 'r', 'MarkerSize', 12, 'LineWidth', 2, 'LineStyle', '--'); % Plot FT of skilled user in red
    stem(7, S2_metrics_all(7,17+axs), 'b', 'Marker', 'diamond', ...
        'MarkerFaceColor', 'b', 'MarkerSize', 12, 'LineWidth', 2, 'LineStyle', '--'); % Plot FT of skilled user in red
    legend('Skilled', 'Unskilled');

    % Now plot all
    for i = 1:37
        if S2_metrics_all(i,3) == 1
            stem(i, S2_metrics_all(i,17+axs), 'r', 'Marker', 'diamond', ...
                'MarkerFaceColor', 'r', 'MarkerSize', 12, 'LineWidth', 2, 'LineStyle', '--'); % Plot FT of skilled user in red
        else
            stem(i, S2_metrics_all(i,17+axs), 'b', 'Marker', 'diamond', ...
                'MarkerFaceColor', 'b', 'MarkerSize', 12, 'LineWidth', 2, 'LineStyle', '--'); % Plot FT of skilled user in blue
        end
    end
    
    ylabel('Stiffness modulation');
    xlabel('Subjects');
    
    % Figure formatting
    set(gcf, 'Color', [1 1 1]); grid on;
    set(gca, 'XColor', [0.45 0.45 0.45], 'YColor', [0.45 0.45 0.45], 'ZColor', [0.45 0.45 0.45]);
    
    set(findall(gcf,'type','text'), 'FontSize', 32);
    set(findall(gcf,'type','axes'), 'FontSize', 32);
    
    set(findall(gca, 'Type', 'Line'),'LineWidth', 2.5);
    
    set(gcf, 'Position', [206 195 1259 696]);
    set(gca,'position',[0.1 0.2 0.87 0.75],'units','normalized')

       
    fname = sprintf('lambda_passive_arm_ax%d_per_user.fig', axs);
    savefig(fname);
    fname = sprintf('lambda_passive_arm_ax%d_per_user.png', axs);
    saveas(gcf, fname);
    
end


%% Correlate stiffness values with the maximum force applied on each axis

% For the passive arm
fprintf('%.2f   \t %s - %s \n', corr(S2_metrics_all(:,18), S2_metrics_all(:, 42)), nh{18}, nh{42});
fprintf('%.2f   \t %s - %s \n', corr(S2_metrics_all(:,19), S2_metrics_all(:, 43)), nh{19}, nh{43});
fprintf('%.2f   \t %s - %s \n', corr(S2_metrics_all(:,20), S2_metrics_all(:, 44)), nh{20}, nh{44});

% For the active arm
fprintf('%.2f   \t %s - %s \n', corr(S2_metrics_all(:,21), S2_metrics_all(:, 42)), nh{21}, nh{42});
fprintf('%.2f   \t %s - %s \n', corr(S2_metrics_all(:,22), S2_metrics_all(:, 43)), nh{22}, nh{43});
fprintf('%.2f   \t %s - %s \n', corr(S2_metrics_all(:,23), S2_metrics_all(:, 44)), nh{23}, nh{44});


%% Compute anovas

for i = 18:23
    [a,b] = anova1(S2_metrics_all(:,i), S2_metrics_all(:,3), 'off');
    fprintf('F = %.2f, p-value = %.3f, Factor: auto-skill; Metric: column %d - %s \n', b{2,5}, a, i, nh{i});
end

%% Compute correlations

for i = 18:23
    for j = 3:11
        ctmp = corr(S2_metrics_all(:,i), S2_metrics_all(:,j), 'Type', 'Spearman');
        fprintf('%.2f, \t \t corr %s - %s \n', ctmp, nh{i}, nh{j});
    end
end

%% Compute mean and averages for skilled and unskilled

% Passive arm
% x axis
fprintf('\n');
sk_passive_stiff_X = S2_metrics_all(find(S2_metrics_all(:,3) == 1), 18); % select skilled subjects only
fprintf('axis 1 - passive arm - %d skilled \t\t - avg stiff %.2f, std %.2f \n', ...
    length(sk_passive_stiff_X), mean(sk_passive_stiff_X), std(sk_passive_stiff_X));
nsk_ps_X = S2_metrics_all(find(S2_metrics_all(:,3) == 0), 18); % select skilled subjects only
fprintf('axis 1 - passive arm - %d unskilled \t - avg stiff %.2f, std %.2f \n', ...
    length(nsk_ps_X), mean(nsk_ps_X), std(nsk_ps_X));

% with threshold
% fprintf('axis 1 - passive arm - %d unskilled \t - avg stiff %.2f, std %.2f \n', ...
%     length(find(nsk_ps_X < 0.4)), mean(nsk_ps_X(find(nsk_ps_X < 0.4))), std(nsk_ps_X(find(nsk_ps_X < 0.4))));
% fprintf('axis 1 - passive arm - %d unskilled \t - avg stiff %.2f, std %.2f \n', ...
%     length(find(nsk_ps_X > 0.4)), mean(nsk_ps_X(find(nsk_ps_X > 0.4))), std(nsk_ps_X(find(nsk_ps_X > 0.4))));


% y axis
fprintf('\n');
sk_passive_stiff_Y = S2_metrics_all(find(S2_metrics_all(:,3) == 1), 19); % select skilled subjects only
fprintf('axis 2 - passive arm - %d skilled \t\t - avg stiff %.2f, std %.2f \n', ...
    length(sk_passive_stiff_Y), mean(sk_passive_stiff_Y), std(sk_passive_stiff_Y));
nsk_ps_Y = S2_metrics_all(find(S2_metrics_all(:,3) == 0), 19); % select skilled subjects only
fprintf('axis 2 - passive arm - %d unskilled \t - avg stiff %.2f, std %.2f \n', ...
    length(nsk_ps_Y), mean(nsk_ps_Y), std(nsk_ps_Y));

% with threshold
% fprintf('axis 2 - passive arm - %d unskilled \t - avg stiff %.2f, std %.2f \n', ...
%     length(find(nsk_ps_Y < 0.4)), mean(nsk_ps_Y(find(nsk_ps_Y < 0.4))), std(nsk_ps_Y(find(nsk_ps_Y < 0.4))));
% fprintf('axis 2 - passive arm - %d unskilled \t - avg stiff %.2f, std %.2f \n', ...
%     length(find(nsk_ps_Y > 0.4)), mean(nsk_ps_Y(find(nsk_ps_Y > 0.4))), std(nsk_ps_Y(find(nsk_ps_Y > 0.4))));

% Z axis
fprintf('\n');
sk_passive_stiff_Z = S2_metrics_all(find(S2_metrics_all(:,3) == 1), 20); % select skilled subjects only
fprintf('axis 3 - passive arm - %d skilled \t\t - avg stiff %.2f, std %.2f \n', ...
    length(sk_passive_stiff_Z), mean(sk_passive_stiff_Z), std(sk_passive_stiff_Z));
nsk_ps_Z = S2_metrics_all(find(S2_metrics_all(:,3) == 0), 20); % select skilled subjects only
fprintf('axis 3 - passive arm - %d unskilled \t - avg stiff %.2f, std %.2f \n', ...
    length(nsk_ps_Z), mean(nsk_ps_Z), std(nsk_ps_Z));

% with threshold
% fprintf('axis 3 - passive arm - %d unskilled \t - avg stiff %.2f, std %.2f \n', ...
%     length(find(nsk_ps_Z < 0.4)), mean(nsk_ps_Z(find(nsk_ps_Z < 0.4))), std(nsk_ps_Z(find(nsk_ps_Z < 0.4))));
% fprintf('axis 3 - passive arm - %d unskilled \t - avg stiff %.2f, std %.2f \n', ...
%     length(find(nsk_ps_Z > 0.4)), mean(nsk_ps_Z(find(nsk_ps_Z > 0.4))), std(nsk_ps_Z(find(nsk_ps_Z > 0.4))));
