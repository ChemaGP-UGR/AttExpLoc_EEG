%% Initialize and configure plots:

graph = mvpalab_plotinit();


%% Mean accuracy plot (no statistical significance)

% Axis limits:
graph.xlim = [-100 1550];
graph.ylim = [-5 12];

% Axes labels and titles:
graph.xlabel = 'Time (ms)';
graph.ylabel = '';


% Smooth results:
graph.smoothdata = 6; % (1 => no smoothing)
graph.linewidth = 2;

% Plot results:
% figure;
% hold on
% mvpalab_plotcr(graph,cfg,result);

%% Mean accuracy plot 

graph.stats.above = true;
graph.stats.below = false;
graph.shadealpha = 0.3;

graph.title = 'Cue - Name CTP';

figure
hold on 
%% Difference
 % Att>Exp
load results.mat
graph.shadecolor = [1 1 1];
graph.linewidth = 2;
graph.shadealpha = 0.3;
graph.sigh = 12;
graph.sigc = [0 0 0];
graph.stats.above = true; 
graph.stats.below = false;
mvpalab_plotdecoding_ctp(graph,cfg,diff.res.name, diff.stats.name);
 % Exp > Att
graph.sigh = 12;
graph.sigc = [0.5 0.5 0.5];
graph.stats.above = false; 
graph.stats.below = false;
mvpalab_plotdecoding_ctp(graph,cfg,diff.res.name, diff.stats.name);


%% Expectation
hold on
load results.mat

graph.shadecolor = [255 94 0]/255;
graph.linestyle = '-';
graph.sigc =graph.shadecolor;
graph.sigh = 11;
graph.stats.above = true; 
graph.stats.below = false;
mvpalab_plotdecoding_ctp(graph,cfg,result.tvalues.tname.lname, stats.tvalues.tname.lname); %,stats.tvalues.tname.lname

%% Attention
load results.mat
hold on 
graph.shadecolor = [97 74 232]/255;
graph.sigh = 11.5;
graph.sigc = graph.shadecolor;
mvpalab_plotdecoding_ctp(graph,cfg,result.tvalues.tname.lname, stats.tvalues.tname.lname);



