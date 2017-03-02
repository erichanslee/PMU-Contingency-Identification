% ~~~~~~~~~INPUTS~~~~~~~~~ %
% method = whether to filter or not.
% contignum = contingency number
% PMU = Indices of buses PMUs can see
% noise = percentage of noise to add to dynamic data
% modelorder = order of model to fit to n4sid
% numevals = number of eigenpairs to fit.
% reportstatus = value determining whether or not to output report

% ~~~~~~~~~OUTPUTS~~~~~~~~~ %

% scores = fit scores with filtering
% ranking = ranking of contingencies in terms of likehood
% eigenfits = number of fitted vectors
% res = not explicitly output in this case, but residuals after fitting vecs

function [scores, ranking, eigenfits, res] = contingencyReport(method, contignum, PMU, noise, modelorder, numevals, reportstatus)

% Get PMU Matrix Indices from PMU System Indices
PMUidx = place_PMU(contignum, PMU);

% Change metadata.mat to reflect reporting
configMetadata(reportstatus);
load metadata.mat;


% Run Problem
test = loadProblem('39bus', contignum, 'Weighted', 'Weighted', method, PMUidx);
[scores, eigenfits] = calcContig(test, noise, modelorder, numevals);
[~, ranking]  = sort(scores);
res = [];
fprintf('Contingency Identified: Contig %d\n', ranking(1));

% If Necessary, output final png of sorted scores for report
if(report)
    figure('Visible','off');
    contigidx = find(ranking == contignum);
    plot(1:numcontigs, sort(scores), '-ob', contigidx, scores(contignum), 'or');
    fname = 'figures/PNG/finalscores.png';
    saveas(gcf, fname);
end

% Delete instance of metadata.
clearMetadata();

% Cleanup
if(isunix)
    
end
end