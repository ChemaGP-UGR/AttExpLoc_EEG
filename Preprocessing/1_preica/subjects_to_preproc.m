%% ELECTROENCEPHALOGRAPHY PREPROCESSING - (subjects_to_preproc.m)
% -------------------------------------------------------------------------
% David Lopez-Garcia
% dlopez@ugr.es
% CIMCYC - University of granada
% -------------------------------------------------------------------------

% Cell array of subjects to preproc:

mer = [6, 17, 28, 30, 32, 34, 36, 39, 42, 47];

for i = 1: 48
    if ismember (i, mer)
        if i <10
            subjects_to_load{i,:} = ['AttExpLoc_Mat2_00' int2str(i) '.set'];
        else
            subjects_to_load{i,:} = ['AttExpLoc_Mat2_0' int2str(i) '.set'];
        end
    else
        if i <10
            subjects_to_load{i,:} = ['AttExpLoc_Mat2_00' int2str(i) '.vhdr'];
        else
            subjects_to_load{i,:} = ['AttExpLoc_Mat2_0' int2str(i) '.vhdr'];
        end
    end
end

subjects_to_merge = {
    'AttExpLoc_Mat2_006.vhdr';
    'AttExpLoc_Mat2_006_2.vhdr';
    'AttExpLoc_Mat2_017.vhdr';
    'AttExpLoc_Mat2_017_2.vhdr';
    'AttExpLoc_Mat2_028.vhdr';
    'AttExpLoc_Mat2_028_2.vhdr';
    'AttExpLoc_Mat2_030.vhdr';
    'AttExpLoc_Mat2_030_2.vhdr';
    'AttExpLoc_Mat2_032.vhdr';
    'AttExpLoc_Mat2_032_2.vhdr';
    'AttExpLoc_Mat2_034.vhdr';
    'AttExpLoc_Mat2_034_2.vhdr';
    'AttExpLoc_Mat2_036_b.vhdr';
    'AttExpLoc_Mat2_036_b_2.vhdr'
    'AttExpLoc_Mat2_039.vhdr';
    'AttExpLoc_Mat2_039_2.vhdr';
    'AttExpLoc_Mat2_042.vhdr';
    'AttExpLoc_Mat2_042_2.vhdr';
    'AttExpLoc_Mat2_047.vhdr';
    'AttExpLoc_Mat2_047_2.vhdr';
    };
    
    
    
    