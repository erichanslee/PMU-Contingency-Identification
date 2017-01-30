% LSfit calculates a least squares fit of a DAE to a signal by forming the
% matrix M consisting of elements (e^lambda*t)*v where (lambda, v) are
% eigenpairs of the DAE. 

% So LSfit first calculates the eigenpairs (lambda, v), forms the matrix M,
% and then calculates c = M\S where S is the signal and c is a vector of
% coefficients

function results = LSfit(obj, contignum)

% Get Metadata and reshape signal into proper format
load metadata.mat
signal = obj.dynamic_data;
[numtimesteps, signalsize] = size(signal);
for i = 1:signalsize
    signal(:,i) = signal(:,i) - mean(signal(floor(numtimesteps/3):end,i)); %Shift by steady state to avoid fitting zero eigenpairs
end
signal = signal(1:floor(numtimesteps/2), :);
signal = signal'; % signal currently in column format
timestep = .05;
dataoffset = 20*timestep;
n = differential;
signal = reshape(signal, [], 1);

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
[eigvecs, eigvals] = filter_eigpairs(0, 40, fvals, fvecs, mode);

results = LSfit_inner(signal, signalsize, timestep, dataoffset, eigvals, eigvecs);



