%% Initialize and configure plots:

graph = mvpalab_plotinit();

%% Mean accuracy plot (no statistical significance)

% Colors

% [255 94 0]/255 % Orange

% Axis limits:
graph.xlim = [-100 1500];
graph.ylim = [.48 .55];

% Axes labels and titles:
graph.xlabel = 'Time (ms)';
graph.ylabel = '';
graph.title = '';

% Smooth results:
graph.smoothdata = 5; % (1 => no smoothing)
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
load D:\AttExpLoc_EEG\Results\EEG\Definitive\Voltage\MVCC\CV\Cue\Averaged\Att_Exp_Cues\3T\results\time_resolved\auc\result.mat
load D:\AttExpLoc_EEG\Results\EEG\Definitive\Voltage\MVCC\CV\Cue\Averaged\Att_Exp_Cues\3T\results\time_resolved\auc\stats.mat
% graph.title = 'Plot (statistical significance)';
graph.shadecolor = graph.colors.mvpalab{1};
graph.sigh = .54;
graph.sigc = graph.shadecolor;
 
result = (result.ab + result.ba)/2

figure;
hold on
mvpalab_plotdecoding(graph,cfg,result, stats.mean);

load D:\AttExpLoc_EEG\Results\EEG\Definitive\Voltage\MVCC\CV\Cue\Averaged\Att_Cues\3T\results\time_resolved\auc\result.mat
load D:\AttExpLoc_EEG\Results\EEG\Definitive\Voltage\MVCC\CV\Cue\Averaged\Att_Cues\3T\results\time_resolved\auc\stats.mat

 
% result = (result.ab + result.ba)/2

graph.shadecolor = [97 74 232]/255;
graph.sigh = .565;
graph.sigc = [97 74 232]/255;
mvpalab_plotdecoding(graph,cfg,result,stats);



