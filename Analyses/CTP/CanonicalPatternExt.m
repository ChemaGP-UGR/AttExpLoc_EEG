%% Data import
% clear

cfg = mvpalab_init();
run cfg_ctp.m;

[cfg,data,fv] = mvpalab_import_ctp(cfg);
mkdir (cfg.location);
permutation = 1;

for sub = 1: length(fv)
    %% Time window selection average
    %Face and names data averaged across presentation time
     %both together
     fprintf (['Subject '  int2str(sub) ' ... \n'])
     min_time = 100;
     max_time = 300;
     Y_matrix = time_window_average (fv, min_time, max_time, sub, cfg); %Localizer 
     fprintf (['Performing main analysis on condtion 1 \n']) 
     for tp = 1:cfg.tm.ntp
       
        
        X = fv{sub}.X.c(:,:,cfg.tm.tpoints);
        X = squeeze(mean(X(:,:,tp),1))';
        mdl = fitlm(Y_matrix,X); 
      
        %% Format results
        % Betas
        result.betas.tface.lface(1,tp,sub) = mdl.Coefficients.Estimate(2);
        result.betas.tface.lname(1,tp,sub) = mdl.Coefficients.Estimate(3);
        % T-Values
        result.tvalues.tface.lface(1,tp,sub) = mdl.Coefficients.tStat(2);
        result.tvalues.tface.lname(1,tp,sub) = mdl.Coefficients.tStat(3);
        % extract permuted maps
        if permutation
            for p = 1: cfg.stats.nper
                for i = 1:size(Y_matrix, 2)
                Y_matrix_p(:,i) = Y_matrix(randperm(length(Y_matrix)),i);
                end
                mdl = fitlm(Y_matrix_p,X);
                permaps.betas.tface.lface(1,tp,p,sub) = mdl.Coefficients.Estimate(2);
                permaps.betas.tface.lname(1,tp,p,sub) = mdl.Coefficients.Estimate(3);
                % T-Values
                permaps.tvalues.tface.lface(1,tp,p,sub) = mdl.Coefficients.tStat(2);
                permaps.tvalues.tface.lname(1,tp,p,sub) = mdl.Coefficients.tStat(3);

            end
        end    
     end
     fprintf (['Performing main analysis on condtion 2 \n'])
    for tp = 1:cfg.tm.ntp
        
        
        X = fv{sub}.X.d(:,:,cfg.tm.tpoints);
        X = squeeze(mean(X(:,:,tp),1))';
        mdl = fitlm(Y_matrix,X);       
        % Betas
        result.betas.tname.lface(1,tp,sub) = mdl.Coefficients.Estimate(2);
        result.betas.tname.lname(1,tp,sub) = mdl.Coefficients.Estimate(3);
        % T-Values
        result.tvalues.tname.lface(1,tp,sub) = mdl.Coefficients.tStat(2);
        result.tvalues.tname.lname(1,tp,sub) = mdl.Coefficients.tStat(3);
        % extract permuted maps
        if permutation
            for p = 1: cfg.stats.nper
                for i = 1:size(Y_matrix, 2)
                Y_matrix_p(:,i) = Y_matrix(randperm(length(Y_matrix)),i);
                end
                mdl = fitlm(Y_matrix_p,X);
                permaps.betas.tname.lface(1,tp,p,sub) = mdl.Coefficients.Estimate(2);
                permaps.betas.tname.lname(1,tp,p,sub) = mdl.Coefficients.Estimate(3);
                % T-Values
                permaps.tvalues.tname.lface(1,tp,p,sub) = mdl.Coefficients.tStat(2);
                permaps.tvalues.tname.lname(1,tp,p,sub) = mdl.Coefficients.tStat(3);
 
            end
        end
    end
    fprintf ("Done! \n ");
    
end

stats.tvalues.tface.lface = permtest_ctp (cfg, result.tvalues.tface.lface, permaps.tvalues.tface.lface);
stats.tvalues.tface.lname = permtest_ctp (cfg, result.tvalues.tface.lname, permaps.tvalues.tface.lname);
stats.tvalues.tname.lface = permtest_ctp (cfg, result.tvalues.tname.lface, permaps.tvalues.tname.lface);
stats.tvalues.tname.lname = permtest_ctp (cfg, result.tvalues.tname.lname, permaps.tvalues.tname.lname);
%% Save the results
save ([cfg.location 'results'],'cfg', 'result', 'permaps', 'stats');