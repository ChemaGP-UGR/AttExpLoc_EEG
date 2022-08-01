%% EXTRACT CONDITIONS - (conf.m)
% -------------------------------------------------------------------------
% David Lopez-Garcia
% dlopez@ugr.es
% CIMCYC - University of granada
% -------------------------------------------------------------------------

%% Configuration
boundaries = [-1 2];
baseline = [-200 0];

%% Saving options
save_mat = 1;
save_set = 1;


%% Condition information (from excel)
CondInfo  = readtable('CondData.xlsx');

for i = 1 : height(CondInfo)
 CondInfo.CondData{i} = events_to_extract(ind.(CondInfo.CondName{i}));
end

%% Add my function folder to MATLAB path:
path(path,'../../../Functions');

%% Directories:
dir_to_load = '../../../Data/EEG/precond';
dir_to_save = '../../../Data/EEG/conditions/';

for a = 1 : height(CondInfo)
    if CondInfo.Extract(a)
        if save_mat
            create_folder([dir_to_save 'mat/' CondInfo.CondName{a}]);
        end
        if save_set
            if ~isdir([dir_to_save 'set/' CondInfo.CondName{a}])
                mkdir([dir_to_save 'set/' CondInfo.CondName{a}]);
            end
        end
    end 
end
