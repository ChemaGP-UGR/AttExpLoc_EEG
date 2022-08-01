%% Initialize and configure plots:

graph = mvpalab_plotinit();

%% Load results if needed: 
%% Mean accuracy plot (no statistical significance)

% Axis limits:
graph.xlim = [-100 1550];
 graph.ylim = [-0.5 2.4];

% Axes labels and titles:
graph.xlabel = 'Time (ms)';
graph.ylabel = '';
graph.title = 'FaceCueExp';

% Smooth results:
graph.smoothdata = 5; % (1 => no smoothing)
graph.linewidth = 2;

% Plot results:


%% Mean accuracy plot (statistical significance)
% 
% Load results and and statistics if needed:
% load  D:\AttExpLoc_EEG\Results\EEG\Definitive\Voltage\RSA\LDC\Raw\3_conds_interaction\result.mat
result = betas (1,:,:); %cues
stat = stats.model1.tvalues;
% Plot significant clusters (above and below chance):
graph.stats.above = true;
graph.stats.below = true;
graph.shadealpha = 0.3;
graph.shadecolor = graph.colors.sun{2};
% % Significant indicator:
graph.sigh = 2.1;
graph.sigc = graph.colors.sun{2};
% Title:
graph.title = '';

% Plot results:
figure;
hold on
rsa_plotcr(graph,cfg,result,stat);
hold on 
result = tvalues (2,:,:); %category
stat = stats.model2.tvalues;
graph.shadecolor = graph.colors.earth{1};
graph.sigc = graph.colors.earth{1};
graph.sigh = 2.3;
rsa_plotcr(graph,cfg,result,stat);
result = tvalues (3,:,:); %block
stat = stats.model3.tvalues;
graph.shadecolor = graph.colors.venus{1};
graph.sigc = graph.colors.venus{1};
graph.sigh = 2.2;
rsa_plotcr(graph,cfg,result,stat);%,stat

% figure;
% hold on 
% load  D:\AttExpLoc_EEG\Results\EEG\Definitive\Voltage\RSA\LDC\Cues\result.mat
% graph.shadecolor = graph.colors.sun{1};
% graph.sigc = graph.colors.mvpalab{1};
% graph.sigh = -.001;
% rsa_plotcr(graph,cfg,result,stats);
% load D:\AttExpLoc_EEG\Results\EEG\Definitive\Voltage\RSA\LDC\Complete\result.mat
% graph.shadecolor = graph.colors.jupiter{1};
% graph.sigc = graph.colors.venus{1};
% graph.sigh = -.003;
% rsa_plotcr(graph,cfg,result);
% load D:\AttExpLoc_EEG\Results\EEG\Definitive\Voltage\RSA\LDC\Block\result.mat
% graph.shadecolor = graph.colors.venus{1};
% graph.sigc = graph.colors.venus{1};
% graph.sigh = -.003;
% rsa_plotcr(graph,cfg,result);
% load D:\AttExpLoc_EEG\Results\EEG\Definitive\Voltage\RSA\LDC\Content\result.mat
% graph.shadecolor = graph.colors.earth{1};
% graph.sigc = graph.colors.earth{1};
% graph.sigh = -.003;
% rsa_plotcr(graph,cfg,result);
