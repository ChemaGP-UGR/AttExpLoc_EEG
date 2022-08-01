%% ELECTROENCEPHALOGRAPHY PREPROCESSING - (compute_ica.m)
% -------------------------------------------------------------------------
% Chema Peñalver
% AttExpLoc_EEG
% cgpenalver@ugr.es
% CIMCYC - University of Granada
% -------------------------------------------------------------------------

% Compute ICA for all subjects and save the datasets.

clear
clc

%% Add my function folder to MATLAB path:
path(path,'../Functions/ICAs');

%% Directories:
dir_to_load = '../../../Data/EEG/Epoch/epoched/';
dir_to_save = '../../../Data/EEG/Epoch/icaweights/';
create_folder(dir_to_save);

%% ICA configuration:
run subjects_to_compute
icatype = 'runica';
extended = 1;

%% Loop over subjects:
for i = 1:length (subjects_to_load)
    
    disp(['<strong>SUBJECT:' subjects_to_load{i} '</strong>']);
    
    % Importa data:
    EEG = pop_loadset('filename',subjects_to_load{i}, 'filepath', dir_to_load);
    
    % Compute ICA:
    EEG = pop_runica(EEG,'icatype',icatype,'extended',extended,'chanind',channels_to_keep{i});
    
    EEG = pop_saveset(EEG, ...
    'filename',[subjects_to_load{i}(1:5) 'icaw.set'],...
    'filepath', [dir_to_save]);
    
end