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
% res = not explicitly output in this case, but residuals after fitting vecs

function [scores, ranking, eigenfits, res] = runInstance(method, contignum, PMU, noise, modelorder)

% Get PMU Matrix Indices from PMU System Indices
win = place_PMU(contignum, PMU);


% Run Test Instance
test = loadProblem(contignum, win);
[scores, eigenfits] = calcContig(test, noise, modelorder);
[~, ranking]  = sort(scores);
res = [];
fprintf('Contingency Identified: Contig %d\n', ranking(1));


end