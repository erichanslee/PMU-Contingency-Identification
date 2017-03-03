% [scores, ranking, eigenfits, res] = contingencyReport(method, contignum, PMU, noise, modelorder, numevals, reportstatus)
% ~~~~~~~~~~~~~~~~~~~~~~~~ 
% ~~~~~~~~~INPUTS~~~~~~~~~ 
% ~~~~~~~~~~~~~~~~~~~~~~~~ 
% method = whether to filter or not.
% contignum = contingency number
% PMU = Indices of buses PMUs can see
% noise = percentage of noise to add to dynamic data
% modelorder = order of model to fit to n4sid
% numevals = number of eigenpairs to fit.
% reportstatus = value determining whether or not to output report
% ~~~~~~~~~~~~~~~~~~~~~~~~~
% ~~~~~~~~~OUTPUTS~~~~~~~~~
% ~~~~~~~~~~~~~~~~~~~~~~~~~
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

if(report)
    % Output final png of sorted scores for report
    figure('Visible','off');
    contigidx = find(ranking == contignum);
    plot(1:numcontigs, sort(scores), '-ob', contigidx, scores(contignum), 'or');
    fname = 'figures/images/finalscores.jpeg';
    saveas(gcf, fname);
    
    % Output txt dump of details
    fid = fopen('figures/images/reportdata.txt','w');
    fprintf(fid, 'Correct Contingency: %d\n', contignum);
    fprintf(fid, 'Identified Contingency: %d\n', ranking(1));
    fprintf(fid, 'Noise Level: %f\n', noise');
    fprintf(fid, 'PMU Bus Locations: %d\n', PMU');
    fclose(fid);
    
    % Generate Report from Images in folder figures/images
    if(isunix)
       cd figures/images/
       !python stitchreport.py
       delete *.jpeg
       delete *.txt
       cd ../..
    end
end

% Delete instance of metadata.
clearMetadata();

    
end