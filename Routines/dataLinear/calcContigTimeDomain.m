%% calc_contig (Filtered Version)

% ~~~~~~~~~INPUTS~~~~~~~~~ %
% obj = instance object
% noise = amount of noise injected
% modelorder = order of model for N4SID to fit
%

% ~~~~~~~~~OUTPUTS~~~~~~~~~ %
% scores = scores with filtering
% eigenfits = number of eigenvectors fitted before scoring.

function [scores] = calcContigTimeDomain(contignum)

fname = sprintf('LinearData%d.mat', contignum);
load(fname);

load metadata.mat
% ~~~~~~~~~~~~~~~~~~~~~~~~~~ %
% ~~~~~ Form Matrices~~~~~~~ %
% ~~~~~~~~~~~~~~~~~~~~~~~~~~ %


% Misc. Parameters Initialized
PMU = algebraic : algebraic  + 20;
PMUdata = data(:, PMU);
alpha = 1;
len = size(PMUdata,1);

% Form Matrices for Kronecker Products
H = zeros(length(PMU), differential + algebraic);
for i = 1:length(PMU)
    H(i, PMU(i)) = 1;
end
L = diag(ones(len-1,1), 1);
L = sparse(L);
I = speye(len);
I(end, end) = 0;
b1 = MatToVec(PMUdata(1:len, :));

clear A;
for i = 1:numcontigs
    load(sprintf('matrixdata%d.mat',i));
    
    % Form Discrete Algebraic Equations
    Ad = GetDiscrete(A, differential, algebraic, tstep);
    Ad = sparse(Ad);
    E = sparse(E);
    M1 = kron(speye(len), alpha*H);
    M2 = kron(I, Ad) - kron(L, E);
    b2 = zeros(size(M2, 1), 1);
    b = sparse([alpha*b1; b2]);
    Mk = [M1; M2];
    x = Mk\b;
    
    % Solve LS problem and return residual
    scores(i) = norm(Mk*x - b)/norm(b);
end


end

% Forms Discrete Matrix Ad from the DAE Ex' = Ax
function Ad = GetDiscrete(A, n, m, tstep)
A11 = A(1:n, 1:n);
A22 = A(n+1:n+m, n+1:n+m);
A12 = A(1:n, n+1:n+m);
A21 = A(n+1:n+m, 1:n);
As = A11 - A12*(A22\A21);
Asd = expm(As*tstep);
Ad = [Asd, zeros(size(A12)); A21, A22];
end

% Reshapes the data matrix X = [x1'; x2' ... xn'] to
% x = [x1; x2; ... xn]
function x = MatToVec(X)
len = size(X,1)*size(X,2);
x = reshape(X', [len, 1]);
end

% Reshapes the vector x = [x1; x2; ... xn] to the to
% the data matrix X = [x1'; x2' ... xn'] where xi has size ssize
function X = VecToMat(x, ssize)
dim1 = length(x)/ssize;
dim2 = ssize;
X = reshape(x, [dim2, dim1])';
end
% Debugging Function to check plots;
function plotFirst(x, data, PMU, ssize)

tsteps = size(data,1);
plot(1:tsteps, data(:,5) + 1, 1:tsteps, x(PMU(5):ssize:end));
legend('True', 'Fitted');

end