%% Initialize and configure plots:

graph = mvpalab_plotinit();

%% Load results if needed: 
%% Mean accuracy plot (no statistical significance)

% Axis limits:
graph.xlim = [-100 1550];
 graph.ylim = [-0.5 2.5];

% Axes labels and titles:
graph.xlabel = 'Time (ms)';
graph.ylabel = '';
graph.title = 'FaceCueExp';

% Smooth results:
graph.smoothdata = 5; % (1 => no smoothing)
graph.linewidth = 2;

% Plot results:

chan = 7;

%tvalues = permute(tvalues, [1 2 4 3]);
%% Mean accuracy plot (statistical significance)
% 
% Load results and and statistics if needed:
% load  D:\AttExpLoc_EEG\Results\EEG\Definitive\Voltage\RSA\LDC\raw\result.mat
result =tvalues (1,:,:,chan); %cues
%stat = stats.model4.tvalues;
% Plot significant clusters (above and below chance):
graph.stats.above = true;
graph.stats.below = true;
graph.shadealpha = 0.3;
graph.shadecolor = graph.colors.sun{1};
% % Significant indicator:
graph.sigh = 1.25;
graph.sigc = graph.colors.sun{1};
% Title:
graph.title = 'Demo plot (statistical significance)';

% Plot results:
figure;
hold on
rsa_plotcr(graph,cfg,result);
hold on 
result = tvalues (2,:,:,chan); %category
%stat = stats.model3.tvalues;
graph.shadecolor = graph.colors.earth{1};
graph.sigc = graph.colors.earth{1};
graph.sigh = 1.3;
rsa_plotcr(graph,cfg,result);
result = tvalues (3,:,:,chan); %block
%stat = stats.model2.tvalues;
graph.shadecolor = graph.colors.venus{1};
graph.sigc = graph.colors.venus{1};
graph.sigh = 1.35;
rsa_plotcr(graph,cfg,result);%,stat
% result = tvalues (1,:,:);%block
% %stat = stats.model1.tvalues;
% graph.shadecolor = graph.colors.venus{1};
% graph.sigc = graph.colors.venus{1};
% graph.sigh = 1.4;
% rsa_plotcr(graph,cfg,result);%,stat

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
