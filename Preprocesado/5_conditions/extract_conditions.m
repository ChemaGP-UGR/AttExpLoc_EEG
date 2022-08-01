%% ELECTROENCEPHALOGRAPHY PREPROCESSING - (compute_ica.m)
% -------------------------------------------------------------------------
% Chema Peñalver
% AttExpLoc_EEG
% cgpenalver@ugr.es
% CIMCYC - University of Granada
% -------------------------------------------------------------------------
% Before extracting conditions use event_indexes to find the events
% (epcohs) to find the indexes. 
%% Note: Posible warning if your are re-epochin:
%   - Warning: event 308 out of data boundary
%
% Explanation: https://sccn.ucsd.edu/pipermail/eeglablist/2008/002092.html

clear
clc

%% Initialization:
run triggers_to_extract
run subjects_to_compute
load Event_Indexes/condInd.mat;
run conf


%% Conditions extraction loop:
for i = 1: length(subjects_to_load_precond)
    EEGOR = pop_loadset('filename',subjects_to_load_precond{i},'filepath',dir_to_load);

    id = str2double (subjects_to_load_precond{i}(2:4));

     EEGOR.event = rename_events_2(EEGOR.event, subjects_to_load_precond{i});

    for j = 1 : height(CondInfo)
        if CondInfo.Extract(j)

            [EEG,idx{i,j}] = pop_epoch(EEGOR,CondInfo.CondData{j},boundaries);
            EEG.setname = CondInfo.CondName{j};
            EEG = pop_rmbase(EEG,baseline);
            extracted{i,j} = length(idx{i,j});

            if save_set
                fn = [int2str(i) '.set'];
                fp = [dir_to_save 'set/' CondInfo.CondName{j}];
                EEG = pop_saveset(EEG,'filename',fn,'filepath',fp);
            end
            
            if save_mat
                fn = [int2str(i) '.mat'];
                fp = [dir_to_save 'mat/' CondInfo.CondName{j}];
                save([fp '/' fn],'EEG');
            end
        end
    end
end

%% Output summary:
extracted = [subjects_to_load_precond extracted];
t = cell2table(extracted,'VariableNames',{'Subject' CondInfo.CondName{:}});

%% Save summary:
save('idx', 'idx', 'extracted');
writetable(t,'output_summary_xls.csv','Delimiter',';')
