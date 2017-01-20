function results = testLS(contignum)
% Tests Least Squares Fitting LSfit()
load metadata.mat
PMUidx = 16;
PMU = place_PMU(contignum, PMUidx);
test = loadProblem('39bus', contignum, 'Weighted', 'Weighted', PMU);
results = zeros(1, numcontigs);
for i = 1:numcontigs
    results(i) = LSfit(test, i);
end
