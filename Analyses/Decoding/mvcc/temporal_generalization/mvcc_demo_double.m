%% MVPAlab TOOLBOX - (mvpa_demo.m)
% -------------------------------------------------------------------------
% Brain, Mind and Behavioral Research Center - University of Granada.
% Contact: dlopez@ugr.es (David Lopez-Garcia)
% -------------------------------------------------------------------------
% This script if for cross-classification between attention and
% expectation. The results are ab (train att test exp) y ba (train exp test
% att). 
clear; clc;

%% Initialize project and run configuration file:

cfg = mvpalab_init();

for an = 1:2
    
    run cfg_file_advanced_double;

    %% Load data, generate conditions and feature extraction:

    [cfg,data,fv] = mvpalab_import(cfg);

    %% Compute MVPA analysis:

    [result,cfg] = mvpalab_mvcc(cfg,fv);
    [permaps,cfg] = mvpalab_cpermaps(cfg,fv);
    
    res.acc.ab(:,:,:,an) = result.acc.ab;
    res.acc.ba(:,:,:,an) = result.acc.ba;
    res.auc.ab(:,:,:,an) = result.auc.ab;
    res.auc.ba(:,:,:,an) = result.auc.ba;
    per.acc.ab(:,:,:,:,an) = permaps.acc.ab;
    per.acc.ba(:,:,:,:,an) = permaps.acc.ba;
    per.auc.ab(:,:,:,:,an) = permaps.auc.ab;
    per.auc.ba(:,:,:,:,an) = permaps.auc.ba;
    

end
%% Compute permutation maps and run statistical analysis:

result.acc.ab = mean(res.acc.ab,4);
result.acc.ba = mean(res.acc.ba,4);
result.auc.ab = mean(res.auc.ab,4);
result.auc.ba = mean(res.auc.ba,4);

permaps.acc.ab = mean(per.acc.ab,5);
permaps.acc.ba = mean(per.acc.ba,5);
permaps.auc.ab = mean(per.auc.ab,5);
permaps.auc.ba = mean(per.auc.ba,5);

mvpalab_saveresults(cfg,result);
mvpalab_savepermaps(cfg,permaps);

stats = mvpalab_permtest(cfg,result,permaps);
[resultdiag,permapsdiag,statsdiag] = mvpalab_extractdiag(cfg,result,permaps);

%% Save cfg file:
save ([cfg.location 'results_raw'],'cfg', 'result', 'permaps', 'stats', 'resultdiag', 'permapsdiag', 'statsdiag');
mvpalab_savecfg(cfg);

%% Plot the results:
%run mvcc_plot;
