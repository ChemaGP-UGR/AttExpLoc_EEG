%% AUTOMATIC TRIAL REJECTION - (conf.m)
% -------------------------------------------------------------------------
% David Lopez-Garcia       
% dlopez@ugr.es
% CIMCYC - University of granada
% -------------------------------------------------------------------------

%% Automatic analysis conf:
abnormal_trend_rej  = false;
abnormal_distr_rej  = false;
abnormal_spect_rej  = true;
improbable_data_rej = true;
extreme_values_rej  = true;

%% Abnormal spectra rejection:
elecrange   = [];           % Elec numbers to take into consideration.
threshold   = [-50 50;-100 25]; % Threshold limit(s) in dB.
freqlimits  = [0 2;20 40];      % Frequency limit(s) in Hz.
method      = 'fft';            % Method for spectrum: (fft | multitaper).
eegplotreject = 0;

%% Improbable data configuration:
typerej     = 1;        % Data type (1 = electrodes | 0 = components). 
locthresh   = 6;        % Activity probability limit(s) (in std. dev.)
globthresh  = 6;        % Global limit(s) (in std. dev.)    
superpose   = 1;        % Superpose rejection marks on previously marks.
reject      = 1;        % Directly reject trials (1 = true | 0 = false).
elec_comp   = [];   % Elec/comp numbers to take into consideration.

%% Extrme values rejection:
upthresh      = 150;
lowthresh     = -150;

%% Add my function folder to MATLAB path:
path(path,'../../../../Functions');

%% Directories:
dir_to_load = '../../../Data/EEG/icapruned/';
dir_to_save = '../../../Data/EEG/trialrejected/';
create_folder(dir_to_save);


