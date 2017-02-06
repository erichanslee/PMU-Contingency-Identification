% Tests the impact of noise to when running N4SID on real data. 

contignum = 2;
noise = .01;
PMU = [16 1 2 5 10 35];
PMUidx = place_PMU(contignum, PMU);

% No Noise at First
test = loadProblem('39bus', contignum, 'Weighted', 'Weighted', PMUidx);
modelorder = 20;
[empvecs, empvals]  = runN4SID(test, modelorder, 0);

% Adding Noise
modelorder = 20;
[Nempvecs, Nempvals]  = runN4SID(test, modelorder, noise);

M = normalizematrix(Nempvecs)'*normalizematrix(empvecs);
M = abs(M);
