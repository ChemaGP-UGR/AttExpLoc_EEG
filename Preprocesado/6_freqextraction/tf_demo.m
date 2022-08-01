%% ELECTROENCEPHALOGRAPHY PREPROCESSING - (compute_ica.m)
% -------------------------------------------------------------------------
% Chema Peñalver
% AttExpLoc_EEG
% cgpenalver@ugr.es
% CIMCYC - University of Granada
% -------------------------------------------------------------------------
clear
%% Initialize project and configure analysis:
run tf_cfg
results = [];

for con = 1: length(conditionsToAnalyze)
    fprintf ('\n\n');
    disp(['<strong>' int2str(con) '/' int2str(length(conditionsToAnalyze)) ' - CONDITION:</strong> ' conditionsToAnalyze{con}]);
    for sub = 1: 48
        fprintf ('\n');
        fprintf(['  <strong>-</strong> SUBJECT: ' int2str(sub) ' ']);
        
        % Load subject:
        
        load (['preprocessed files divided by condition']); '
        dir_to_save = ['your folder']; '
        EEG = data; 
            
        % More analysis parameters:
        time = -2:1/EEG.srate:2;
        half_wav = (length(time)-1)/2;
        
        % Convert baseline time into indices:
        [~,baseidx(1)] = min(abs(EEG.times-baseline(1)));
        [~,baseidx(2)] = min(abs(EEG.times-baseline(2)));
        
        % FFT parameters:
        nKern = length(time);
        nData = EEG.pnts*EEG.trials;
        nConv = nKern+nData-1;
        
        tic;
        totalPowerDB = [];
        for chan = 1 : length(chanToAnalize)
            elec = chanToAnalize{chan};
            % Initialize output spactro-temporal data
            totalPower = zeros(length(vecFreq),EEG.pnts,EEG.trials);

            % FFT of data (doesn't change on frequency iteration)
            dataX = fft(reshape(EEG.data(strcmpi(elec,{EEG.chanlocs.labels}),:,:),1,[]),nConv);
            
            for fi = 1 : length(vecFreq)
                % Create wavelet and get its FFT
                s = nCycles(fi)/(2*pi*vecFreq(fi));
                cmw = exp(2*1i*pi*vecFreq(fi).*time) .* exp(-time.^2./(2*s^2));
                
                cmwX = fft(cmw,nConv);
                cmwX = cmwX./max(cmwX);
                
                % Run convolution total power
                as = ifft(cmwX.*dataX,nConv);
                as = as(half_wav+1:end-half_wav);
                as = reshape(as,EEG.pnts,EEG.trials);
                
                % Put power data into big matrix
                totalPower(fi,:,:) = abs(as).^2;
            end
            
            % dB conversion
            totalPowerDB(:,:,:,chan) = 10*log10(bsxfun(@rdivide,totalPower,mean(totalPower(:,baseidx(1):baseidx(2),:),2)));
        end
         %% Theta
        theta_freqs = [vecFreq>4 & vecFreq<8];
        count_t=1;
        for f = 1:length(vecFreq)
            if theta_freqs(f) == 1
            theta_freq(count_t) = theta_freqs(f)*f; 
            count_t = count_t+1;
            end
        end
        theta =(totalPowerDB(theta_freq,:,:,:));
        theta = squeeze(mean(theta,1));
        EEG.data = permute(theta,[3 1 2]);
        mt = squeeze(mean(theta,2));
         %save_theta
        tf = 'theta\';
        fn = [int2str(sub) '.mat'];
        fp = [dir_to_save tf];
        create_folder(fp);
        save([fp '/' fn],'EEG','vecFreq');
        
        %% Alpha
        alpha_freqs = [vecFreq>8 & vecFreq<12];
        count_a = 1;
        for f = 1:length(vecFreq)
            if alpha_freqs(f) == 1
            alpha_freq(count_a) = alpha_freqs(f)*f; 
            count_a = count_a+1;
            end
        end
        alfa =(totalPowerDB(alpha_freq,:,:,:));
        alfa = squeeze(mean(alfa,1));
        EEG.data = permute(alfa,[3 1 2]);
        ma = squeeze(mean(alfa,1));

        %save_alfa
        af = 'alfa\';
        fn = [int2str(sub) '.mat'];
        fp = [dir_to_save af];
        create_folder(fp);
        save([fp '/' fn],'EEG','vecFreq');
        
        %% Beta
        beta_freqs = [vecFreq>12 & vecFreq<30];
        count_b = 1;
        for f = 1:length(vecFreq)
            if beta_freqs(f) == 1
            beta_freq(count_b) = beta_freqs(f)*f; 
            count_b = count_b+1;
            end
        end
        beta =(totalPowerDB(beta_freq,:,:,:));
        beta = squeeze(mean(beta,1));
        EEG.data = permute(beta,[3 1 2]);
        mb = squeeze(mean(beta,1));

        %save_beta
        bf = 'beta\';
        fn = [int2str(sub) '.mat'];
        fp = [dir_to_save bf];
        create_folder(fp);
        save([fp '/' fn],'EEG','vecFreq');

         %% Gamma
        gamma_freqs = [vecFreq>30 & vecFreq<49];
        count_g = 1;
        for f = 1:length(vecFreq)
            if gamma_freqs(f) == 1
            gamma_freq(count_g) = gamma_freqs(f)*f; 
            count_g = count_g+1;
            end
        end
        gamma =(totalPowerDB(gamma_freq,:,:,:));
        gamma = squeeze(mean(gamma,1));
        gamma =(totalPowerDB(gamma_freq,:,:,:));
        gamma = squeeze(mean(gamma,1));
        EEG.data = permute(gamma,[3 1 2]);
        mg = squeeze(mean(gamma,1));

        %save_gamma
        gf = 'gamma\';
        fn = [int2str(i) '.mat'];
        fp = [dir_to_save gf];
        create_folder(fp);
        save([fp '/' fn],'data');     

    end
end