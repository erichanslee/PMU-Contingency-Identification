% Runs contig identification on all contingencies
% function [result, result3, result5, scores, misdiagnoses] = testsparse(noise, modelorder, numthreads)

% ~~~INPUT~~~ %
% noise = variance of noise to be added.
% modelorder = size of model to be fit. Make smaller = faster but less accurate
% mode = tell to run serially or in parallel

% ~~~OUTPUT~~~ %
% result(n) = number of correct identifications within the n-th ranking
% scores = matrix of scores; score(i,j) represents the score of contingency i fitted against the jacobian of contingency j.
% misdiagnoses = k x 3 matrix of misdiagnoses [incorrect x correct x ranking]

% SUGGESTIONS: Model Order should be at least 10

function [result, result3, result5, scores, misdiagnoses] = testsparse(noise, modelorder, mode)

% Load metadata, initialize results vectors
load metadata.mat
PMU = [16 1 5 20];
evalmethod = 'all';
numevals = 0;
results = zeros(1, numcontigs);
results3 = zeros(1, numcontigs);
results5 = zeros(1, numcontigs);
result = 0; result3 = 0; result5 = 0;
scores = zeros(numcontigs);
misdiagnoses = zeros(numcontigs, 3);
% Run contingency identification for all possible contigs (numcontigs)

switch mode
    case 'serial'
        for j = 1:numcontigs
            contig = j;
            [scores(:, j), ranking, ~, ~] = testinstance(evalmethod, contig, PMU, noise, modelorder, numevals);
            
            if(contig ==  ranking(1))
                result = result + 1;
                M = zeros(1,3);
                M(1,1) = ranking(1);
                M(1,2) = contig;
                M(1,3) = find(ranking == contig);
                misdiagnoses(j,:) = M;
            end
            
            if(ismember(contig, ranking(1:3)))
                result3 = result3 + 1;
            end
            
            if(ismember(contig, ranking(1:5)))
                result5 = result5 + 1;
            end
        end
        
        
    case 'parallel'
        parfor j = 1:numcontigs
            contig = j;
            [scores(:, j), ranking, ~, ~] = testinstance(evalmethod, contig, PMU, noise, modelorder, numevals);
            
            if(contig ==  ranking(1))
                results(j) = 1;
            else
                M = zeros(1,3);
                M(1,1) = ranking(1);
                M(1,2) = contig;
                M(1,3) = find(ranking == contig);
                misdiagnoses(j,:) = M;
            end
            
            if(ismember(contig, ranking(1:3)))
                results3(j) = 1;
            end
            
            if(ismember(contig, ranking(1:5)))
                results5(j) = 1;
            end
        end
        result = sum(results); result3 = sum(results3); result5 = sum(results5);
end
end

