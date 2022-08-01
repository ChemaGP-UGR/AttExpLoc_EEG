%% Initialize and configure plots:

graph = mvpalab_plotinit();
%cfg = mvpalab_checkcfg (cfg);
%% Load results if needed: 
% dir = [results];
% load ([dir 'result.mat']);
% load ([dir 'stats.mat']);

% Axis limits:
graph.xlim = [-100 1550];
graph.ylim = [-100 1550];
graph.caxis = [0];
% graph.onscreen = [0 190];

% Axes labels and titles:
graph.xlabel = 'Train (ms)';
graph.ylabel = 'Test (ms)';


%% Mean accuracy plot (statistical significance)

% Load results and and statistics if needed:

% Plot significant clusters (above and below chance):
graph.stats.above = true;
graph.stats.below = false;

% Significant indicator:
graph.sigh = .4;

% Colors:
graph.colorMap = graph.grads.venus;
graph.colors = graph.grads.venus;
graph.clusterLineColor = [0,0,0];
graph.clusterLineColor_ = [0,0,0.5];
graph.clusterLineWidth = 2;
graph.clusterLineWidth_ = 2;

% Title:
graph.title = 'T-value, Att Target Name, CTP Face';

% Plot results:
figure
hold on;
mvpalab_plottempogen(graph,cfg,result.auc, stats.auc);