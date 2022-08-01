%% ELECTROENCEPHALOGRAPHY PREPROCESSING - (trial_rejection.m)
% -------------------------------------------------------------------------
% Chema Peñalver
% AttExpLoc_EEG
% cgpenalver@ugr.es
% CIMCYC - University of Granada
% -------------------------------------------------------------------------
clear
clc

%% Initialization:
run subjects_to_compute
run conf

%% Automatic trial rejection:
for i = 1:tot_subs
    elecrange   = channels_to_keep{i}; 
    elec_comp   = channels_to_keep{i};

    % Import subject's data:
    EEG = pop_loadset('filename',subjects_to_load_icapruned{i},'filepath',dir_to_load);
    total_trials(i) = EEG.trials;
    
    if abnormal_trend_rej
        
    end
    
    if abnormal_distr_rej
        
    end
    
    %% Automatic trial rejection by abnormal spectra:
    if abnormal_spect_rej
        [EEG,ab_spec_idxs{i}] = pop_rejspec( EEG,typerej,...
            'elecrange',elec_comp,...
            'method',method,...
            'threshold',threshold,...
            'freqlimits',freqlimits,...
            'eegplotreject',eegplotreject);
        nrej_ab_spec(i) = length(ab_spec_idxs{i});
        EEG = pop_rejepoch(EEG, ab_spec_idxs{i},0);
    end
    
    %% Automatic trial rejection by improbable data:
    if improbable_data_rej
        [EEG,~,~,nrej_improbable_data(i)] = pop_jointprob(EEG,typerej,...
            elec_comp,locthresh,globthresh,superpose,reject,1);
    end
    
    %% Automatic trial rejection by extreme values:
    if extreme_values_rej
        [EEG ext_values_idxs{i}] = pop_eegthresh(EEG,typerej,elec_comp,...
            lowthresh,upthresh,EEG.xmin,EEG.xmax,superpose,reject);
        nrej_ext_values(i) = length(ext_values_idxs{i});
    end
    
    %% Save pruned data:

    EEG.setname = [subjects_to_load{i}(1:4) '_trialpruned'];
    
    EEG = pop_saveset(EEG, 'filename',EEG.setname,'filepath', dir_to_save);
end

% Output statistics:
per_abnormal_spectra = (nrej_ab_spec*100./total_trials)';
per_improbable_data = (nrej_improbable_data*100./total_trials)';
per_extreme_values = (nrej_ext_values*100./total_trials)';

% Output table generation:
clear t
t.Subject = subjects_to_load;
t.AbSpec = nrej_ab_spec';
t.PerAS = per_abnormal_spectra;
t.ImpData = nrej_improbable_data';
t.PerID = per_improbable_data;
t.ExtVal = nrej_ext_values';
t.PerEV = per_extreme_values;
t.Total = (nrej_ext_values + nrej_improbable_data + nrej_ab_spec)';
t.Per = per_extreme_values + per_improbable_data + per_abnormal_spectra;
t = struct2table(t);
save([dir_to_save 'rejected'], 't');



