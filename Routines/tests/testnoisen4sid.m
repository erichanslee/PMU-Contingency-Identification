% Tests the impact of noise to when running N4SID on real data. 

contignum = 3;
noise = .02;
PMU = [16 20 1 ];
PMUidx = place_PMU(contignum, PMU);
modelorder = 14;

% No Noise at First
testclean = loadProblem('39bus', contignum, 'Weighted', 'Weighted', 'None', PMUidx);
testnoisy = loadProblem('39bus', contignum, 'Weighted', 'Weighted', 'None', PMUidx);
testnoisy.dynamic_data = addNoise(testnoisy.dynamic_data, 'gaussian', noise);

[empvecs, empvals]  = runN4SID(testclean, modelorder, 0);

% Adding Noise
[Nempvecs, Nempvals]  = runN4SID(testnoisy, modelorder, 1);


M = normalizematrix(Nempvecs)'*normalizematrix(empvecs);
M = abs(M);
