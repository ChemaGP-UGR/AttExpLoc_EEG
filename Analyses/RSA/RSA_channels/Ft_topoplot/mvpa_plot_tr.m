%% Initialize and configure plots:

graph = mvpalab_plotinit();

%% Mean accuracy plot (no statistical significance)

% Axis limits:
graph.xlim = [-0.1 0.5];
graph.ylim = [-2 3];

% Axes labels and titles:
graph.xlabel = 'Time (ms)';
graph.ylabel = 'Amplitude (Voltage)';
graph.title = 'Channel CP6';
channel = 53;
% Smooth results:
graph.smoothdata = 1; % (1 => no smoothing)
graph.linewidth = 2;

% Plot results:
% figure;
% hold on
% mvpalab_plotcr(graph,cfg,result);

%% Mean accuracy plot (statistical significance)

% Plot significant clusters (above and below chance):
graph.stats.above = true;
graph.stats.below = false;
graph.shadealpha = 0.3;


% Significant indicator:

%graph.colors.saturn{1}
% % Title:

hold on
% graph.title = 'Plot (statistical significance)';
graph.shadecolor = [255 94 0]/255;
graph.sigh = -1;
graph.sigc = [0.5 0.5 0.5];
 
result = permute(ERP_mm.individual,[2,3,1]);
cfg.tm.times = ERP_mm.time;

stat.sigmask = stat.mask(channel,:); %specify the channel here// no need to add it twice
stat.sigmask_ = 0*stat.sigmask;

figure;
hold on
mvpalab_plotERP(graph,cfg,result(channel,:,:), stat); %specify the electrode in the first dimension of stat and result. 

%% Condition 2
graph.shadecolor = [97 74 232]/255;
graph.sigh = .565;
graph.sigc = [0 0 0]/255;
result = permute(ERP_na.individual,[2,3,1]);

mvpalab_plotERP(graph,cfg,result(channel,:,:));
hold on

legend ({'Manmade', 'Natural'});

% graph.shadecolor = graph.colors.jupiter{1};
% graph.sigh = .44;
% graph.sigc = graph.colors.jupiter{1};
% mvpalab_plotcr(graph,cfg,result,stats);
% 
% load D:\AttExpLoc_EEG\Results\EEG\Definitive\Voltage\MVPA\Perm\Target\Att\Inv\3T\results\time_resolved\auc\result.mat
% load D:\AttExpLoc_EEG\Results\EEG\Definitive\Voltage\MVPA\Perm\Target\Att\Inv\3T\results\time_resolved\auc\stats.mat
% graph.shadecolor = graph.colors.jupiter{2};
% graph.linestyle = ':';
% graph.sigh = .42;
% graph.sigc = graph.colors.jupiter{2};
% mvpalab_plotcr(graph,cfg,result,stats);


