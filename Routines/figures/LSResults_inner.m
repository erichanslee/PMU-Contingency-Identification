% Tests Least Squares Fitting LSfit() on contingency contignum

function results = LSResults_inner(contignum, PMUidx)

load metadata.mat
PMU = place_PMU(contignum, PMUidx);
test = loadProblem('39bus', contignum, 'Weighted', 'Weighted', PMU);
results = zeros(1, numcontigs);
for i = 1:numcontigs
    results(i) = LSfit(test, i);
end
