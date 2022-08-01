freq = {'', 
   '\Alpha'
   '\Beta';
   '\Gamma';
   '\Theta'};
for i = 1:5
    dir1 = ['D:\AttExpLoc_EEG\Results\EEG\Definitive\Voltage\MVCC\CV\Cue\Averaged\Att_Exp_Cues' freq{i} '\3T\results\time_resolved\'];
    load([dir1 'auc\result.mat']);% 'results\temporal_generalization\auc\result.mat'
    load([dir1 'auc\permaps.mat']);
    
    % if Time_resolved
    result.mean = (result.ab + result.ba)/2;
    permaps.mean = (permaps.ab +permaps.ba)/2;
    
    % if TG
%     result.mean = (result.ab + permute (result.ba, [2 1 3]))/2;
%     permaps.mean =(permaps.ab + permute (permaps.ba, [2 1 3 4]))/2;
    
    permaps.mean = permute(permaps.mean, [1 2 4 3]);
    stats.mean = permtest_ctp(cfg,result.mean,permaps.mean);


    save ([dir1 'auc\result'], 'result');
    save ([dir1 'auc\permaps'], 'permaps');
    save ([dir1 'auc\stats'], 'stats');
end
