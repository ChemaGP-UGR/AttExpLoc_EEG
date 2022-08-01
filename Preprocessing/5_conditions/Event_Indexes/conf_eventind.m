clear


load condInd.mat
% run triggers_to_extract
%% Configuración normal
corr{1}= '_C';
category = {'NAME';
    'FACE'};
category_condition = {'name';
    'face'};
shapes = {'SQUARE', 'SQUARE', 'SQUARE', 'SPHERE', 'SPHERE', 'DROP'; %name 1
    'SPHERE', 'DROP', 'DIAMOND', 'DROP', 'DIAMOND', 'DIAMOND'; %name 2
    'DROP', 'SPHERE', 'SPHERE', 'SQUARE', 'SQUARE', 'SQUARE'; %face 1
    'DIAMOND', 'DIAMOND', 'DROP', 'DIAMOND', 'DROP', 'SPHERE'}; %face 2
category_order = {'1','2','1','2'};
block = {'ATT';
    'EXP'};
block_condition = {'at';
    'ex'};
block_numbers = [1:3 10:12 13:15 22:24 25:27 34:36 37:39 46:48];  % los bloques siempre van de 3 en 3. 


for sha = 4
    if sha == 1 || sha == 2
        cat = 1;
    else
        cat = 2;
    end
    for pe = 1
        stim{1} = ['CUE_' category{cat} '_' shapes{sha, pe}]
        for blo = 1
                btype{1} = block{blo}
                bnum = block_numbers;
                
                condition = ['cue_' block_condition{blo} '_' category_condition{cat} '_' category_order{sha} '_cb' int2str(pe) '_diff']
                if strcmp(condition(1:13), 'cue_at_face_2')
                    bnum = [7:9 19:21 31:33 43:45];
                end
                ind.(condition) = eventInd(stim, btype, corr, events_to_extract,bnum);
        end   
    end
end
stim{1} = 'CUE_NAME_SQUARE';

%stim{2} = 'CUE_NAME_SPHERE';
%stim{3} = 'TARGET_INV_FACE';
%stim{4} = 'TARGET_INV_NAME';

btype{1} = 'ATT';
% btype{2} = 'EXP';
bnum = 1:24; 

%% Configuración para sacar bloques concretos
%  blks = 1:48;
%  bnum1 = sort(randperm(48, 24));
%  bnum2 = setdiff(blks,bnum1);
%% La función en sí. 

ind.cue_at_name_1_cb1_h1= eventInd(stim, btype, corr, events_to_extract,bnum); %If specific blocks only, add bnum (vector)

 clear corr stim btype bnum evnt %bnum1 bnum2 blks 
 save ('condInd', 'ind', 'events_to_extract');
