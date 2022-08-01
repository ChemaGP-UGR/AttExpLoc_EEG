function [ events ] = rename_events( events , subjectID)
%rename_events This function renames the standard trigger labeling of
%BrainVision equipment.
nTrigger = 0;

subjectID = str2num (subjectID(15:17));

while true
    nTrigger = nTrigger + 1;       %Adaptado al AttExpLoc
    
    if nTrigger <= length(events)
        switch events(nTrigger).type
            case 'S  1'
                events(nTrigger).type = 'CUE_NAME_SQUARE';
            case 'S  2'
                events(nTrigger).type = 'CUE_NAME_CIRCLE';
            case 'S  3'
                events(nTrigger).type = 'CUE_NAME_DROP';
            case 'S  4'
                events(nTrigger).type = 'CUE_NAME_DIAMOND';
            case 'S  5'
                events(nTrigger).type = 'CUE_FACE_SQUARE';
            case 'S  6'
                events(nTrigger).type = 'CUE_FACE_CIRCLE';
            case 'S  7'
                events(nTrigger).type = 'CUE_FACE_DROP';
            case 'S  8'
                events(nTrigger).type = 'CUE_FACE_DIAMOND';
            case 'S 17'
                events(nTrigger).type = 'TARGET_VAL_NAME_MALE';
            case 'S 18'
                events(nTrigger).type = 'TARGET_VAL_NAME_FEMALE';
            case 'S 19'
                events(nTrigger).type = 'TARGET_VAL_FACE_MALE';
            case 'S 20'
                events(nTrigger).type = 'TARGET_VAL_FACE_FEMALE';
            case 'S 21'
                events(nTrigger).type = 'TARGET_INV_NAME_MALE';
            case 'S 22'
                events(nTrigger).type = 'TARGET_INV_NAME_FEMALE';
            case 'S 23'
                events(nTrigger).type = 'TARGET_INV_FACE_MALE';
            case 'S 24'
                events(nTrigger).type = 'TARGET_INV_FACE_FEMALE';
            case 'S 25'
                events(nTrigger).type = 'CUE_NAME_400_LOC';
            case 'S 26'
                events(nTrigger).type = 'CUE_NAME_450_LOC';
            case 'S 27'
                events(nTrigger).type = 'CUE_NAME_500_LOC';
            case 'S 28'
                events(nTrigger).type = 'CUE_NAME_550_LOC';
            case 'S 29'
                events(nTrigger).type = 'CUE_FACE_400_LOC';
            case 'S 30'
                events(nTrigger).type = 'CUE_FACE_450_LOC';
            case 'S 31'
                events(nTrigger).type = 'CUE_FACE_500_LOC';
            case 'S 32'
                events(nTrigger).type = 'CUE_FACE_550_LOC';
            case 'S 33'
                events(nTrigger).type = 'TARGET_VAL_NAME_MALE_NT_LOC';
            case 'S 34'
                events(nTrigger).type = 'TARGET_VAL_NAME_MALE_T_LOC';
            case 'S 35'
                events(nTrigger).type = 'TARGET_VAL_NAME_FEMALE_NT_LOC';
            case 'S 36'
                events(nTrigger).type = 'TARGET_VAL_NAME_FEMALE_T_LOC';
            case 'S 37'
                events(nTrigger).type = 'TARGET_VAL_FACE_MALE_NT_LOC';
            case 'S 38'
                events(nTrigger).type = 'TARGET_VAL_FACE_MALE_T_LOC';
            case 'S 39'
                events(nTrigger).type = 'TARGET_VAL_FACE_FEMALE_NT_LOC';
            case 'S 40'
                events(nTrigger).type = 'TARGET_VAL_FACE_FEMALE_T_LOC';
            case 'S 41'
                events(nTrigger).type = 'TARGET_INV_NAME_MALE_NT_LOC';
            case 'S 42'
                events(nTrigger).type = 'TARGET_INV_NAME_MALE_T_LOC';
            case 'S 43'
                events(nTrigger).type = 'TARGET_INV_NAME_FEMALE_NT_LOC';
            case 'S 44'
                events(nTrigger).type = 'TARGET_INV_NAME_FEMALE_T_LOC';
            case 'S 45'
                events(nTrigger).type = 'TARGET_INV_FACE_MALE_NT_LOC';
            case 'S 46'
                events(nTrigger).type = 'TARGET_INV_FACE_MALE_T_LOC';
            case 'S 47'
                events(nTrigger).type = 'TARGET_INV_FACE_FEMALE_NT_LOC';
            case 'S 48'
                events(nTrigger).type = 'TARGET_INV_FACE_FEMALE_T_LOC';
            case 'S 49'
                events(nTrigger).type = 'ANSWER';
            case 'S 50'
                events(nTrigger).type = 'COR_ANSWER';
            case 'S 51'
                events(nTrigger).type = 'INC_ANSWER'; 
            case 'S 52'
                events(nTrigger).type = 'START';
            case 'S 53'
                events(nTrigger).type = 'BLOCK_ATT';
            case 'S 54'
                events(nTrigger).type = 'BLOCK_EXP';
            case 'S 55'
                events(nTrigger).type = 'BLOCK_LOC'; 
            case 'S 56'
                events(nTrigger).type = 'BLOCK_TAR_MALE';
            case 'S 57'
                events(nTrigger).type = 'BLOCK_TAR_FEMALE';
            case 'S 58'
                events(nTrigger).type = 'nBLOCK_1';
            case 'S 59'
                events(nTrigger).type = 'nBLOCK_2'; 
            case 'S 60'
                events(nTrigger).type = 'nBLOCK_3';
            case 'S 61'
                events(nTrigger).type = 'nBLOCK_4';
            case 'S 62'
                events(nTrigger).type = 'nBLOCK_5';
            case 'S 63'
                events(nTrigger).type = 'nBLOCK_6'; 
            case 'S 64'
                events(nTrigger).type = 'nBLOCK_7';
            case 'S 65'
                events(nTrigger).type = 'nBLOCK_8';
            case 'S 66'
                events(nTrigger).type = 'nBLOCK_9';
            case 'S 67'
                events(nTrigger).type = 'nBLOCK_10'; 
            case 'S 68'
                events(nTrigger).type = 'nBLOCK_11';
            case 'S 69'
                events(nTrigger).type = 'nBLOCK_12';
            case 'S 70'
                events(nTrigger).type = 'nBLOCK_13';
            case 'S 71'
                events(nTrigger).type = 'nBLOCK_14'; 
            case 'S 72'
                events(nTrigger).type = 'nBLOCK_15';
            case 'S 73'
                events(nTrigger).type = 'nBLOCK_16';
            case 'S 74'
                events(nTrigger).type = 'nBLOCK_17';
            case 'S 75'
                events(nTrigger).type = 'nBLOCK_18'; 
            case 'S 76'
                events(nTrigger).type = 'nBLOCK_19';
            case 'S 77'
                events(nTrigger).type = 'nBLOCK_20';
            case 'S 78'
                events(nTrigger).type = 'nBLOCK_21';
            case 'S 79'
                events(nTrigger).type = 'nBLOCK_22'; 
            case 'S 80'
                events(nTrigger).type = 'nBLOCK_23';
            case 'S 81'
                events(nTrigger).type = 'nBLOCK_24';
            case 'S 82'
                events(nTrigger).type = 'nBLOCK_25';
            case 'S 83'
                events(nTrigger).type = 'nBLOCK_26'; 
            case 'S 84'
                events(nTrigger).type = 'nBLOCK_27';
            case 'S 85'
                events(nTrigger).type = 'nBLOCK_28';
            case 'S 86'
                events(nTrigger).type = 'nBLOCK_29';
            case 'S 87'
                events(nTrigger).type = 'nBLOCK_30'; 
            case 'S 88'
                events(nTrigger).type = 'nBLOCK_31';
            case 'S 89'
                events(nTrigger).type = 'nBLOCK_32';
            case 'S 90'
                events(nTrigger).type = 'nBLOCK_33';
            case 'S 91'
                events(nTrigger).type = 'nBLOCK_34'; 
            case 'S 92'
                events(nTrigger).type = 'nBLOCK_35';
            case 'S 93'
                events(nTrigger).type = 'nBLOCK_36';
            case 'S 94'
                events(nTrigger).type = 'nBLOCK_37';
            case 'S 95'
                events(nTrigger).type = 'nBLOCK_38'; 
            case 'S 96'
                events(nTrigger).type = 'nBLOCK_39';
            case 'S 97'
                events(nTrigger).type = 'nBLOCK_40';
            case 'S 98'
                events(nTrigger).type = 'nBLOCK_41';
            case 'S 99'
                events(nTrigger).type = 'nBLOCK_42'; 
            case 'S100'
                events(nTrigger).type = 'nBLOCK_43';
            case 'S101'
                events(nTrigger).type = 'nBLOCK_44';
            case 'S102'
                events(nTrigger).type = 'nBLOCK_45';
            case 'S103'
                events(nTrigger).type = 'nBLOCK_46'; 
            case 'S104'
                events(nTrigger).type = 'nBLOCK_47';
            case 'S105'
                events(nTrigger).type = 'nBLOCK_48';
        end
        
    else
        break
    end
end



% 
nTrigger = 5;
while true
    nTrigger = nTrigger + 1;
    if strcmp (events (nTrigger-3).type, 'BLOCK_ATT')
        while true
            nTrigger = nTrigger+1;
            if strcmp (events (nTrigger-1).type, 'BLOCK_LOC')...
            ||strcmp (events (nTrigger-1).type, 'BLOCK_EXP')...
            ||strcmp (events (nTrigger-1).type, 'BLOCK_ATT')...
            ||nTrigger+1 >= length (events)...
            ||strcmp (events (nTrigger-1).type, 'boundary')
                break
            else
                events(nTrigger-1).type = [events(nTrigger-1).type '_ATT'];    
            end 
        end 
    elseif strcmp (events (nTrigger-3).type, 'BLOCK_EXP')
        while true
            nTrigger = nTrigger+1;
            if strcmp (events (nTrigger-1).type, 'BLOCK_ATT')...
            ||strcmp (events (nTrigger-1).type, 'BLOCK_LOC')...
            ||strcmp (events (nTrigger-1).type, 'BLOCK_EXP')...
            ||nTrigger-1 >= length (events)...
            ||strcmp (events (nTrigger-1).type, 'boundary')
                break
            else
                events(nTrigger-1).type = [events(nTrigger-1).type '_EXP'];    
            end
        end 
    end 
    if nTrigger-1 >= length (events)
        break
    end
end

nTrigger = 5;
while true
    nTrigger = nTrigger + 1;
    if strcmp (events (nTrigger-2).type, 'BLOCK_TAR_MALE')
        while true
            nTrigger = nTrigger+1;
            if strcmp (events (nTrigger-1).type, 'BLOCK_LOC')...
            ||strcmp (events (nTrigger-1).type, 'BLOCK_EXP')...
            ||strcmp (events (nTrigger-1).type, 'BLOCK_ATT')...
            ||nTrigger+1 >= length (events)...
            ||strcmp (events (nTrigger-1).type, 'boundary')
                break
            else
                events(nTrigger-1).type = [events(nTrigger-1).type '_TMA'];    
            end 
        end 
    elseif strcmp (events (nTrigger-2).type, 'BLOCK_TAR_FEMALE')
        while true
            nTrigger = nTrigger+1;
            if strcmp (events (nTrigger-1).type, 'BLOCK_ATT')...
            ||strcmp (events (nTrigger-1).type, 'BLOCK_LOC')...
            ||strcmp (events (nTrigger-1).type, 'BLOCK_EXP')...
            ||nTrigger-1 >= length (events)...
            ||strcmp (events (nTrigger-1).type, 'boundary')
                break
            else
                events(nTrigger-1).type = [events(nTrigger-1).type '_TFE'];    
            end
        end 
    end 
    if nTrigger-1 >= length (events)
        break
    end
end 

if strcmp(events(3).type, 'BLOCK_LOC')
   nTrigger=4;
else
   nTrigger=5;
end

while true
    nTrigger = nTrigger + 1;
    if strcmp (events (nTrigger-1).type(1:7), 'nBLOCK_')
        nBlock =  events(nTrigger-1).type(7:end);
        while true
            nTrigger = nTrigger+1;
            if strcmp (events (nTrigger-1).type(1:5), 'BLOCK')...
                    ||nTrigger-1 >= length (events)
                break
            else
                events(nTrigger-1).type = [events(nTrigger-1).type nBlock];
            end
        end
    end
    if nTrigger-1 >= length (events)
        break
    end
end

%Marcar Cue y Target como correctos e incorrectos según la respuesta. 
if subjectID ==6
    for i = 1 : length(events)-2
        if strcmp (events (i).type(1:4), 'CUE_')
            if strcmp (events (i+3).type(1:7), 'COR_ANS')...
                    ||strcmp (events (i+2).type(1:7), 'COR_ANS')...
                events (i).type= [events(i).type '_C'];
            elseif strcmp (events (i+3).type(1:7), 'INC_ANS')...
                    ||strcmp (events (i+2).type(1:7), 'INC_ANS')...
                events (i).type = [events(i).type '_I'];
            end
        elseif strcmp (events (i).type(1:5), 'TARGE')
             if strcmp (events (i+2).type(1:7), 'COR_ANS')...
                    ||strcmp (events (i+1).type(1:7), 'COR_ANS')...
                events (i).type= [events(i).type '_C'];
            elseif strcmp (events (i+2).type(1:7), 'INC_ANS')...
                    ||strcmp (events (i+1).type(1:7), 'INC_ANS')...
                events (i).type = [events(i).type '_I'];
            end
        end 
    end
else
    for i = 1 : length(events)-2
        if strcmp (events (i).type(1:4), 'CUE_')
            if strcmp (events (i+2).type(1:7), 'COR_ANS')...
                events (i).type= [events(i).type '_C'];
            elseif strcmp (events (i+2).type(1:7), 'INC_ANS')...
                events (i).type = [events(i).type '_I'];
            end
        elseif strcmp (events (i).type(1:5), 'TARGE')
             if strcmp (events (i+1).type(1:7), 'COR_ANS')...
                events (i).type= [events(i).type '_C'];
            elseif strcmp (events (i+1).type(1:7), 'INC_ANS')...
                events (i).type = [events(i).type '_I'];
            end
        end
    end
end
    
            
                
            
              
        
    
