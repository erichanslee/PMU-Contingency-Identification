% function [scores, ranking, eigenfits, res] = testinstance(method, contignum, PMU, noise, modelorder, numevals)
% ~~~~~~~~~INPUTS~~~~~~~~~ %
% method = whether to filter or not. 
% contignum = contingency number
% PMU = Indices of buses PMUs can see 
% noise = percentage of noise to add to dynamic data
% modelorder = order of model to fit to n4sid
%
% ~~~~~~~~~OUTPUTS~~~~~~~~~ %
%
% scores = fit scores with filtering
% ranking = ranking of contingencies in terms of likehood
% eigenfits = number of fitted vectors 

function [scores, ranking, num_eigenfits] = runInstance(method, contignum, PMU, noise, modelorder)

% Get PMU Matrix Indices from PMU System Indices
win = place_PMU(contignum, PMU);

% Run Test Instance
test = loadInstance(contignum, win);
switch method
	case 'FrequencyDomain'
		[scores, num_eigenfits] = calcContigFD(test, noise, modelorder);
	
	case 'TimeDomain'
		[scores, num_eigenfits] = calcContigTD(test, noise, modelorder);
		
end
[~, ranking]  = sort(scores);
fprintf('Contingency Identified: Contig %d\n', ranking(1));


end