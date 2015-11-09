function ds = level3_to_level4(ds, varargin)
% LEVEL3_TO_LEVEL4 - Given a dataset as a GCT struct, perform
% robust z-scoring on the columns. Returns the z-scored dataset
% to the workspace and saves the matrix to plate_path/plate/
%
% Arguments:
% 
%	Parameter	Value
%	plate 		the name of the plate
% 	plate_path	the path to the directory containing plate
% 
% Example:
% zs_ds = level3_to_level4(qnorm_ds, 'plate', 'LJP009_A375_24H_X1_B20', 'plate_path', '.');

toolname = mfilename;
fprintf('-[ %s ]- Start\n', upper(toolname));
% startup_defaults;
pnames = {'plate', 'overwrite', 'plate_path', 'precision', ...
	'median_space', 'var_adjustment', 'min_mad'}; %, ...
    % 'flipcorrect', 'parallel', 'randomize',...
    % 'use_smdesc', 'lxbhist_analyte', 'lxbhist_well',...
    % 'detect_param', 'setrnd', 'rndseed', ...
    % 'incomplete_map'};
dflts = { '', true, '.' 1, ...
	[], 'fixed', 0.1}; %, ...
    % true, true, true, ...
    % false, '25,182,286,373,463', 'A05,N13,G17',...
    % fullfile(mortarpath,'resources', 'detect_params.txt'), true, '', ...
    % false};
args = parse_args(pnames, dflts, varargin{:});

% do the z-scoring
ds.mat = robust_zscore(ds.mat, 2, varargin{:});

% save the dataset
mkgct(fullfile(args.plate_path, sprintf('%s_ZSPCQNORM', args.plate)), ds);

end