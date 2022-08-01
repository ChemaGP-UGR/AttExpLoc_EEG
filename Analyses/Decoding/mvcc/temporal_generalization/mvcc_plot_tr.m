%% Initialize and configure plots:

graph = mvpalab_plotinit();

%% Mean accuracy plot (no statistical significance)

load ('results');
% Axis limits:
graph.xlim = [-100 1550];
graph.ylim = [0.45 1];
graph.Yticks = 0.1

% Axes labels and titles:
graph.xlabel = 'Time (ms)';
graph.ylabel = '';


% Smooth results:
graph.smoothdata = 4; % (1 => no smoothing)
graph.linewidth = 2;

% Plot results:
 figure;
 hold on

%% Mean accuracy plot (statistical significance)

% Plot significant clusters (above and below chance):
graph.stats.above = true;
graph.stats.below = false;
graph.shadealpha = 0.3;

graph.shadecolor = graph.colors.venus{2};
graph.sigh = .48;
graph.sigc = graph.shadecolor;
mvpalab_plotdecoding(graph,cfg,result,stats);

graph.shadecolor = graph.colors.earth{1};
graph.linestyle = ':';
graph.sigh = .475;
graph.sigc = graph.colors. earth{1};
mvpalab_plotdecoding(graph,cfg,result,stats);
% 
% 
