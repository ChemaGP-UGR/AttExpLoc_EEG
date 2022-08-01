%% Initialize and configure plots:

graph = mvpalab_plotinit();

%% Load results if needed: 

dir = 'D:\AttExpLoc_EEG\Results\EEG\Definitive\Voltage\MVCC\CV\Cue\Averaged\Att_Exp_Cues\3T\';%10P\p001\3tps\
load ([dir 'results/temporal_generalization/auc/smp01_results.mat']);%results/temporal_generalization/auc/
direction = 'ba';
load light_cmap.mat;
% load ([dir 'results/temporal_generalization/auc/stats.mat']);%

%% Stats separate plot, for differences 
% stats_cmap = [[255 94 0]/255;[1 1 1]; [97 74 232]/255];
% stats_thres = imgaussfilt(~diff.stats.auc.sigmask + ~diff.stats.auc.sigmask_.*-1,1);
% figure;
% hold on 
% clim = [-1 1];
% imagesc(cfg.tm.times', cfg.tm.times', stats_thres);
% caxis(clim);
% xlim([0 1550]);
% ylim([0 1550]);
% colormap(stats_cmap);
% set(gca,'XMinorTick','on','YMinorTick','on');
% set(gca,'XTickLabelRotation',90);
% set(gca,'YAxisLocation','origin');
% set(gca,'XAxisLocation','origin');
% set(gca,'YColor','k');
% set(gca,'XColor','k');
% set(gca,'FontSize',graph.fontsize);
% set(gca,'Layer','top');
% set(gcf,'color','w');
% set(gcf,'position', [400 300 800 700])



%% Normal decoding
graph.xlim = [0 1550];
graph.ylim = [0 1550];
graph.caxis = [0.48 0.53];
% graph.onscreen = [0 190];

% Axes labels and titles:
if strcmp(direction, 'mean')
    graph.xlabel = 'Expectation';
    graph.ylabel = 'Attention';
else
    graph.xlabel = 'Train (ms)';
    graph.ylabel = 'Test (ms)';
end



% Plot TG:
% figure;
% subplot(1,2,1);
% hold on;
% mvpalab_plottg(graph,cfg,result);


%% Mean accuracy plot (statistical significance)

% Load results and and statistics if needed:
%  load 'D:\AttExpLoc_EEG\Results\EEG\Definitive\Voltage\MVCC/CV/Cue/Averaged/Att_Exp_Cues/3T/100P/p001/6tps/Theta/results\temporal_generalization\auc\result.mat'
%  load 'D:\AttExpLoc_EEG\Results\EEG\Definitive\Voltage\MVCC/CV/Cue/Averaged/Att_Exp_Cues/3T/100P/p001/6tps/Theta/results\temporal_generalization\auc\stats.mat'

%  cfg = mvpalab_checkcfg(cfg);
%  cfg.tm.tpstart_ = cfg.tm.tpstart;
%  cfg.tm.tpend_ = cfg.tm.tpend;

% Plot significant clusters (above and below chance):
graph.stats.above = true;
graph.stats.below = false;

% Significant indicator:
graph.sigh = .4;



% Colors:
graph.colorMap = light_cmap;
graph.colors = graph.grads.mvpalab;
graph.clusterLineColor = [0,0,0];
graph.clusterLineColor_ = [0,0,0.5];
graph.clusterLineWidth = 2;
graph.clusterLineWidth_ = 2;

% Title:
graph.title = '';
%result = squeeze(tvalues(2,:,:,:));
% Plot results:
%subplot(1,2,2);
figure
hold on;
mvpalab_plottempogen(graph,cfg,result.(direction),stats.(direction));%,stats