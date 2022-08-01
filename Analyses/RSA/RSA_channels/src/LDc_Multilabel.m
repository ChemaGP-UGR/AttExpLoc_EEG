function LDcMatrix=LDc_Multilabel(dat,label,fold)

%Performs LDc in a pairwise manner across all possible combinations
%dat is trial x feature matrix (trials x channels)
%label is the label of each conditions
%fold is a numeric vector indication from which fold each observation came from
%LDcMatrix is a nFold x nLabels x nLabels matrix with nans under the main diagonal

unique_labels=unique(label);nLabels=numel(unique_labels);
unique_folds=unique(fold);nFolds=numel(unique_folds);

LDcMatrix=nan(nFolds,nLabels,nLabels);

for iFold=1:nFolds
    dat_train=dat(fold~=unique_folds(iFold),:);
    dat_test=dat(fold==unique_folds(iFold),:);
    
    label_train=label(fold~=unique_folds(iFold));
    label_test=label(fold==unique_folds(iFold));
    
   
    for iLabelCompare=1:nLabels
        
        train_A=squeeze(dat_train(label_train==unique_labels(iLabelCompare),:));
        res_A=train_A-repmat(mean(train_A),[size(train_A,1) 1]); %Get residuals of train A here              
        if size(train_A, 1) ~= 1    
            train_A=mean(train_A);  
            test_A=squeeze(mean(dat_test(label_test==unique_labels(iLabelCompare),:)));
        else
            test_A=dat_test(label_test==unique_labels(iLabelCompare),:);
        end
        
        
        for iLabelTest=1:nLabels
            if iLabelTest>iLabelCompare
                
                train_B=squeeze(dat_train(label_train==unique_labels(iLabelTest),:));
                res_B=train_B-repmat(mean(train_B),[size(train_B,1) 1]); %Get residuals of train B here
                if size(train_B, 1) ~= 1    
                       train_B=mean(train_B);  
                       test_B=squeeze(mean(dat_test(label_test==unique_labels(iLabelTest),:)));  
                else
                    test_B=dat_test(label_test==unique_labels(iLabelTest),:);  
                end
                
                
                
                sigma=pinv(covdiag([res_A;res_B])); %Calculate covariance on combined residuals
                
                
                LDcMatrix(iFold,iLabelCompare,iLabelTest)=(train_A-train_B)*sigma*(test_A-test_B)';
            end
        end
    end
end
end