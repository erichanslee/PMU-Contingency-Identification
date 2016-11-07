% Checks correctness of id_contig.m
function [scores, ranking, vecs, res] = testinstance(contignum, PMU)

if(nargin < 2)
    PMU = 64:77;
end

%% Run Test Instance

test = loadProblem('14bus', contignum, 'Weighted', 'None', PMU);
[scores, ranking, vecs, res] = run_problem(test);
fprintf('Contingency Identified: Contig %d\n', ranking(1));


end