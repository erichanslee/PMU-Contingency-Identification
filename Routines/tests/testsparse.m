function [results, results3, confidence] = testsparse()
% Runs contig identification on all contingencies
tic;
load metadata.mat

numtrials = 3;

results = zeros(1,numtrials);
results3 = zeros(1,numtrials);
confidence = zeros(1,numtrials);
for i = 1:numtrials
    for j = 1:numcontigs
        contig = j;
        idx = floor(numbuses/2);
        PMUidx = idx:idx+i;
        PMU = place_PMU(contig, PMUidx);
        %PMU = 120:(125 + 3*i);
        [scores, ranking, vecs, res] = testinstance(contig, PMU);
        if(contig ==  ranking(1)) results(i) = results(i) + 1; end
        if(ismember(contig, ranking(1:3))) results3(i) = results3(i) + 1; end
        confidence(i) = confidence(i) + abs(scores(1) - scores(2))/scores(1);
    end
end
toc
plot(results/numcontigs, '-ob');
hold on
plot(results3/numcontigs, '-*r');
%plot(confidence/numcontigs, 'g');
ylabel('Percentage of Correct Diagnoses')
xlabel('Number of PMUs')
xlabel('Number of PMUs Missing')
legend('Top 1', 'Top 3')
axis([1 14 0 1.5])

end

