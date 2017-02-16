% Runs contig identification on all contingencies
% function [result, result3, result5, scores] = testsparse(noise)

% ~~~INPUT~~~ %
% noise = variance of noise to be added. 

% ~~~OUTPUT~~~ %
% result(n) = number of correct identifications within the n-th ranking
% scores = matrix of scores; score(i,j) represents the score of contingency i fitted against the jacobian of contingency j. 


function [result, result3, result5, scores] = confusionSparsePMU(noise)

% Load metadata, initialize results vectors
load metadata.mat
modelorder = 14;
PMU = [16 20 1 ];
evalmethod = 'all';
numevals = 0;
result = 0; result3 = 0; result5 = 0;
scores = zeros(numcontigs);
% Run contingency identification for all possible contigs (numcontigs)
for j = 1:numcontigs
    contig = j;
    [scores(:, j), ranking, ~, ~] = testinstance(evalmethod, contig, PMU, noise, modelorder, numevals);
    scores(:,j) = scores(:,j) / norm(scores(:,j));
    scores(:,j) = scores(:,j) - scores(j,j);
    
    if(contig ==  ranking(1))
    	result = result + 1; 
    else
    	scores(j,j) = 2;
 	end
    
    if(ismember(contig, ranking(1:3))) 
    	result3 = result3 + 1; 
    end
    
    if(ismember(contig, ranking(1:5))) 
    	result5 = result5 + 1;
    end
end


imagesc(log(scores));

end

