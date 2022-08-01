clear
clc

%% Add my function folder to MATLAB path:
path(path,'../Prepreprocesado/');

%% Directories:
dir_to_load = '../../../Data/EEG/Raw';
dir_to_save = '../../../Data/EEG/Raw/';

chan_to_load    = (1:63);

run subjects_to_preproc
for sub  = 1: length (subjects_to_merge)
    for j = 1:2
        if j == 1
            ALLEEG (j) = pop_loadbv(dir_to_load, subjects_to_merge{sub}, 1, chan_to_load);
        else
            ALLEEG (j) = pop_loadbv(dir_to_load, subjects_to_merge{sub+1}, 1, chan_to_load);
        end
    end
    EEG = pop_mergeset( ALLEEG, [1  2], 0);
    EEG = pop_saveset(EEG, ...
        'filename',subjects_to_merge{sub},...
        'filepath', dir_to_save);
end
   


