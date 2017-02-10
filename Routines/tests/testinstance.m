% ~~~~~~~~~INPUTS~~~~~~~~~ %
% method = whether to filter or not. 
% contignum = contingency number
% PMU = Indices of buses PMUs can see 
% noise = percentage of noise to add to dynamic data
% modelorder = order of model to fit to n4sid
% numevals = number of eigenpairs to fit. 

% ~~~~~~~~~OUTPUTS~~~~~~~~~ %

% scores = fit scores with filtering
% ranking = ranking of contingencies in terms of likehood
% eigenfits = number of fitted vectors 
% res = not explicitly output in this case, but residuals after fitting vecs

function [scores, ranking, eigenfits, res] = testinstance(method, contignum, PMU, noise, modelorder, numevals)

% Check that evaluation method is okay. 
modeList = {'all', 'filtered'};
if(~(any(ismember(modeList, method))))
    disp('No Evaluation Method Listed, Please Choose from the following list');
    disp(method_list);
    error('Input Error');
end

% Run Test Instance
test = loadProblem('39bus', contignum, 'Weighted', 'Weighted', method, PMU);
[scores, eigenfits] = calcContig(test, noise, modelorder, numevals);
[~, ranking]  = sort(scores);
res = [];
fprintf('Contingency Identified: Contig %d\n', ranking(1));


end