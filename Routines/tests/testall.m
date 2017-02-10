function [results, results3] = testall()
% Runs contig identification on all contingencies

load metadata.mat

results = zeros(1,numbuses);
results3 = zeros(1,numbuses);
confidence = zeros(1,numbuses);

for i = 1:numbuses
    for j = 1:numcontigs
        contig = j;
        PMU = [16 1 i];
        [scores, ranking, vecs, res] = testinstance(contig, PMU);
        if(contig ==  ranking(1)) results(i) = results(i) + 1; end
        if(ismember(contig, ranking(1:3))) results3(i) = results3(i) + 1; end
    end
end
numtrials = 10; 
plot(results/numtrials, '-ob');
hold on
plot(results3/numtrials, '-*r');
ylabel('Percentage of Correct Diagnoses')
xlabel('Number of PMUs')
xlabel('Number of PMUs Missing')
legend('Top 1', 'Top 3')
axis([1 14 0 1.5])

end

