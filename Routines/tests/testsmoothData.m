% Tests the impact of noise to when running N4SID on real data. 

contignum = 2;
noise = .03;
PMU = [16 1 2 5 10 35];
PMUidx = place_PMU(contignum, PMU);
modelorder = 10;

test = loadProblem('39bus', contignum, 'Weighted', 'Weighted', 'None', PMUidx);
data = addNoise(test.dynamic_data, 'gaussian', noise);


n = 100;
%data = sin((1:n)/10) + .2*rand(1,n);

hold on; 
%plot(data(40:400,1), '-b');
dataSmoothed = smoothData(data, 2, 1/30, 'gaussfilter');
dataSmoothed = real(dataSmoothed);
plot(dataSmoothed(40:400,1), '-r');
plot(test.dynamic_data(40:400,1), '-k');

%[Nempvecs, Nempvals]  = runN4SID(test, modelorder, noise);

