% Tests the quality of fit with N4SID. 

% Initial Data and  Variables
contignum = 1;
noise = .0;
PMU = [16 20 1 ];
PMUidx = place_PMU(contignum, PMU);
modelorder = 20;
testclean = loadProblem('145bus', contignum, 'Weighted', 'Weighted', 'None', PMUidx);
load metadata.mat
timesteps = 300;
data = testclean.dynamic_data(100:end, :);

% Start Running N4SID
len = size(data,1);
z = iddata(data ,zeros(len,1),timestep);

% set model order
opt = n4sidOptions('N4Weight', 'auto', 'Focus', 'simulation');
[m, x0] = n4sid(z, modelorder,'Form','modal','DisturbanceModel','none', opt);

% Calculate Eigenvalue and Eigenvector Predictions from N4SID
[ mx, md] = eig(m.A);
empvals = (log(md)/timestep);
empvecs = m.C*mx;
empvals = diag(empvals);


% Scaling Factors
c = mx\x0;

mode = 'amp';
%[empvecs, empvals] = filter_eigpairs(1e-1, [], empvals, empvecs, mode);
V = vand(timesteps, exp(timestep*empvals))';
V = diag(c) * V;

Y = zeros(size(m.A,1), timesteps);
for i = 1:timesteps
    Y(:,i) = m.A^(i-1)*x0;
end
CY = m.C*Y;
dataFittedSim = CY';
dataFitted = real((empvecs*V)');
dataTrue = data(1:timesteps,:);

hold on;
plot(dataFittedSim(:,22), '-b');
plot(dataTrue(:,22), '-r');


