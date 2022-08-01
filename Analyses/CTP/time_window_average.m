function [av_times] = time_window_average (fv, min_time, max_time, sub, cfg);
% It averages an puts together matrices from the first pair of conditions
% in the fv. 
wind = cfg.tm.tpoints(cfg.tm.times>100 & cfg.tm.times<300);
    face_fv  = mean(fv{sub}.X.a(:,:,wind),3);
    face_fv  = squeeze(mean(face_fv,1));
    name_fv  = mean(fv{sub}.X.b(:,:,wind),3);
    name_fv  = squeeze(mean(name_fv,1));
    av_times = [face_fv;name_fv]';
end