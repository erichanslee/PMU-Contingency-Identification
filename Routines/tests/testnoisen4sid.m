% Tests the impact of noise to when running N4SID on real data. 

contignum = 2;
noise = .01;
PMU = [16 1 2 5 10 35];
PMUidx = place_PMU(contignum, PMU);
modelorder = 10;

% No Noise at First
test = loadProblem('39bus', contignum, 'Weighted', 'Weighted', 'None', PMUidx);
[empvecs, empvals]  = runN4SID(test, modelorder, 0);

% Adding Noise
[Nempvecs, Nempvals]  = runN4SID(test, modelorder, noise);

M = normalizematrix(Nempvecs)'*normalizematrix(empvecs);
M = abs(M);

% Smooth out data
dataSmoothed = smoothData(test.dynamic_data, 100, 1/30, 'fft');

