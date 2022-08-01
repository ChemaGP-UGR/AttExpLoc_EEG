%% ELECTROENCEPHALOGRAPHY PREPROCESSING - (subjects_to_compute.m)
% -------------------------------------------------------------------------
% David Lopez-Garcia
% dlopez@ugr.es
% CIMCYC - University of granada
% -------------------------------------------------------------------------

% Cell array of subjects to load:
%% ELECTROENCEPHALOGRAPHY PREPROCESSING - (subjects_to_compute.m)
% -------------------------------------------------------------------------
% David Lopez-Garcia
% dlopez@ugr.es
% CIMCYC - University of granada
% -------------------------------------------------------------------------
tot_subs = 48;
% Cell array of subjects to load:
for i = 1: tot_subs  
        if i <10
            subjects_to_load{i,:} = ['S00' int2str(i) '_epoched.set'];
        else
            subjects_to_load{i,:} = ['S0' int2str(i) '_epoched.set'];
        end
end

%% SUBJECTS TO LOAD:
for i = 1: tot_subs 
        if i <10
            subjects_to_load_icaw{i,:} = ['S00' int2str(i) '_icaw.set'];
        else
            subjects_to_load_icaw{i,:} = ['S0' int2str(i) '_icaw.set'];
        end
end

%% SUBJECTS TO LOAD:
for i = 1: tot_subs 
        if i <10
            subjects_to_load_icapruned{i,:} = ['S00' int2str(i) '_icapruned.set'];
        else
            subjects_to_load_icapruned{i,:} = ['S0' int2str(i) '_icapruned.set'];
        end
end

%% SUBJECTS TO LOAD:
for i = 1: tot_subs 
        if i <10
            subjects_to_load_trialpruned{i,:} = ['S00' int2str(i) '_trialpruned.set'];
        else
            subjects_to_load_trialpruned{i,:} = ['S0' int2str(i) '_trialpruned.set'];
        end
end

%% SUBJECTS TO LOAD:
for i = 1: tot_subs 
        if i <10
            subjects_to_load_precond{i,:} = ['S00' int2str(i) '_precond.set'];
        else
            subjects_to_load_precond{i,:} = ['S0' int2str(i) '_precond.set'];
        end
end

total_channels = [1:63];

channels_to_throw = {
    []; % S001;
    []; % S002;
    [32 33 61]; % S003; %GOODBYE
    []; % S004;
    [9 26]; % S005;
    []; % S006;
    []; % S007;
    []; % S008;
    []; % S009;
    [1 32]; % S010;
    []; % S011;
    [21 27]; % S012; %SECOND
    [1 32]; % S013;
    [18]; % S014;
    []; % S015;
    [32]; % S016;
    [35]; % S017;
    [30]; % S018; %SECOND
    [3 46]; % S019;
    []; % S020;
    []; % S021;
    []; % S022;
    [9 26]; % S023; Puede no ser bastamte [15 20]
    []; % S024;
    [31]; % S025;
    [10 26]; % S026;
    [29]; % S027;
    [26]; % S028;
    []; % S029;
    [1]; % S030;
    []; % S031; Si salta, F8
    []; % S032; 
    [1 10]; % S033; Puede salir
    [14]; % S034; 
    []; % S035; Si salta, los PO estaban raros
    [57 63]; % S036; %FAILED
    [47]; % S037;
    [1 33]; % S038;
    [19]; % S039;
    [1 32]; % S040;
    [38 26 23]; % S041;
    []; % S042;
    [32 63 26]; % S043; %GOODBYE
    [59 5]; % S044; % GOODBYE
    [13]; % S045;
    []; % S046;
    []; % S047;
    [60 57 15 12]; % S048;
    };

for i = 1: length (channels_to_throw)
    channels_to_keep{i,:} = setdiff (total_channels, channels_to_throw{i});
end

