% Checks correctness of id_contig.m
function [scores, ranking, vecs, res] = testinstance(contignum, PMU)


%% Run Test Instance

test = loadProblem('39bus', contignum, 'Weighted', 'Weighted', PMU);
% calc fit data
[vecs, res, weights] = calcContig(test);

% predict contingency
analysis_method = test.analysis_method;
[ranking, scores] = calcScores(test, analysis_method, vecs, res, weights);

fprintf('Contingency Identified: Contig %d\n', ranking(1));


end