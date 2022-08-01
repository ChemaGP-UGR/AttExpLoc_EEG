function [corr, betas, tvalues, cfg] = rsa_ModelComp_LDC( cfg, fv, RDMs, permute, model)
% Model-based RSA: 
%  (1) Make individual theoretical RDM 
%  (2) Compute time-resolved empirical RDM 
%  (3) Correlate theoretical and empirical RDM in each timepoint
corr=[];
betas = [];
tvalues = [];
fprintf('<strong> > Analyzing data: </strong>\n');
%% Subjects loop:
nsub = length(cfg.study.dataFiles{1});
for sub = 1 : nsub
    fprintf(['   - Subject: ' int2str(sub) '/' int2str(nsub) ' >> ']);
    
    %% Data and true labels:
    % X: (concatenated data for cond A and B, channels, timepoints)
    % Y: conditions label
    X = RDMs(:,:,:,sub);
    Y = fv{sub}.Y.a;
    %% Generate THEORETICAL RDM (OUR MODEL)
    %% very IMPORTANT: Here we will work with RDMs... D = dissimilarity values. 
    % If we correlate a theoretical SIMILARITY matrix with an empirical
    % DISSIMILARITY matrix, negative correlations will appear [tears]
    Y_matrix = NaN(size(Y,1),size(Y,1));
    if cfg.classmodel.regress
        for i = 1:size(Y)
            for ii = 1:size(Y)
                if ii > size(Y,1)/2
                    if i > size(Y,1)/2
                        Y_matrix(i,ii) = 0;
                    else
                        Y_matrix(i,ii) = 1;
                    end   
                else
                    if i > size(Y,1)/2
                        Y_matrix(i,ii) = 1;
                    else
                        Y_matrix(i,ii) = 0;
                    end   
                end
            end
        end
        Y_matrix_ct  = Y_matrix;
        for i = 1:size(Y)/2
            for ii = 1:size(Y)/2
                if ii > size(Y,1)/4
                    if i > size(Y,1)/4
                        Y_matrix(i,ii) = 0;
                    else
                        Y_matrix(i,ii) = 1;
                    end   
                else
                    if i > size(Y,1)/4
                        Y_matrix(i,ii) = 1;
                    else
                        Y_matrix(i,ii) = 0;
                    end   
                end
            end
        end
        for i = 1:size(Y,1)/2
            for ii = 1:size(Y,1)/2
                Y_matrix(i,ii+size(Y,1)/2) = Y_matrix (i,ii);
                Y_matrix(i+size(Y,1)/2,ii) = Y_matrix (i,ii);
                Y_matrix(i+size(Y,1)/2,ii+size(Y,1)/2) = Y_matrix (i,ii);
            end
        end
        Y_matrix_bl  = Y_matrix;
        for i = 1:size(Y)/2
             for ii = 1:size(Y)/2
                if ii > size(Y,1)/4
                    if i > size(Y,1)/4
                        Y_matrix(i,ii+size(Y,1)/2) = 0;
                        Y_matrix(i+size(Y,1)/2,ii) = 0;
                    else
                        Y_matrix(i,ii+size(Y,1)/2) = 1;
                        Y_matrix(i+size(Y,1)/2,ii) = 1;
                    end   
                else
                    if i > size(Y,1)/4
                        Y_matrix(i,ii+size(Y,1)/2) = 1;
                        Y_matrix(i+size(Y,1)/2,ii) = 1;
                    else
                        Y_matrix(i,ii+size(Y,1)/2) = 0;
                        Y_matrix(i+size(Y,1)/2,ii) = 0;
                    end   
                end
                for ii = 1:size(Y)/2
                    Y_matrix(i,ii) = 0;
                    Y_matrix(i+size(Y,1)/2,ii+size(Y,1)/2) = 0;
                end
             end
        end
        Y_matrix_cm  = Y_matrix;
           for i = 1:size(Y,1)/2             
               for ii = 1:size(Y,1)/2
                Y_matrix(i,ii) = ~(Y(i) == Y(ii)); % ~ = dissimilarity
                Y_matrix(i+size(Y,1)/2,ii+size(Y,1)/2) = ~(Y(i) == Y(ii));
                Y_matrix(i,ii+size(Y,1)/2) = 1;
                Y_matrix(i+size(Y,1)/2,ii) = 1;             
               end
           end
           Y_matrix_cs  = Y_matrix;
    end
     
    if strcmp(model, 'content') || cfg.classmodel.regress
        for i = 1:size(Y)
            for ii = 1:size(Y)
                if ii > size(Y,1)/2
                    if i > size(Y,1)/2
                        Y_matrix(i,ii) = 0;
                    else
                        Y_matrix(i,ii) = 1;
                    end   
                else
                    if i > size(Y,1)/2
                        Y_matrix(i,ii) = 1;
                    else
                        Y_matrix(i,ii) = 0;
                    end   
                end
            end
        end
        Y_matrix_ct  = Y_matrix;
    elseif strcmp(model,'block') || cfg.classmodel.regress
        for i = 1:size(Y)/2
            for ii = 1:size(Y)/2
                if ii > size(Y,1)/4
                    if i > size(Y,1)/4
                        Y_matrix(i,ii) = 0;
                    else
                        Y_matrix(i,ii) = 1;
                    end   
                else
                    if i > size(Y,1)/4
                        Y_matrix(i,ii) = 1;
                    else
                        Y_matrix(i,ii) = 0;
                    end   
                end
            end
        end
        for i = 1:size(Y,1)/2
            for ii = 1:size(Y,1)/2
                Y_matrix(i,ii+size(Y,1)/2) = Y_matrix (i,ii);
                Y_matrix(i+size(Y,1)/2,ii) = Y_matrix (i,ii);
                Y_matrix(i+size(Y,1)/2,ii+size(Y,1)/2) = Y_matrix (i,ii);
            end
        end
        Y_matrix_bl  = Y_matrix;
    elseif strcmp(model, 'complete') || cfg.classmodel.regress
        for i = 1:size(Y)/2
             for ii = 1:size(Y)/2
                if ii > size(Y,1)/4
                    if i > size(Y,1)/4
                        Y_matrix(i,ii+size(Y,1)/2) = 0;
                        Y_matrix(i+size(Y,1)/2,ii) = 0;
                    else
                        Y_matrix(i,ii+size(Y,1)/2) = 1;
                        Y_matrix(i+size(Y,1)/2,ii) = 1;
                    end   
                else
                    if i > size(Y,1)/4
                        Y_matrix(i,ii+size(Y,1)/2) = 1;
                        Y_matrix(i+size(Y,1)/2,ii) = 1;
                    else
                        Y_matrix(i,ii+size(Y,1)/2) = 0;
                        Y_matrix(i+size(Y,1)/2,ii) = 0;
                    end   
                end
                for ii = 1:size(Y)/2
                    Y_matrix(i,ii) = 0;
                    Y_matrix(i+size(Y,1)/2,ii+size(Y,1)/2) = 0;
                end
             end
        end
        Y_matrix_cm  = Y_matrix;
    elseif strcmp(model, 'cues') || cfg.classmodel.regress
           for i = 1:size(Y,1)/2             
               for ii = 1:size(Y,1)/2
                Y_matrix(i,ii) = ~(Y(i) == Y(ii)); % ~ = dissimilarity
                Y_matrix(i+size(Y,1)/2,ii+size(Y,1)/2) = ~(Y(i) == Y(ii));
                Y_matrix(i,ii+size(Y,1)/2) = 1;
                Y_matrix(i+size(Y,1)/2,ii) = 1;             
               end
           end
           Y_matrix_cs  = Y_matrix;
     end
    

    if cfg.classmodel.regress
        Y_matrix_ct(logical(eye(size(Y_matrix_ct)))) = 0; 
        Y_matrix_ct = squareform(Y_matrix_ct);
        Y_matrix_bl(logical(eye(size(Y_matrix_bl)))) = 0; 
        Y_matrix_bl = squareform(Y_matrix_bl);
        Y_matrix_cm(logical(eye(size(Y_matrix_cm)))) = 0; 
        Y_matrix_cm = squareform(Y_matrix_cm);
        Y_matrix_cs(logical(eye(size(Y_matrix_cs)))) = 0; 
        Y_matrix_cs = squareform(Y_matrix_cs);
        Y_matrix = [Y_matrix_cs', Y_matrix_ct', Y_matrix_bl']; %1 = cues, 2 = category, 3 = block
    else
        Y_matrix(logical(eye(size(Y_matrix)))) = 0; %Para la condición concreta
        Y_matrix = squareform(Y_matrix);
    end


    %% RSA function 
  
    [~,betas_sbj, tvalues_sbj] = rsa_Example(cfg,X,Y_matrix,permute); 
    
    %% Store everything   
    if cfg.classmodel.corrspe
        if isrow(corr_sbj)
            corr(:,:,sub) = corr_sbj;
        else
            corr(:,:,sub) = corr_sbj';  
        end
    end
    if cfg.classmodel.regress
            betas(:,:,sub) = betas_sbj;
            tvalues(:,:,sub) =tvalues_sbj;
    end
    
end
fprintf(' - Done!\n');
