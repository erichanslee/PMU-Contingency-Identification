
% Form Matrix, Get Simulation via ODE45 
A = [
   -0.5982,   -0.1839,   -0.9027,    0.6377;
   -0.0760,   -0.7600,    0.9448,    0.4001;
    0.9399,    0.4173,   -1.5091,    0.3692;
    0.9233,    0.0497,    0.4893,   -1.8888
]

x0 = ones(size(A,1),1);
f = @(t,x) A*x;
tstep = 0.01;
t0 = rand(4,1); tn = 20;
tspan = t0:tstep:tn;
[t,y] = ode45(f,tspan, t0);

len = length(tspan);

% Add Noise to Data
y = y + 0.000*randn(size(y));

% Form Big Least-Squares Problem, solving Mz = b where
% M1 corresponds to the Discrete Systems constraint Az_i - z_i+1 = 0
% M2 corresponds to the Input Constraint Hz_i = y_i
% M3 corresponds to a smoothing constraint 
H = [eye(2), zeros(2)];
Ad = expm(A*tstep);
L = diag(ones(len-1,1),1);
M1 = kron(eye(len), Ad) - kron(L, eye(size(A,1)));
M1(end-3:end, end-3:end) = 0;
M2 = kron(eye(len), H);
M3 = []; % 0.2*1/tstep*(kron(eye(len), eye(size(A,1))) - kron(L, eye(size(A,1))));
M = [M1; M2; M3];
M = sparse(M);

% Form b 
b1 = zeros(4*len,1);
b2 = zeros(2*len,1);
b3 = zeros(size(M3, 1),1);
for i = 1:len
	b2(2*i - 1) = y(i,1);
	b2(2*i) = y(i,2);
end
b = [b1;b2; b3];

% Solve Least Squares Problem
z = M\b;
display('Fitting Error');
display(norm(M*z - b));
hold on;
plot(y(:,1),'-b');
plot(z(1:4:end),'-r');