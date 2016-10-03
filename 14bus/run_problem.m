
function [scores, ranking, vecs, res] = run_problem(instance)


% calc fit data
[vecs, res] = calc_contig(instance);

% predict contingency
analysis_method = instance.analysis_method;
[ranking, scores] = calc_scores(analysis_method, res);

end
