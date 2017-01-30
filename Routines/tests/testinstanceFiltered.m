% Checks correctness of id_contig.m
function [scores, ranking, vecs, res] = testinstanceFiltered(contignum, PMU)


%% Run Test Instance

test = loadProblem('39bus', contignum, 'Weighted', 'Weighted', PMU);
[scores, ranking, vecs, res] = run_problemFiltered(test);
fprintf('Contingency Identified: Contig %d\n', ranking(1));


end