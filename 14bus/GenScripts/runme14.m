% Load system specs and write data files with Jacobians
% and low-rank decompositions of the Jacobian updates

load('../metadata.mat');
genscript(basefilename, numbuses, numcontigs);
psat_runtrials;
gendata(numcontigs);
