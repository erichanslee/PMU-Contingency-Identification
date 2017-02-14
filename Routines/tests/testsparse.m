% Runs contig identification on all contingencies
function [result, result3, result5, scores] = testsparse(noise)

% Load metadata, initialize results vectors
load metadata.mat
modelorder = 14;
PMU = [16 1];
evalmethod = 'all';
numevals = 0;
result = 0; result3 = 0; result5 = 0;
scores = zeros(numcontigs);
% Run contingency identification for all possible contigs (numcontigs)
for j = 1:numcontigs
    contig = j;
    [scores(:, j), ranking, ~, ~] = testinstance(evalmethod, contig, PMU, noise, modelorder, numevals);
    if(contig ==  ranking(1)) result = result + 1; end
    if(ismember(contig, ranking(1:3))) result3 = result3 + 1; end
    if(ismember(contig, ranking(1:5))) result5 = result5 + 1; end
end


% Plot Results
% plot(result/numcontigs, '-ob');
% hold on
% plot(result3/numcontigs, '-*r');
% ylabel('Percentage of Correct Diagnoses')
% xlabel('Number of PMUs')
% legend('Top 1', 'Top 3')
% axis([1 10 0 1.5])

end

