% Tests the impact of noise to when running N4SID on real data. 

contignum = 2;
noise = .1;
PMU = [16 1 5 10 35];
PMUidx = place_PMU(contignum, PMU);
modelorder = 20;

test = loadProblem('39bus', contignum, 'Weighted', 'Weighted', 'None', PMUidx);
data = addNoise(test.dynamic_data, 'gaussian', noise);


n = 100;
%data = sin((1:n)/10) + .2*rand(1,n);

dataSmoothed = smoothData(data, 2, 1/30, 'gaussfilter');
dataSmoothed = real(dataSmoothed);

subplot(3,1,1)
plot(data(40:400,1), '-b');
legend('Noised');
subplot(3,1,2)
plot(dataSmoothed(40:400,1), '-r');
legend('Smoothed');
subplot(3,1,3)
plot(test.dynamic_data(40:400,1), '-k');
legend('Clean');

%[Nempvecs, Nempvals, ~]  = runN4SID(test, modelorder, noise);

