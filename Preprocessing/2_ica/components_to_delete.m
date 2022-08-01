%% ELECTROENCEPHALOGRAPHY PREPROCESSING - (subjects_to_compute.m)
% -------------------------------------------------------------------------
% Chema Peñalver
% AttExpLoc_EEG
% cgpenalver@ugr.es
% CIMCYC - University of Granada
% -------------------------------------------------------------------------

%% COMPONENTS TO DELETE PER SUBJECT:
% Components marked for rejection after weight computing (see methods
% section)

comp_to_delete = {
    [5, 21]            % S001 
    [3, 9]             % S002 % plantearse interpolar frontales
    [2]             % S003 
    [1 5]              % S004 
    [2 4]                 % S005
    [4 8]                 % S006
    [1 6]                 % S007
    [1 11]               % S008
    [9]               % S009
    [1 11]               % S010
    [3 7]               % S011
    [3 11]               % S012
    [1 2]               % S013
    [1 3]               % S014
    [1 10]               % S015
    [1 5]               % S016
    [1 7]               % S017
    [4 20]               % S018 %el 30 está raro
    [2 9]               % S019
    [2 7]               % S020 
    [4 5]               % S021
    [2 5]               % S022
    [2 11]               % S023
    [2]               % S024
    [4]               % S025
    [1 6]               % S026
    [2]               % S027
    [1 7]               % S028
    [3 11]               % S029 
    [1 7]               % S030
    [2 7]               % S031
    [1 7]               % S032
    [2 9]               % S033
    [2 7]               % S034
    [1 15]               % S035
    [1 5]               % S036 
    [4 16]               % S037
    [1 4]               % S038
    [1 8]               % S039
    [1 6]               % S040
    [6 15]               % S041
    [5 24]               % S042
    [17]               % S043
    [1 5]               % S044
    [1 11]               % S045 
    [1 5]               % S046
    [1 4]               % S047
    [3 6]               % S048
    };