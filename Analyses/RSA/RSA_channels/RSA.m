%% MVPA TOOLBOX - (cr_analysis.m)
% -------------------------------------------------------------------------
% Brain, Mind and Behavioral Research Center - University of Granada.
% Contact: % cgpenalver@ugr.es (Chema G. Peñalver)
% -------------------------------------------------------------------------
clear
%% Initialize project and configure analysis:
addpath ('src/');
cfg = mvpalab_init(); %mvpalab toobox. Importing is made through it. 
run cfg_rsa.m; %modified from mvpa scripts, may have irrelevant info. 

%% Load data, generate conditions, feature extraction and RDMs:
[cfg,data,fv] = mvpalab_import_rsa(cfg);
run RSA_LDC %Generates RDMs

%% Compute correct rate and permuted maps:
 
[~, betas, tvalues, cfg] = rsa_ModelComp_LDC(cfg,fv,RDMs,0,'content'); %compare to other RDMs (theoretical, empirical...)
% [~, permuted_betas, permuted_tvalues, cfg] = rsa_ModelComp_LDC_perm(cfg,fv,RDMs,1,'complete'); %run permutations for statistical analyses
    


%% Run statiscctical analysis:
% if cfg.classmodel.regress
%     result = tvalues(1,:,:);    %tvalues
%     permuted_maps = permuted_tvalues(1,:,:,:); %cluster based permutations
%     stats.model1.tvalues = permtest_rsa(cfg,result,permuted_maps);
%     result = tvalues(2,:,:);    %tvalues
%     permuted_maps = permuted_tvalues(2,:,:,:);
%     stats.model2.tvalues = permtest_rsa(cfg,result,permuted_maps);
%     result = tvalues(3,:,:);    %tvalues
%     permuted_maps = permuted_tvalues(3,:,:,:);
%     stats.model3.tvalues = permtest_rsa(cfg,result,permuted_maps);
%     result = tvalues(4,:,:) ;   %tvalues
%     permuted_maps = permuted_tvalues(4,:,:,:);
%     stats.model4.tvalues = permtest_rsa(cfg,result,permuted_maps);
% end

%% Save results:
if ~exist(cfg.location, 'dir')
    mkdir (cfg.location);
end

save([cfg.location 'result'],'betas','tvalues', 'cfg','RDMs');%'stats'

