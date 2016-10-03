% Analyze contingencies in 14-bus test case by analyzing empirical modes.
%
% Data files:
%   bus14.m         - PSAT file to specify 14 bus system
%   contig*.m       - PSAT files for the contingency systems
%   metadata.mat    - Specify params for 14 bus case
%	
% Folders:
%	data 			- contains data, including simulation results and matrices
%	figures			- MISC plots (not added to repo)
%	simulation		- Contains Nate's data
%
% PSAT analysis:
%	calc_contig		- Cycles through Jacobian Matrices to ID contingency 
% 	id_contig		- Given fixed Jacobian, calculates set of residuals
%	isolatecase  	- For fixed Jacobian and Contingency, calculate:
%					  [Sets of residuals, fitted eigenvecs, and Jacobian eigenpairs]
%   genscript       - Generate data/ submatrix with power flow Jacobians
%   gendata         - Save only bus voltage data to busdata*.mat
%   genscript14     - Call genscript with inputs for the 14-bus system
%	gen_PMUidx		- Generates random PMU indices
%   place_PMU       - Given PMU indices, calculates idx of all visible buses
%   psat_runtrial   - Run PSAT sim and save results to sim14*.mat file
%   psat_runtrials  - Run PSAT sims for every contingency
%	isolatecase		- Run contingency identification routine for fixed linearized system	
%   run_n4sid       - Runs n4sid and extracts empirical eigenpairs
%	run_observer	- given Gain and System matrices, calculates observer

% Helper functions:
%   normalizematrix - Scale matrix columns to unit norm
%   matrix_write    - Write a matrix to file (dense or sparse)
%   matrix_read     - Read a matrix from file (dense or sparse)
%	printvec		- Print eigenvectors for comparison
%	filter_eigpairs	- Filters eigenpairs given frequency range

% Methods:
%   Method 1        - Solves LS problem, subject to normalized signal
%   Method 2        - Solves LS problem, and then renormalizes
%   Method 3        - Solves constrained optimization problem
%   Method 4