function [ events ] = rename_events_2(events , subjectID)
%rename_events This function renames the standard trigger labeling of
%BrainVision equipment. Fixes bug in Step 1 of preprocessing
nTrigger = 0;

subjectID = str2num (subjectID(2:4));

% 

while true
    nTrigger = nTrigger + 1;  
    if strcmp (events (nTrigger).type(1:3), 'CUE')
        if strcmp (events (nTrigger).type(10:15), 'CIRCLE')
            events (nTrigger).type = strrep(events (nTrigger).type,'CIRCLE','SPHERE');
        end
    end
    if nTrigger == length (events)
        break
    end
end

end


    
            
                
            
              
        
    
