% Runs contig identification on all contingencies
function [results, results3, scores] = testsparse()

% Load metadata, initialize results vectors
load metadata.mat
noise = .03;
modelorder = 14;
PMU = [16 1 11 22 20 7];
evalmethod = 'all';
numevals = 0;
results = 0; results3 = 0;
scores = zeros(numcontigs);
% Run contingency identification for all possible contigs (numcontigs)
for j = 1:numcontigs
    contig = j;
    [scores(:, j), ranking, ~, ~] = testinstance(evalmethod, contig, PMU, noise, modelorder, numevals);
    if(contig ==  ranking(1)) results = results + 1; end
    if(ismember(contig, ranking(1:3))) results3 = results3 + 1; end
end


% Plot Results
plot(results/numcontigs, '-ob');
hold on
plot(results3/numcontigs, '-*r');
ylabel('Percentage of Correct Diagnoses')
xlabel('Number of PMUs')
legend('Top 1', 'Top 3')
axis([1 10 0 1.5])

end

