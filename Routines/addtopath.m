% addtopath is a simply helper function modifying the current path to include the necessary folders for contingency identification in the 57 bus system
% Paths are relative and not absolute; only use when inside the 'PowerGrids/Routines/' directory.

function addtopath()

	addpath(genpath('classes/'));
	addpath('data/57bus/');
	addpath('contigs/57bus/');
	addpath('tests/');
	addpath(genpath('reporting/'));
    addpath(pwd);
end