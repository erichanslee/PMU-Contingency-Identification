function dataobs = observer(contignum, matrixnum, noise, PMUidx)

maxfreq = .5;
minfreq = .05;
tstep = .05;
load metadata.mat;

%%  Place PMUs and Offset data
win = place_PMU(contignum, PMUidx);
rangebus = (differential + numlines + 1):(differential + numlines + numlines);

%   Load and offset data
filename = ['data/busdata_' num2str(contignum) '.mat'];
load(filename);
offset = 50;
data = data(offset:end, win - (differential + numlines));
data = data';

% Calculate Eigenvalue and Eigenvector Predictions from State Matrix
% from the reduced state matrix
I = eye(differential);
E = zeros(algebraic + differential);
E(1:differential,1:differential) = I;
A = full(matrix_read(sprintf('data/matrixfull%d', contignum)));
[vi,di] = eig(A,E); 

% Organize data from State Matrix properly
[linvecsEntire, linvals] = filter_eigpairs(minfreq, maxfreq, diag(di), vi);
linvecs = linvecsEntire(rangebus,:); 
linearvecs = linvecsEntire;

% Construct possible system generating data
M = form_ode(linvecs, linvals);
M = expm(M*tstep);

% Construct gain matrix and run observer
K = 0.5*M;
x0 = 1.2*ones(numlines,1);
dataobs = run_observer(data, M, K, x0)
hold on;
plot(real(dataobs(1,:)));
plot(data(1,:));

end