% LSfit calculates a least squares fit of a DAE to a signal by forming the
% matrix M consisting of elements (e^lambda*t)*v where (lambda, v) are
% eigenpairs of the DAE. 

% So LSfit first calculates the eigenpairs (lambda, v), forms the matrix M,
% and then calculates c = M\S where S is the signal and c is a vector of
% coefficients

function results = LSfit(obj, contignum)

% Get Metadata and initialize some variables
load metadata.mat
signal = obj.dynamic_data;
signal = signal'; % signal currently in column format
tstep = .05;
dataoffset = 100*timestep;
results = zeros(1, numcontigs);
n = differential;

% Grab model, form Schur Complement SCH
[A,~] = obj.retrieveModel(contignum);
A11 = A(1:n, 1:n); A12 = A(1:n, (n+1):end);
A21 = A((n+1):end, 1:n); A22 = A((n+1):end, (n+1):end);
SCH = A11 - A12*(A22\A21);

% Calc and Filter Eigenpairs
[vecs, vals] = eig(full(SCH));
vecs = vecs(obj.PMU - n, :);
vals = diag(vals);
vals(abs(vals) < 1e-8) = 0;
mode = 'freq';
[fvecs, fvals] = filter_eigpairs(0, 20, vals, vecs, mode);
mode = 'damp';
[fvecs, fvals] = filter_eigpairs(0, 100, fvals, fvecs, mode);

% Form matrix M
[len, numsteps] = size(signal);
SIG = reshape(signal, [], 1);
nummodes = length(fvals);
M = zeros(length(SIG), nummodes);
for i = 1:numsteps
    for j = 1:nummodes
        foffset = (i-1)*len + 1;
        boffset = i*len;
        time = (dataoffset + (i-1)*tstep);
        M(foffset:boffset, j) = exp(fvals(j)*time)*fvecs(:,j);
    end
end

% Regress and Calc Residual
c = M\SIG;
res = M*c - SIG;
results = norm(res);



