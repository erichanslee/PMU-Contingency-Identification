% Unit Test for LSfit_inner
% The test checks to make sure the the fit for the ODE system
% x'(t) = Ax(t) 


% Initialize data, making sure to have a zero and complex eigenvectors
A = 2*[-3, 5, 2; 1, -1, 0; -2, -1, 0];
interval = [0,10];
initial = [1, 1, 1];
f = @(t,x) [A(1,1)*x(1) + A(1,2)*x(2) + A(1,3)*x(3); A(2,1)*x(1) + A(2,2)*x(2) + A(2,3)*x(3); A(3,1)*x(1) + A(3,2)*x(2) + A(3,3)*x(3)];
timestep = .05;
timesteps = interval(1):timestep:interval(end);
[t,x] = ode45(f, timesteps, initial);

% Get eigvals and eigvecs
[eigvecs, eigvals] = eig(A);
eigvals = diag(eigvals);
signal = x';
signal = reshape(signal, [], 1);
signalsize = 3;
signal = signal;

% Run LSfit_inner
results = LSfit_inner(signal, signalsize, timestep, interval(1), eigvals, eigvecs);
