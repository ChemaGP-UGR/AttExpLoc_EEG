function [X,Y,cfg] = mvpalab_datalabels_ctp(cfg,fv)
%MVPALAB_DATALABELS Summary of this function goes here
%   Detailed explanation goes here
letters={'a', 'b', 'c', 'd', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm'};
for i = 1:length(fv)
    if mod(size(fv{i},1),2) == 1
        fv{i} = fv{i}(1:end-1,:,:);
    end
    rand = randperm(size(fv{i},1), size(fv{i},1)/2);
    rand_ = setdiff([1:size(fv{i},1)],rand);
    X.(letters{i}) = [fv{i}];
    Y.(letters{i}) = logical([zeros(size(fv{i},1),1);ones(size(fv{2},1),1)]);
end
X.(letters{i+1}) = [fv{i-1};fv{i}];