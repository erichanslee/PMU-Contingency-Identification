% Checks correctness of id_contig.m
function [scores, ranking, vecs, res] = testinstance(contignum, PMU)

if(nargin < 2)
    PMU = 64:77;
end

%% Run Test Instance

test = load_problem('14bus', contignum, 'Constrained', 'None', PMU);
[scores, ranking, vecs, res] = run_problem(test);
fprintf('Contingency Identified: Contig %d\n', ranking(1));
evecs_fitted  = vecs{ranking(1)};
    

end