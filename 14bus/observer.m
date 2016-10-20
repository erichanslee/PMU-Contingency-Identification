function dataobs = observer(A, E, differential, algebraic, signal, signal_tstep, PMU)

% The dae given by 
% x1' = A11*x1 + A12*x2
% 0 = A21*x1 + A22*x2
% y = H*x2
% 
% Can be transformed to 
% x1' = S*x1 
% 0 = A21*x1 + A22*x2
% y = H*x2
% 
% And then we can construct diagnostic observer with the formula
% 
% s1' = S*s1 + L(z - y)
% 0 = A21*s1 + A22*s2
% z = H*s2


n = differential;
m = algebraic;

[A, E] = DAEcanonical(A, E, n);
A11 = A(1:n, 1:n); A12 = A(1:n, (n+1):end);
A21 = A((n+1):end, 1:n); A22 = A((n+1):end, (n+1):end);
H = zeros(length(PMU), m);
H(:, PMU-n) = eye(length(PMU));

% convert to problem S - LC
%   Where S is Schur Complement, L is gain matrix, C is given

S = A11 - A12*(A22\A21);
C = H*(A22\A21);clc

L = gainmatrix(S, C);

% convert continuous problem to discrete

csys = ss(S, L, eye(size(S)), zeros(size(L)));
dsys = c2d(csys, signal_tstep);

xinit = 1.5*ones(differential,1);
yinit = 1.5*ones(algebraic,1);
init = 1.5*ones(length(PMU),1);
len = size(signal,1);
X = zeros(differential, len); X(:,1) = xinit;
Y = zeros(algebraic, len); Y(:,1) = yinit;
Z = zeros(length(PMU),len); Z(:,1) = init;

A22invA21 = A22\A21;

for i = 2:len
    z = (fliplr(signal(i,:)))';
    X(:,i+1) = S*X(:,i) + L*(Z(:,i) - z);
    Y(:,i) = A22invA21*X(:,i);
    Z(:,i) = H*Y(:,i);
end

end