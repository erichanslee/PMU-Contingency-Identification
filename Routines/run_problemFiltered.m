 function [scores, ranking, vecs, res] = run_problemFiltered(instance)


% calc fit data
[scores, eigenfits] = calcContigFiltered(instance);
[~, ranking]  = sort(scores);
vecs = eigenfits;
res = [];

end
    