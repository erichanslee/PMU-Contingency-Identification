% Unit Test for run_n4sid()
% The test checks to make sure fitting a state space model to the ODE system
% x'(t) = Ax(t) works well. Of special importance is the verification noise
% fitting, as n4sid's noise fitting routine does not have great behavior


% Initialize data, making sure to have a zero and complex eigenvectors
A = 2*[-3, 5, 2; 1, -1, 0; -2, -1, 0];
modelorder = 3;
interval = [0,10];
initial = [1, 1, 1];
f = @(t,x) [A(1,1)*x(1) + A(1,2)*x(2) + A(1,3)*x(3); A(2,1)*x(1) + A(2,2)*x(2) + A(2,3)*x(3); A(3,1)*x(1) + A(3,2)*x(2) + A(3,3)*x(3)];
timestep = .05;
timesteps = interval(1):timestep:interval(end);
[t,x] = ode45(f, timesteps, initial);

% Add a bit of white noise
W = randn(size(x)); 
x = x + .01*W.*x;

[eigvecs, eigvals] = runN4SID_inner(x, timestep, 3);