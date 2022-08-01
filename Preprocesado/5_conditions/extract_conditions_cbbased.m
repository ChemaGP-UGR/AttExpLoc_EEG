%% ELECTROENCEPHALOGRAPHY PREPROCESSING 
% -------------------------------------------------------------------------
% Chema Peñalver
% AttExpLoc_EEG
% cgpenalver@ugr.es
% CIMCYC - University of Granada
% -------------------------------------------------------------------------

%% Note: Posible warning if your are re-epochin:
%   - Warning: event 308 out of data boundary
%
% Explanation: https://sccn.ucsd.edu/pipermail/eeglablist/2008/002092.html

% Here we extract conditions that are counterbalance dependant (such us
% cues that differ depending on the participant and would give errors if
% considered for all participants

clear
clc

%% Initialization:
run triggers_to_extract
run subjects_to_compute
load condInd.mat;
run conf


%% Conditions extraction loop:
for i = 2: length(subjects_to_load_precond)
    EEGOR = pop_loadset('filename',subjects_to_load_precond{i},'filepath',dir_to_load);

    id = str2double (subjects_to_load_precond{i}(2:4));
    if id == 27
        id = 41
    elseif id == 28
        id = 42
    elseif id == 31
        id = 33
    elseif id == 32
        id = 34
    elseif id == 33
        id = 31
    elseif id == 34
        id = 32
    elseif id == 41
        id = 27
    elseif id == 42
        id = 28
    end
    
     EEGOR.event = rename_events_2(EEGOR.event, subjects_to_load_precond{i});
    count = 1;
    for j = 1 : height(CondInfo)
        if CondInfo.Extract(j)
            if mod(id,6) == str2num(CondInfo.CondName{j}(end-5)) || mod(id,6) == 0&& str2num(CondInfo.CondName{j}(end-5)) ==6   % end = position of number that codes for counterbalance
                try
                [EEG,idx{i,j}] = pop_epoch(EEGOR,CondInfo.CondData{j},boundaries);
                EEG.setname = CondInfo.CondName{j};
                EEG = pop_rmbase(EEG,baseline);
                extracted{i,j} = length(idx{i,j});
                catch
                    failed{i,count} = CondInfo.CondName{j};
                    count = count+1;
                    continue
                end

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
end

%% Output summary:
extracted = [subjects_to_load_precond extracted];
t = cell2table(extracted,'VariableNames',{'Subject' CondInfo.CondName{:}});

%% Save summary:
save('idx', 'idx', 'extracted');
writetable(t,'output_summary_xls.csv','Delimiter',';')
