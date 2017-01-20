function testLS(contignum)
% Tests Least Squares Fitting LSfit()
load metadata.mat
PMUidx = [16];
PMU = place_PMU(contignum, PMUidx);
test = loadProblem('39bus', contignum, 'Weighted', 'Weighted', PMU);
results = LSfit(test, contignum)
