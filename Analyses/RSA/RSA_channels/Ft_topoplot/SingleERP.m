clear

dir = 'D:\AttExpLoc_EEG\Data\EEG\conditions\mat\cue_name_1\';
sdir = 'directory to save';


load([dir '1.mat']);
load('D:\AttExpLoc_EEG\Results\EEG\Definitive\Voltage\RSA\LDC\Raw\3_conds\channels\result');
tvalues = permute(tvalues, [3 2 1 4]);
model = 3;

for sub = [1:48]
    % we load the eeglab preprocessed data from both conditions and
    % transform it into fieldtrip
   
        EEG.data = tvalues(:,:,model,sub);
        EEG.trials = size(model);
        EEG.xmin = min(cfg.tm.times);
        EEG.xmax = max(cfg.tm.times);
        EEG.pnts = length(cfg.tm.times);
        
        data = eeglab2fieldtrip(EEG,'raw', 'none');
        data.avg = data.trial{:};
        
%         cfg = [];
%         %cfg.xlim = [200 600];
%         ft_movieplotER (cfg, data);
%         %perform erp average

        cfg = [];
        cfg.latency = [-0.2 0.5];
        cfg.channel = (1:64);
        erp = ft_timelockanalysis(cfg,data);

        % and save it
        if ~isfolder ([sdir conds{cond}])
            mkdir([sdir conds{cond}])
        end
        save([sdir conds{cond} filesep int2str(sub)], 'erp');
end
