% Tests Least Squares Fitting LSfit() on all possible contingencies and
% then outputs ranking of correct contingencies

load metadata.mat
PMU = [16];

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
        idcontig = find(idx == i);
        if(contig ==  idcontig) results(j) = results(j) + 1; end
        if(ismember(contig, ranking(1:3))) results3(j) = results3(j) + 1; end
    end
end