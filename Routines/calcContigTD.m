%% calc_contig (Filtered Version)

% ~~~~~~~~~INPUTS~~~~~~~~~ %
% obj = instance object
% noise = amount of noise injected
% modelorder = order of model for N4SID to fit
%

% ~~~~~~~~~OUTPUTS~~~~~~~~~ %
% scores = scores with filtering
% eigenfits = number of eigenvectors fitted before scoring.

function [scores, eigenfits] = calcContigTD(obj, noise, modelorder)

% Misc. Parameters Initialized
load metadata.mat
PMU = obj.PMU;
PMU = sort(PMU, 'ascend');
PMUdata = obj.PMU_data;
alpha = 1;
len = 400;

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

% Load Full State from simulation just to check 
load(sprintf('statedata%d.mat', obj.correctContig));
FS = statedata(50:end, :);
FS = FS(1:len, :);
fs = MatToVec(FS);

for k = 1:numcontigs

    % Form Discrete Algebraic Equations
    [A, E] = obj.retrieveModel(k);
    Ad = GetDiscrete(A, differential, algebraic, timestep);
    Ad = sparse(Ad);
    E = sparse(E);
    M1 = kron(speye(len), alpha*H);
    M2 = kron(I, Ad) - kron(L, E);
    b2 = zeros(size(M2, 1), 1);
    b = sparse([alpha*b1; b2]);
    Mk = [M1; M2];

    % Solve LS problem and return residual
    x = Mk\b;
    scores(k) = norm(Mk*x - b)/norm(b);
    eigenfits(k) = 0;
end

end

% Forms Discrete Matrix Ad from the DAE Ex' = Ax
function Ad = GetDiscrete(A, n, m, timestep)
    A11 = A(1:n, 1:n);
    A22 = A(n+1:n+m, n+1:n+m);
    A12 = A(1:n, n+1:n+m);
    A21 = A(n+1:n+m, 1:n);
    As = A11 - A12*(A22\A21);
    Asd = expm(As*timestep);
    Ad = [Asd, zeros(size(A12)); A21, A22];
end

% Reshapes the data matrix X = [x1'; x2' ... xn'] to
% x = [x1; x2; ... xn]
function x = MatToVec(X)
    len = size(X,1)*size(X,2);
    x = reshape(X', [len, 1]);
end

% Debugging Function to check plots; 
function plotFirst(x, data, PMU, ssize)

for i = 1:length(PMU)
    tsteps = size(data,1);
    X = reshape(x, [ssize, tsteps]);
    X = X';
    Y = X(:, PMU);
    plot(1:tsteps, Y(:,i));
    legend('True', 'Fitted');
end

end