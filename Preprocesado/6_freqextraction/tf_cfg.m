
%% Basic spectro-temporal analysis parameters:
minFreq =  4;
maxFreq = 49;
nSteps = 36;
vecFreq = logspace(log10(minFreq),log10(maxFreq),nSteps);
baseline = [-200 0];

%% Set a few different wavelet widths (number of wavelet cycles)
minCycles = 4;
maxCycles = 10;
nCycles = logspace(log10(minCycles),log10(maxCycles),nSteps);

%% Channels to analyze:
chanToAnalize = (1:64);

% Exclude EOG channels:
% chanToAnalize(10) = [];
% chanToAnalize(21) = [];


%% Subjects to load:
subjectsToLoad = {
    '1.mat';
    '2.mat';
    '3.mat';
    '4.mat';
    '5.mat';
    '6.mat';
    '7.mat';
    '8.mat';
    '9.mat';
    '10.mat';
    '11.mat';
    '12.mat';
    '13.mat';
    '14.mat';
    '15.mat';
    '16.mat';
    '17.mat';
    '18.mat';
    '19.mat';
    '20.mat';
    '21.mat';
    '22.mat';
    '23.mat';
    '24.mat';
    '25.mat';
    '26.mat';
    '27.mat';
    '28.mat';
    '29.mat';
    '30.mat';
    '31.mat';
    '32.mat';
    };

%% Conditions to analize:
CondInfo  = readtable('G:\Mi unidad\ManyPipelinesEEG22\Data\Documentation\CondData_mpl.xlsx');

conditionsToAnalyze = CondInfo.CondName;

%% Channels to analize:
chanToAnalize = {
    'Fp1';
    'Fz';
    'F3';
    'F7';
    'FT9';
    'FC5';
    'FC1';
    'C3';
    'T7';
    'CP5';
    'CP1';
    'Pz';
    'P3';
    'P7';
    'O1';
    'Oz';
    'O2';
    'P4';
    'P8';
    'CP6';
    'CP2';
    'Cz';
    'C4';
    'T8';
    'FT10';
    'FC6';
    'FC2';
    'F4';
    'F8';
    'Fp2';
    'AF7';
    'AF3';
    'AFz';
    'F1';
    'F5';
    'FT7';
    'FC3';
    'C1';
    'C5';
    'TP7';
    'CP3';
    'P1';
    'P5';
    'PO7';
    'PO3';
    'POz';
    'PO4';
    'PO8';
    'P6';
    'P2';
    'CPz';
    'CP4';
    'TP8';
    'C6';
    'C2';
    'FC4';
    'FT8';
    'F6';
    'AF8';
    'AF4';
    'F2';
    'TP9';
    'TP10';
    'FCz'
    };

dirToLoad = '/Volumes/DATA/data/conditions/mat/';