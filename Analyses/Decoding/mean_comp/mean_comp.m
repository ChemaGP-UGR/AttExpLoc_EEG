%% Data configuration
clear
freqs = {'\Theta'; '\Alpha'; '\Beta'; '\Gamma'};
for  f = 1:length (freqs)
    clear diff
    diff.info = 'Attention - Expectation';
    % load first condition
        dir1 = [results directory];
        load ([dir1 'results/temporal_generalization/auc/results.mat']);

    cond1.res = result; %save results and permaps before loading second condition
    cond1.per = permaps;
    cond1.loc = cfg.location;
    % load second condition
    if perm_estate(f)
        dir2 = [results directory];
        load ([dir2 'results/temporal_generalization/auc/sm_results.mat']);
    else
        dir2 = [results directory];
        load ([dir2 'results/temporal_generalization/auc/sm_results.mat']);
    end

    cond2.res = result; %save results and permaps before loading second condition
    cond2.per = permaps;
    cond2.loc = cfg.location;
    %% Data substraction
    % substract results and permaps
    diff.res.auc= cond1.res-cond2.res;
    diff.per.auc= cond1.per-cond2.per;

    %% Compute statistical significance
    cfg.stats.pclust = 99.9;
    cfg.stats.pgroup = 95;
    diff.stats = mvpalab_permtest(cfg,diff.res,diff.per);%permtest_ctp %mvpalab_permetest requieres a fieldname (res)
    diff.res = diff.res.auc+0.5; % for plot reasons may add 0.5
    
    save ([dir1 '/sm_diff'],'diff'); %save it in both folders
    save ([dir2 '/sm_diff'],'diff');
end

%% If decoding across
% for i =1% 5%:length(freq)
%     diff.info = 'Attention - Expectation';
%     % load first condition
%     dir1 = [results directory];
%     load([dir1 'auc\result.mat']);% 'results\temporal_generalization\auc\result.mat'
%     load([dir1 'auc\permaps.mat']);
% 
%     cond1.res.ab = result.ab; %save results and permaps before loading second condition
%     cond1.per.ab = permaps.ab;
%     cond1.res.ba = permute (result.ba, [2 1 3]); %save results and permaps before loading second condition
%     cond1.per.ba = permute (permaps.ba, [2 1 3]);
%     cond1.loc = cfg.location;
%     % load second condition
% %     dir2 = [results directory];
% %     load([dir2 'auc\result.mat']);% 'results\temporal_generalization\auc\result.mat'
% %     load([dir2 'auc\permaps.mat']);
% % 
% %     cond2.res.ab = result.ab; %save results and permaps before loading second condition
% %     cond2.per.ab = permaps.ab;
% %     cond2.res.ba = result.ba; %save results and permaps before loading second condition
% %     cond2.per.ba = permaps.ba;
%     
%     cond2.loc = cfg.location;
%     %% Data substraction
%     % substract results and permaps
%     diff.res = cond1.res.ab-cond1.res.ba;
%     diff.per = cond1.per.ab-cond1.per.ba;
%     
%     diff.per = permute(diff.per, [1 2 4 3]);
%     %% Compute statistical significance
%     % diff.per = permute (diff.per,[1 2 4 3]);
%     diff.stats = permtest_ctp(cfg,diff.res,diff.per);
% 
%     
%     diff.res = diff.res+0.5; % for plot reasons may add 0.5
%     
%     save ([dir1 '/diff_rot'],'diff'); %save it in both folders
% %     save ([dir2 '/diff'],'diff');
% end

%% If CTP

%     diff.info = 'Attention - Expectation';
%     % load first condition
%     dir1 = [results directory];
%     load([dir1 'results.mat']);% 'results\temporal_generalization\auc\result.mat'
% 
%     cond1.res.name = result.tvalues.tname.lname; %save results and permaps before loading second condition
%     cond1.per.name = permaps.tvalues.tname.lname;
%     cond1.loc = cfg.location;
%     % load second condition
%     dir2 = [results directory];
%     load([dir2 'results.mat']);% 'results\temporal_generalization\auc\result.mat'
% 
%     cond2.res.name = result.tvalues.tname.lname; %save results and permaps before loading second condition
%     cond2.per.name = permaps.tvalues.tname.lname;
%     
%     cond2.loc = cfg.location;
%     %% Data substraction
%     % substract results and permaps
%     diff.res.name = cond1.res.name-cond2.res.name;
%     diff.per.name = cond1.per.name-cond2.per.name;
%     %% Compute statistical significance
%     %diff.per = permute (diff.per,[1 2 4 3]);
%     diff.stats.name = permtest_ctp(cfg,diff.res.name,diff.per.name);
% 
%     diff.res = diff.res; %+0.5 % for plot reasons may add 0.5
%     
%     save ([dir1 '/diff'],'diff','cfg'); %save it in both folders
%     save ([dir2 '/diff'],'diff','cfg');
