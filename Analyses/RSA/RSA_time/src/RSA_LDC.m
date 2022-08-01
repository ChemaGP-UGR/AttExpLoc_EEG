
mode = 'conditions';

for i = 1:length(fv)
    X = fv{i}.X.a;
    Y = fv{i}.X.b;
    Z = [X; Y];
    t = cfg.tm.tpoints;
    if strcmp(mode, 'trials')
        labels= [1:size(X,1),1:size(X,1)];
    elseif strcmp(mode, 'conditions')
        labels = nan(size(Z,1),1);
        labels(1:size(Z,1)/16)=1;
        labels(size(Z,1)/16:size(Z,1)/16*2)=2;
        labels(size(Z,1)/16*2:size(Z,1)/16*3)=3;
        labels(size(Z,1)/16*3:size(Z,1)/16*4)=4;
        labels(size(Z,1)/16*4:size(Z,1)/16*5)=5;
        labels(size(Z,1)/16*5:size(Z,1)/16*6)=6;
        labels(size(Z,1)/16*6:size(Z,1)/16*7)=7;
        labels(size(Z,1)/16*7:size(Z,1)/16*8)=8;
        labels(size(Z,1)/16*8:size(Z,1)/16*9)=1;
        labels(size(Z,1)/16*9:size(Z,1)/16*10)=2;
        labels(size(Z,1)/16*10:size(Z,1)/16*11)=3;
        labels(size(Z,1)/16*11:size(Z,1)/16*12)=4;
        labels(size(Z,1)/16*12:size(Z,1)/16*13)=5;
        labels(size(Z,1)/16*13:size(Z,1)/16*14)=6;
        labels(size(Z,1)/16*14:size(Z,1)/16*15)=7;
        labels(size(Z,1)/16*15:size(Z,1))=8;
    end
    folds = [ones(size(X,1),1);ones(size(Y,1),1)*2];
    
    for tp = 1:cfg.tm.ntp
        text = ['Computing subject ' int2str(i) ' on time point ' int2str(tp) '/' int2str(cfg.tm.ntp)];
        fprintf(text);
        LDcmatrix = LDc_Multilabel(Z(:,:,t(tp)), labels, folds);
        RDM = squeeze(mean(LDcmatrix,1, 'omitnan'));
        RDMs(:,:,tp,i) = RDM';
    end
end
    



