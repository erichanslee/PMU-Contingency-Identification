% function [scores, ranking] = runInstance(method, datatype, contignum, PMU, noise, modelorder)
% ~~~~~~~~~INPUTS~~~~~~~~~ %
% method = fitting methodology (either 'timedomain' or 'frequencydomain') 
% datatype = either 'nonlinear' or 'linear' 
% contignum = contingency number
% PMU = Indices of PMU Locations (indices relative to BUS NUMBERS)
% noise = percentage of noise to add to dynamic data
% modelorder = order of model to fit to n4sid
%
% ~~~~~~~~~OUTPUTS~~~~~~~~~ %
%
% scores = fit scores with filtering
% ranking = ranking of contingencies in terms of likehood

function [scores, ranking] = runInstance(method, datatype, contignum, PMU, noise, modelorder)

% Get PMU Matrix Indices from PMU System Indices
win = place_PMU(contignum, PMU);

% Inst of class Instance containing problem data (PMU, dynamics, etc)
Inst = loadInstance('nonlinear', contignum, win);


% Ana of class Analysis used to calculate contingency
switch method
	case 'frequencydomain'
		Ana = fd_LS_Analysis(modelorder, noise);
	case 'timedomain'
		Ana = td_kroneckerLS_Analysis(noise);
		%Ana = td_vandermondeLS_Analysis(noise);
end

% Run Contingency Identification 
[scores, ranking] = Ana.calcContig(Inst);

fprintf('Contingency Identified: Contig %d\n', ranking(1));


end