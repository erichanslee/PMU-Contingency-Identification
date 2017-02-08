% ~~~~~~~~~INPUTS~~~~~~~~~ %
% contignum = contingency number
% PMU = Indices of buses PMUs can see 
% noise = percentage of noise to add to dynamic data
% modelorder = order of model to fit to n4sid


% ~~~~~~~~~OUTPUTS~~~~~~~~~ %

% scores = fit scores with filtering
% ranking = ranking of contingencies in terms of likehood
% vecs = fitted vectors 
% res = not explicitly output in this case, but residuals after fitting vecs

function [scores, ranking, vecs, res] = testinstanceFiltered(contignum, PMU, noise, modelorder)


%% Run Test Instance

test = loadProblem('39bus', contignum, 'Weighted', 'Weighted', PMU);
[scores, eigenfits] = calcContigFiltered(test, noise, modelorder);
[~, ranking]  = sort(scores);
vecs = eigenfits;
res = [];
fprintf('Contingency Identified: Contig %d\n', ranking(1));


end