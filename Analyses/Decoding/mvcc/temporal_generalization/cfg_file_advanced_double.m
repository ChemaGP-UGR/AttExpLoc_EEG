%% IF MVCC

cfg.analysis = 'MVCC';

if an == 1
    cfg.location = ['D:\AttExpLoc_EEG\Results\EEG\Definitive\Voltage\MVCC/CV/Cue/Averaged/Att_Cues/half/3T/10P/p001/3tps/'];
    condition_a = 'cue_at_face_1_h1'; % a
    condition_b = 'cue_at_name_1_h1'; % a
    condition_c = 'cue_at_face_2_h1'; % b
    condition_d = 'cue_at_name_2_h1'; % b
else
    cfg.location = 'D:\AttExpLoc_EEG\Results\EEG\Definitive\Voltage\MVCC/CV/Cue/Averaged/Exp_Cues/half/3T/10P/p001/3tps/';
    condition_a = 'cue_ex_face_2_h1'; % a
    condition_b = 'cue_ex_name_2_h1'; % a
    condition_c = 'cue_ex_face_1_h1'; % b
    condition_d = 'cue_ex_name_1_h1'; % b
end

% Condition indentifiers:
cfg.study.conditionIdentifier{1,1} = condition_a;
cfg.study.conditionIdentifier{1,2} = condition_b;
cfg.study.conditionIdentifier{2,1} = condition_c;
cfg.study.conditionIdentifier{2,2} = condition_d;

% Data paths:
cfg.study.dataPaths{1,1} = ['D:\AttExpLoc_EEG\Data\EEG\conditions\mat\' condition_a '/'] ; %[ ]
cfg.study.dataPaths{1,2} = ['D:\AttExpLoc_EEG\Data\EEG\conditions\mat\' condition_b '/'];
cfg.study.dataPaths{2,1} = ['D:\AttExpLoc_EEG\Data\EEG\conditions\mat\' condition_c '/'] ; %[ ]
cfg.study.dataPaths{2,2} = ['D:\AttExpLoc_EEG\Data\EEG\conditions\mat\' condition_d '/'];

% Data files:
for d = 1: 48
    datafiles{d} = [int2str(d) '.mat'];
end

cfg.study.dataFiles{1,1} = datafiles;
cfg.study.dataFiles{1,2} = datafiles;
cfg.study.dataFiles{2,1} = datafiles;
cfg.study.dataFiles{2,2} = datafiles;

%% FEATURE EXTRACTION:

cfg.feature = 'voltage';

% cfg.feature = 'voltage'  - Raw voltage as feature.
% cfg.feature = 'envelope' - Power evelope as feature.

cfg.powenv.method = 'analytic';
cfg.powenv.uplow  = 'upper';
cfg.powenv.length = 5;

% cfg.powenv.method = 'analytic' - Envelope using the analytic signal.
% cfg.powenv.method = 'peak'     - Peak envelopes.

% cfg.powenv.uplow = 'upper' - Select upper envelope.
% cfg.powenv.uplow = 'lower' - Select lower envelope.

%% TRIAL AVERAGE:

cfg.trialaver.flag     = true;
cfg.trialaver.ntrials  = 3;
cfg.trialaver.order    = 'rand';

% cfg.trialaver.order = 'rand' - Random order.
% cfg.trialaver.order = 'seq'  - Secuential order.

%% BALANCED DATASETS:

cfg.classsize.match = true;
cfg.classsize.matchkfold = true;

%% DIMENSION REDUCTION:

% cfg.dimred.method = 'none' - Diemnsion reduction disabled.
% cfg.dimred.method = 'pca'  - Principal Component Analysis.

cfg.dimred.method = 'none';
cfg.dimred.ncomp  = 0;

%% DATA NORMALIZATION:

% cfg.normdata = 0 - raw data
% cfg.normdata = 1 - z-score (across features)
% cfg.normdata = 2 - z-score (across time)
% cfg.normdata = 3 - z-score (across trials)
% cfg.normdata = 4 - std_nor (across trials)

cfg.normdata = 4; 

%% DATA SMOOTHING:

% cfg.smoothdata.method = 'none'   - Data smooth disabled.
% cfg.smoothdata.method = 'moving' - Moving average method.

cfg.smoothdata.method   = 'moving';
cfg.smoothdata.window   = 5;

%% ANALYSIS TIMING:

cfg.tm.tpstart   = -100;
cfg.tm.tpend     = 1550;
cfg.tm.tpstart_   = -100;
cfg.tm.tpend_    = 1550;

cfg.tm.tpsteps   = 3;

%% CLASSIFICATION ALGORITHM:

% cfg.classmodel.method = 'svm' - Support Vector Machine.
cfg.classmodel.method = 'da' % - Linear Discriminant Analysis.

% cfg.classmodel.kernel = 'linear'     - Support Vector Machine.
% cfg.classmodel.kernel = 'gaussian'   - Support Vector Machine.
% cfg.classmodel.kernel = 'rbf'        - Support Vector Machine.
% cfg.classmodel.kernel = 'polynomial' - Support Vector Machine.

% cfg.classmodel.kernel = 'linear' - Discriminant Analysis.
% cfg.classmodel.kernel = 'quadratic' - Discriminant Analysis.
% 
% cfg.classmodel.method = 'svm';
cfg.classmodel.kernel = 'linear';

%% HYPERPARAMETERS OPTIMIZATION:

cfg.classmodel.optimize.flag = false;
cfg.classmodel.optimize.params = {'BoxConstraint'};
cfg.classmodel.optimize.opt = struct('Optimizer','gridsearch',...
    'ShowPlots',false,'Verbose',0,'Kfold', 5);

%% PERFORMANCE METRICS:

cfg.classmodel.roc       = false;
cfg.classmodel.auc       = true;
cfg.classmodel.confmat   = false;
cfg.classmodel.precision = false;
cfg.classmodel.recall    = false;
cfg.classmodel.f1score   = false;
cfg.classmodel.wvector   = true;

%% EXTRA CONFIGURATION:

cfg.classmodel.tempgen = true;
cfg.classmodel.extdiag = true;
cfg.classmodel.parcomp = true;
cfg.classmodel.permlab = false;

%% CROSS-VALIDATIONN PROCEDURE:

% cfg.cv.method = 'kfold' - K-Fold cross-validation.
% cfg.cv.method = 'loo'   - Leave-one-out cross-validation.

cfg.cv.method  = 'none';
cfg.cv.nfolds  = 1;

%% PERMUTATION TEST

cfg.stats.flag   = 1;
cfg.stats.nper   = 10;
cfg.stats.nperg  = 1e5;
cfg.stats.pgroup = 95;
cfg.stats.pclust = 99.9;
cfg.stats.shownulldis = 1;
