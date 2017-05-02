%% calc_contig (Filtered Version)

% ~~~~~~~~~INPUTS~~~~~~~~~ %
% obj = instance object
% noise = amount of noise injected
% modelorder = order of model for N4SID to fit
%

% ~~~~~~~~~OUTPUTS~~~~~~~~~ %
% scores = scores with filtering
% eigenfits = number of eigenvectors fitted before scoring.

function [scores, eigenfits] = calcContigTD(obj, noise, modelorder, numevals)

load metadata.mat
PMU = obj.PMU;
PMUdata = obj.PMU_data;
tstep = timestep;
alpha = 1;

% Truncate Dynamic Data and form RHS of LS Problem
len = 100;
data = PMUdata(1:len, :);
b1 = zeros((differential + algebraic)*len , 1);
b2 = alpha*reshape(data', [len*length(PMU), 1]);
b = [b1; b2];
b = sparse(b);

% As a sanity check, load full state (FS) as well. 
FS = obj.Full_data(1:len, :);


% Form Sensing Matrix A
H = zeros(length(PMU), differential + algebraic);
for i = 1:length(PMU)
    H(i, PMU(i)) = 1;
end
H = sparse(alpha*H);

% Form Matrices Necessary for Kronecker Product
L = diag(ones(len-1,1),1);
L = sparse(L);
Iboundary = speye(len);
Iboundary(end, end) = 0;

for k = 1:numcontigs
    % Read in matrix and form Discrete Algebraic Equations E*x(n+1) = Ad*x(n)
    contig = k;
    [A,E] = obj.retrieveModel(contig);
    E = sparse(E);
    Ad = ContToDiscrete(A, differential, algebraic, tstep);
    
    
    % Form LS Matrix
    M1 = kron(Iboundary, Ad) - kron(L, E);
    M2 = kron(speye(len), H);

    M = [M1; M2];
    x = M\b;
    tsteps = size(data,1);
    
    plotFirst(x, data, PMU, differential + algebraic);
    scores(k) = norm(M*x - b);
    eigenfits(k) = 0;
    
end


end

% Helper Function Turning Continuous DAE into a Discrete One
function Ad = ContToDiscrete(A, n, m, tstep)

A11 = A(1:n, 1:n);
A12 = A(1:n, n+1:n+m);
A21 = A(n+1:n+m, 1:n);
A22 = A(n+1:n+m, n+1:n+m);
As = A11 - A12*(A22\A21);
Ash = expm(As*tstep);
Ad = [Ash, zeros(size(A12)); A21, A22];
Ad = sparse(Ad);

end

% Debugging Function to check plots; 
function plotFirst(x, data, PMU, ssize)

for i = 1:length(PMU)
    tsteps = size(data,1);
    X = reshape(x, [ssize, tsteps]);
    X = X';
    Y = X(:, PMU);
    plot(1:tsteps, data(:,i), 1:tsteps, Y(:,i));
    legend('True', 'Fitted');
end

end