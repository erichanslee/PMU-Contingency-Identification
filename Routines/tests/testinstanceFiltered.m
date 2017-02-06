% Checks correctness of id_contig.m
function [scores, ranking, vecs, res] = testinstanceFiltered(contignum, PMU)


%% Run Test Instance

test = loadProblem('39bus', contignum, 'Weighted', 'Weighted', PMU);
[scores, eigenfits] = calcContigFiltered(test);
[~, ranking]  = sort(scores);
vecs = eigenfits;
res = [];
fprintf('Contingency Identified: Contig %d\n', ranking(1));


end