load metadata.mat
A = full(matrix_read('matrixfull1'));
E = zeros(algebraic + differential);
E(1:differential, 1:differential) = eye(differential);
F = @(t,y,yp) E*yp - A*y;
y0 = rand(differential+algebraic,1);
y0p = rand(differential+algebraic,1) -0.5;
tstep = .005;
[t, y] = ode15i(F, 0:tstep:10, y0, y0p);
PMU = 64:77;
signal = y(:, PMU);
[Xa, Xd] = observer(A, E, differential, algebraic, signal, tstep, PMU);    