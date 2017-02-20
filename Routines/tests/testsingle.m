% Runs contig identification on all contingencies
% function [result, result3, result5, scores] = testsparse(noise)

% ~~~INPUT~~~ %
% noise = variance of noise to be added.

% ~~~OUTPUT~~~ %
% result(n) = number of correct identifications within the n-th ranking
% scores = matrix of scores; score(i,j) represents the score of contingency i fitted against the jacobian of contingency j.

% SUGGESTIONS: Model Order should be at least 10

function [scores, ranking] = testsingle(contig, noise, modelorder)

% Load metadata, initialize results vectors
load metadata.mat
PMU = [16 20 1 ];
evalmethod = 'all';
numevals = 0;
% Run contingency identification for all possible contigs (numcontigs)

[scores, ranking, ~, ~] = testinstance(evalmethod, contig, PMU, noise, modelorder, numevals);

end

