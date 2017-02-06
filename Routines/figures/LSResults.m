% Tests Least Squares Fitting LSfit() on all possible contingencies and
% then outputs ranking of correct contingencies

load metadata.mat
PMU = [16, 2, 25, 17, 26, 23, 9, 28, 15, 18];

numtrials = length(PMU);
results = zeros(1,numtrials);
results3 = zeros(1,numtrials);
for j = 1:numtrials
    PMUidx = PMU(1:j);
    ranking = zeros(1, numcontigs);
    for i = 1:numcontigs
        contig = i;
        LSresults = LSResults_inner(contig,PMUidx);
        [~, idx] = sort(LSresults);
        if(contig == idx(1)) results(j) = results(j) + 1; end
        if(ismember(contig, idx(1:3))) results3(j) = results3(j) + 1; end
    end 
end

plot(results/numcontigs, '-ob');
hold on
plot(results3/numcontigs, '-*r');
ylabel('Percentage of Correct Diagnoses')
xlabel('Number of PMUs')
legend('Top 1', 'Top 3')
axis([1 10 0 1.5])

fig = gcf;
fig.PaperUnits = 'inches';
print('LSResults', '-dpng');
hold off; 
clf;