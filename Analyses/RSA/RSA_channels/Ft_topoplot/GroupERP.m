clear

%% Set directories and load ERP data (from SingleERP.m)

dir = 'D:\AttExpLoc_EEG\Data\EEG\conditions\mat\cue_name_1\';
sdir = 'directory to save';
conds = {'condition 1';   %conditions of interest, named as in their condition folder (e.g. 'new' and 'old')
        'condition 2'
        };
k = 1;  
l = 1;
m = 1;
load([dir '1.mat']);
load('D:\AttExpLoc_EEG\Results\EEG\Definitive\Voltage\RSA\LDC\Raw\3_conds\channels_only\result');
tvalues = permute(tvalues, [3 2 1 4]);
models = 1:3;
for sub = [1:48]
    for model = 1: length (models)
        EEG.data = tvalues(:,:,model,sub);
        EEG.trials = 1;
        EEG.xmin = min(0);
        EEG.xmax = max(0);
        EEG.pnts = 1;
        
        data = eeglab2fieldtrip(EEG,'raw', 'none');
        data.avg = data.trial{:};
        data.dimord = 'chan_time';
        data.time = data.time{:};
        if model ==1
            Subs_one{k} = data;
            k = k+1;
        elseif model == 2
            Subs_two{l} = data;
            l = l+1;
        else 
            Subs_three{m} = data;
            m = m+1;
        end
    end
end

%% General average of the results. Used for plots. 
% cfg = [];
% cfg.keepindividual = 'yes';
% %manmade
% ERP_one_in = ft_timelockgrandaverage(cfg,Subs_one{:});             %Use for plots in the mvpalab tool
% ERP_one_in.elec = erp.elec;% electrode information is lost in previous step
% %oldtural
% ERP_two_in = ft_timelockgrandaverage(cfg,Subs_two{:});                %En principio este resultado ya me lo puedo llevar a la toolbox                               
% ERP_two_in.elec = erp.elec;

cfg = [];
cfg.keepindividual = 'no';
%manmade
ERP_one_av = ft_timelockgrandaverage(cfg,Subs_one{:});             %Use for plots in the mvpalab tool
ERP_one_av.elec = data.elec;% electrode information is lost in previous step

ERP_two_av = ft_timelockgrandaverage(cfg,Subs_two{:});             %Use for plots in the mvpalab tool
ERP_two_av.elec = data.elec;% electrode information is lost in previous step

ERP_three_av = ft_timelockgrandaverage(cfg,Subs_three{:});             %Use for plots in the mvpalab tool
ERP_three_av.elec = data.elec;% electrode information is lost in previous step

avg(:,1) = ERP_one_av.avg;
avg(:,2) = ERP_two_av.avg;
avg(:,3) = ERP_three_av.avg;
avg = zscore(avg);

ERP_one_av.avg = avg(:,1);
ERP_two_av.avg = avg(:,2);
ERP_three_av.avg = avg(:,3);


%% Statistics

%% General statistics with all the channels
% cfg =[];
% cfg.elec = erp.elec;
% cfg.method = 'distance';
% neighbours = ft_prepare_neighbours(cfg); %necessary for cluster aoldlyses
% %cluster based permutation
% cfg = [];
% cfg.method = 'montecarlo';
% Nsub = 32;
% cfg.design(1, 1:2*Nsub) = [ones(1, Nsub) 2*ones(1, Nsub)];
% cfg.design(2, 1:2*Nsub) = [1:Nsub 1:Nsub];
% cfg.ivar = 1; % the 1st row in cfg.design contains the independent variable
% cfg.uvar = 2; % the 2nd row in cfg.design contains the subject number
% cfg.numrandomization = 100; %number of permutations
% cfg.correctm = 'cluster';
% cfg.neighbours = neighbours;
% cfg.tail = 0;
% cfg.correcttail = 'alpha';
% cfg.clusterthreshold = 'nonparametric_common';
% cfg.statistic = 'depsamplesT';%dependent samples, since it's a within subject design
% cfg.latency = [0.3 0.5];
% cfg.avgovertime = 'yes';
% cfg.avgoverchan = 'no';
% stat = ft_timelockstatistics(cfg, Subs_one{:}, Subs_two{:});
% one_over_two = stat.label(find(stat.posclusterslabelmat));
% two_over_one = stat.label(find(stat.negclusterslabelmat));
% 
% % Mean statistics for significant clusters
% 
% %one_over_two
% cfg = [];
% cfg.method = 'montecarlo';
% Nsub = 32;
% cfg.channel = one_over_two;
% cfg.design(1, 1:2*Nsub) = [ones(1, Nsub) 2*ones(1, Nsub)];
% cfg.design(2, 1:2*Nsub) = [1:Nsub 1:Nsub];
% cfg.ivar = 1; % the 1st row in cfg.design contains the independent variable
% cfg.uvar = 2; % the 2nd row in cfg.design contains the subject number
% cfg.numrandomization = 100; %number of permutations
% cfg.correctm = 'cluster';
% cfg.neighbours = neighbours;
% cfg.tail = 0;
% cfg.correcttail = 'alpha';
% cfg.clusterthreshold = 'nonparametric_common';
% cfg.statistic = 'depsamplesT';%dependent samples, since it's a within subject design
% cfg.latency = [0.3 0.5];
% cfg.avgovertime = 'yes';
% cfg.avgoverchan = 'yes';
% stat_1_2 = ft_timelockstatistics(cfg, Subs_one{:}, Subs_two{:});
% 
% % two_over_one
% cfg = [];
% cfg.method = 'montecarlo';
% Nsub = 32;
% cfg.channel = two_over_one;
% cfg.design(1, 1:2*Nsub) = [ones(1, Nsub) 2*ones(1, Nsub)];
% cfg.design(2, 1:2*Nsub) = [1:Nsub 1:Nsub];
% cfg.ivar = 1; % the 1st row in cfg.design contains the independent variable
% cfg.uvar = 2; % the 2nd row in cfg.design contains the subject number
% cfg.numrandomization = 100; %number of permutations
% cfg.correctm = 'cluster';
% cfg.neighbours = neighbours;
% cfg.tail = 0;
% cfg.correcttail = 'alpha';
% cfg.clusterthreshold = 'nonparametric_common';
% cfg.statistic = 'depsamplesT';%dependent samples, since it's a within subject design
% cfg.latency = [0.15 0.25];
% cfg.avgovertime = 'yes';
% cfg.avgoverchan = 'yes';
% stat_2_1 = ft_timelockstatistics(cfg, Subs_one{:}, Subs_two{:});


        cfg = [];
        %cfg.xlim = [1300 1400];
         cfg.zlim = [-2 2];

        cfg.colorbar = 'yes';
        cfg.style = 'both';
        cfg.framespersec = 1;
        cfg.rotate = 90;
        figure
        ft_topoplotER (cfg, ERP_three_av);
        hold on 
        title('');
        colormap jet
        set(gcf,'color','w');
%% Save everything
save([sdir conds{1} '_vs_' conds{2}], 'ERP_one_in', 'ERP_one_av', 'ERP_two_in', 'ERP_two_av', 'stat', 'Subs_one', 'Subs_two');

    