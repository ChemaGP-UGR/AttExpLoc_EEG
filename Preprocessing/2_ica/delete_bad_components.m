%% ELECTROENCEPHALOGRAPHY PREPROCESSING - (deleteBadComponents.m)
% -------------------------------------------------------------------------
% Chema Peñalver
% AttExpLoc_EEG
% cgpenalver@ugr.es
% CIMCYC - University of Granada
% -------------------------------------------------------------------------

clear
clc

%% Add my function folder to MATLAB path:
path(path,'../ICAs/');

%% Directories:
dir_to_load = '../../../Data/EEG/icaweights/';
dir_to_save = '../../../Data/EEG/icapruned/';
create_folder(dir_to_save);

run components_to_delete
run subjects_to_compute
chan_to_delete = [64 65];
for i = 1: length(subjects_to_load_icaw)
    % PRINT FILENAME:
    disp(['<strong>SUBJECT:' subjects_to_load_icaw{i} '</strong>']);
    channels = [1:63];

    % LOAD SUBJECT
    EEG = pop_loadset('filename',subjects_to_load_icaw{i},'filepath',dir_to_load);
    
    % DELETE BAD COMPONENTS:
    EEG = pop_subcomp(EEG, comp_to_delete{i}, 0);
    
    EEG.setname = [subjects_to_load_icaw{i}(1:4) '_icapruned'];
    EEG = pop_saveset(EEG, 'filename',EEG.setname,'filepath', dir_to_save);
    
end