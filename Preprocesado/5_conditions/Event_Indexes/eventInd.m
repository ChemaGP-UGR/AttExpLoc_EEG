function eventindx = eventInd(stim, btype, corr, events_to_extract, bnum)
%Returns the index in the array "events_to_extract" of all the conditions
%specified. 
%stim = string with the stimulus type. Can have many values. 
%btype = cell array of strings with the blocks' names. Same as stim. 
%bnum = vector with the block numbers
%corr = '_C' for correct events
%-.-.-.-.-.-.-.-.-.-.--.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.--.--.-.-.-.--

%% Variable inizialization 




c = 1: length(corr);
for cr = c   
    indcorr{cr} = {zeros(length(events_to_extract),1)}; 
end

b = 1: length(btype);
for bt = b 
    indbtype{bt} = {zeros(length(events_to_extract),1)};
end

s = 1: length(stim);

for st = s
    indstim{st} = {zeros(length(events_to_extract),1)};
end

if nargin >4
    n = 1: length(bnum);
    for bn = n
        indbnum{bn} = {zeros(length(events_to_extract),1)};
    end
end
%% Index selection by category
 % Correct or Incorrect trials
for cr = c
    for i = 1: length(indcorr{cr}{1})
        try
        indcorr{1,cr}{1}(i) = cell2mat(strfind (events_to_extract(i), corr (cr)));  
        catch
            continue
        end
    end
end
indcor = [];
for cr = c
    indcorr{cr}{1} = find(indcorr{cr}{1});
    indcor = [indcor;indcorr{cr}{1}];
end

indcorr = indcor;
clear indcor


 % Block type (ATT, EXP, LOC)
for bt = b
    for i = 1: length(indbtype{bt}{1})
        try
        indbtype{1,bt}{1}(i) = cell2mat(strfind (events_to_extract(i), btype (bt)));  
        catch
            continue
        end
    end
end
indbtyp = [];
for bt = b
    indbtype{bt}{1} = find(indbtype{bt}{1});
    indbtyp = [indbtyp;indbtype{bt}{1}];
end

indbtype = indbtyp;
clear indbtyp

 % Stimulus type (CUE, TARGET, MALE, FEMALE, DROP, SQUARE...)
for st = s
    for i = 1: length(indstim{st}{1})
        try
        indstim{st}{1}(i) = cell2mat(strfind (events_to_extract(i), stim (st)));  
        catch
            continue
        end
    end
end
indsti = [];
for st = s
    indstim{st}{1} = find(indstim{st}{1});
    indsti = [indsti;indstim{st}{1}];
end

indstim = indsti;
clear indsti

 % Block number
 if nargin >4
    for bn = n
        for i = 1: length(indbnum{bn}{1})
            try
            indbnum{bn}{1}(i) = cell2mat(strfind (events_to_extract(i), ['_' num2str(bnum(bn)) '_']));  
            catch
                continue
            end
        end
    end

    indbnu = [];
    for bn = n
        indbnum{bn}{1} = find(indbnum{bn}{1});
        indbnu = [indbnu;indbnum{bn}{1}];
    end

    indbnum = indbnu;
    clear indbnu
 end

if nargin >4
    eventindx = mintersect (indcorr, indbtype, indstim, indbnum);
else
    eventindx = mintersect (indcorr, indbtype, indstim);
end
 

end
        