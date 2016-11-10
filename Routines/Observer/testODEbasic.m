A = rand(10);
A = A - 6*eye(10);
C = zeros(5,10);
C(1:5,1:5) = eye(5);
f = @(t,x) A*x;
time = 7;
stepsize = 0.01;
steps = time/stepsize;
[t,y] = ode45(f, 0:stepsize:time, rand(10,1));
y = C*(y');

L = gainmatrix(A, C);
csys = ss(A, L, eye(size(A)), zeros(size(L)));
dsys = c2d(csys, stepsize);
X = zeros(10,steps);
Z = zeros(5,steps);
init = 1.5*ones(10,1);
X(:,1) = init;
Z(:,1) = C*init;
for i = 2:steps
z = y(:,i);
X(:,i+1) = dsys.A*X(:,i) - dsys.B*(z - Z(:,i));
Z(:,i) = C*X(:,i);
end