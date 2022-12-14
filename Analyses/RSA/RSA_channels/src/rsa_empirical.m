function [ corr_sbj,regr_sbj, cfg] = rsa(c,X,Y,permute,cfg)
%SVM_CLASSIFIER This function returns the accuracy of the classifier in a
%time-resolved way.

% In RSA is irrelevant the training/test partition. We keep the "training"
% term, but we're not training anything. 
if cfg.classmodel.rsatempgen
    for tt = 1:c.ntp
        for tp = 1 : c.ntp

        % Select the FV (all channels signal values per trial/supertrial) 
        % of the current TIMEPOINT
        train_X = X(:,:,c.tpoints(tp));
        train_Y = Y(:,:,c.tpoints(tt));
        if permute
            %train_X = randperm(train_X,1);
            train_Y = randperm(train_Y,1);
        end
        % Correlate all trials' FV among each other. If you have 100
        % trials/supertrials (each with its own FV of 63 values), you'll end up
        % with a 100*100 neural matrix. 
        X_matrix = corrcoef(train_X');  % This is a PEARSON correlation
        X_matrix = 1 - X_matrix;        % DISSIMILARITY VALUES
        Y_matrix = corrcoef(train_Y');  % This is a PEARSON correlation
        Y_matrix = 1 - Y_matrix;        % DISSIMILARITY VALUES
        % if you want to take a look at the neural matrix of this timepoint
        % uncomment:  
    %     imagesc(X_matrix);
    %     pause (.1);

        % Remove diagonal and upper triangle and vectorize the matrix
        X_matrix(logical(eye(size(X_matrix)))) = 0;
        X_matrix = squareform(X_matrix);
        Y_matrix(logical(eye(size(Y_matrix)))) = 0;
        Y_matrix = squareform(Y_matrix);

        % Now, correlate the TIMEPOINT's NEURAL MATRIX with our THEORETICAL
        % MODEL (Y)
        r = corr(X_matrix(:),Y_matrix(:),'Type','Spearman'); % Always Spearman!
    %     b = regress (Y_matrix(:), X_matrix(:));
        % We apply the fisher trasformation to have normal correlation data. 
        % 1. Force finite values for later z-transformation
        r1 = (abs(r)+eps)>=1; % eps corrects for rounding errors in r
        if any(r1(:))
            warning('CORRELATION_CLASSIFIER:ZCORRINF','Correlations of +1 or -1 found. Correcting to +/-0.99999 to avoid infinity for z-transformed correlations!')
            r(r1) = 0.99999*r(r1); % forces finite values
        end
        % 2. Translate to Fisher's z transformed values
        corr_sbj(tt,tp,:) = atanh(r);
        end
    %    regr_sbj(tp,:) = b;
        % [The code for Fisher transf was directly taken from fMRI RSA scripts]
    end
else
    for tp = 1 : c.ntp

        % Select the FV (63 channels signal values per trial/supertrial) 
        % of the current TIMEPOINT
        train_X = X(:,:,c.tpoints(tp));
        train_Y = Y(:,:,c.tpoints(tp));

        % Correlate all trials' FV among each other. If you have 100
        % trials/supertrials (each with its own FV of 63 values), you'll end up
        % with a 100*100 neural matrix. 
        X_matrix = corrcoef(train_X');  % This is a PEARSON correlation
        X_matrix = 1 - X_matrix;        % DISSIMILARITY VALUES
        Y_matrix = corrcoef(train_Y');  % This is a PEARSON correlation
        Y_matrix = 1 - Y_matrix;        % DISSIMILARITY VALUES
        % if you want to take a look at the neural matrix of this timepoint
        % uncomment:  
    %     imagesc(X_matrix);
    %     pause (.1);

        % Remove diagonal and upper triangle and vectorize the matrix
        X_matrix(logical(eye(size(X_matrix)))) = 0;
        X_matrix = squareform(X_matrix);
        Y_matrix(logical(eye(size(Y_matrix)))) = 0;
        Y_matrix = squareform(Y_matrix);

        % Now, correlate the TIMEPOINT's NEURAL MATRIX with our THEORETICAL
        % MODEL (Y)
        r = corr(X_matrix(:),Y_matrix(:),'Type','Spearman'); % Always Spearman!
    %     b = regress (Y_matrix(:), X_matrix(:));
        % We apply the fisher trasformation to have normal correlation data. 
        % 1. Force finite values for later z-transformation
        r1 = (abs(r)+eps)>=1; % eps corrects for rounding errors in r
        if any(r1(:))
            warning('CORRELATION_CLASSIFIER:ZCORRINF','Correlations of +1 or -1 found. Correcting to +/-0.99999 to avoid infinity for z-transformed correlations!')
            r(r1) = 0.99999*r(r1); % forces finite values
        end
        % 2. Translate to Fisher's z transformed values
        corr_sbj(tp,:) = atanh(r);
     end
end
    
end
