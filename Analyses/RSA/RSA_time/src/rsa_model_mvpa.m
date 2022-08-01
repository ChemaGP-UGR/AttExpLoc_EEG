%load D:\AttExpLoc_EEG\Results\EEG\Definitive\Voltage\MVCC\CV\Cue\Averaged\Att_Cues\3T\results\time_resolved\auc\result.mat
load D:\AttExpLoc_EEG\Results\EEG\Definitive\Voltage\MVPA\Perm\Cue\Att\3T\results\time_resolved\auc\result.mat
load D:\AttExpLoc_EEG\Results\EEG\Definitive\Voltage\RSA\LDC\Raw\result.mat
for sub = 1:48
 
  mdl = fitlm(mean(tvalues,3)',result(:,:,sub)');
  tvalsub (sub,:) = mdl.Coefficients.tStat(2:end);
    
end
names = {'complete', 'block', 'cue', 'stim'};
complete = tvalsub(:,1);
block = tvalsub(:,2);
cue = tvalsub(:,3);
stim = tvalsub(:,4);
t = table(complete, block, cue, stim);
%t = t([1,3:5 7:8,10:12, 14:29,31:36,38:48],:);
figure
bar(mean(tvalsub,1))
writetable(t, 'D:\AttExpLoc_EEG\Results\EEG\Definitive\Voltage\mvpa_rsa.csv')