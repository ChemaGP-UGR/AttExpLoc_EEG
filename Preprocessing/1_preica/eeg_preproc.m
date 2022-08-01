%% ELECTROENCEPHALOGRAPHY PREPROCESSING - (eeg_preproc.m)
% -------------------------------------------------------------------------
% Chema Peñalver
% AttExpLoc_EEG
% cgpenalver@ugr.es
% CIMCYC - University of Granada
% -------------------------------------------------------------------------

% Automatic EEG preprocessing before compute ICA algorithms:
%
% - 1. Merge split datasets (due to technical problems during data
% collection).
% - 2. Rename events.
% - 3. Change sampling rate.
% - 4. Filter data.
% - 5. Epoched data.
%
%% Notes: 
%
% - Amplifier's online cut-off frecuencies: [0.016-250]Hz
% - Lower cut-off frecuency [s]: Time constant = 10s - fc = 1/2*pi*t
% - See Brain Vision documentation for more details.

clear
clc

%% Add my function folder to MATLAB path:
path(path,'../Prepreprocesado/');

%% Directories:
dir_to_load = '../../../Data/EEG/Raw';
dir_to_save = '../../../Data/EEG/Epoch5S/Epoched/';
create_folder(dir_to_save);

%% Preprocessing configuration:
run subjects_to_preproc
run merge
run triggers_to_extract

fs_resample     = 256;
chan_to_load    = (1:63);
filter_order    = [];
lpass_fcutoff   = 0.1;
hpass_fcutoff   = 120;
trial_bound     = [-1 2];
n_extract_epoch = NaN(1,length(subjects_to_load));

%% Preprocessing loop:
for sub = 1: length(subjects_to_load)
    
    % Import subject data:
        
     if ismember (sub, mer)   %If data comes from a merged (.set) file:     
         EEG = pop_loadset('filename',subjects_to_load{sub},'filepath',dir_to_load); 
     else  %If data comes from raw BrainVision file: 
        EEG = pop_loadbv(dir_to_load, subjects_to_load{sub}, 1, chan_to_load);
     end
    % Rename events:
    EEG.event = rename_events(EEG.event, subjects_to_load{sub});
    
    % Change sampling rate:
    EEG = pop_resample(EEG, fs_resample);
    
    % Filter data:
    EEG = pop_eegfiltnew(EEG,[],hpass_fcutoff,filter_order,0,[],0);
    EEG = pop_eegfiltnew(EEG,lpass_fcutoff,[],filter_order,0,[],0);
    % Notch data:
    EEG = pop_eegfiltnew(EEG, 49,51,filter_order,1,[],0); 
    EEG = pop_eegfiltnew(EEG, 99,101,filter_order,1,[],0);   
    % Epoch data:
    EEG = pop_epoch(EEG, events_to_extract, trial_bound,...
        'newname', 'epochs', 'epochinfo', 'yes');
    n_extract_epoch(sub) = EEG.trials;
    
    % SAVE epoched DATA
    if ismember (sub, new)
        if ismember (sub, mer)
            EEG = pop_saveset(EEG, ...
                'filename',['S' subjects_to_load{sub}(end-8:end-6) '_epoched.set'],...
                'filepath', [dir_to_save]);
            save([dir_to_save '/S' subjects_to_load{sub}(end-8:end-6) '_epoched.mat'],'EEG'); 
        else
            EEG = pop_saveset(EEG, ...
                'filename',['S' subjects_to_load{sub}(end-9:end-7) '_epoched.set'],...
                'filepath', [dir_to_save]);
            save([dir_to_save '/S' subjects_to_load{sub}(end-9:end-7) '_epoched.mat'],'EEG'); 
        end
    else
        if ismember (sub, mer)
            EEG = pop_saveset(EEG, ...
                'filename',['S' subjects_to_load{sub}(end-6:end-4) '_epoched.set'],...
                'filepath', [dir_to_save]);
            save([dir_to_save '/S' subjects_to_load{sub}(end-6:end-4) '_epoched.mat'],'EEG'); 
        else
            EEG = pop_saveset(EEG, ...
                'filename',['S' subjects_to_load{sub}(end-7:end-5) '_epoched.set'],...
                'filepath', [dir_to_save]);
            save([dir_to_save '/S' subjects_to_load{sub}(end-7:end-5) '_epoched.mat'],'EEG');
        end
    end
        
end

save([dir_to_save '/n_extract_epoch.mat'],'n_extract_epoch');