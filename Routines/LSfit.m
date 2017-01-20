function results = LSfit(obj, contignum)

% Get Metadata
load metadata.mat
signal = obj.dynamic_data;
signal = signal'; % signal currently in column format
tstep = .05;
dataoffset = 50*timestep;
results = zeros(1, numcontigs);

k = contignum;
% Grab model, form Schur Complement and calc necessary eigenpairs
[A,~] = obj.retrieveModel(k);

[vecs, vals] = eig(full(A), E);
vecs = vecs(obj.PMU, :);
vals = diag(vals);
vals(abs(vals) < 1e-8) = 0;
mode = 'freq';
[fvecs, fvals] = filter_eigpairs(0, 20, vals, vecs, mode);
mode = 'damp';
[fvecs, fvals] = filter_eigpairs(0, 100, fvals, fvecs, mode);

% Form matrix M
[len, numsteps] = size(signal);
S = reshape(signal, [], 1);
nummodes = length(fvals);
M = zeros(length(S), nummodes);
for i = 1:numsteps
    for j = 1:nummodes
        foffset = (i-1)*len + 1;
        boffset = i*len;
        time = (dataoffset + (i-1)*tstep);
        M(foffset:boffset, j) = exp(fvals(j)*time)*fvecs(:,j);
    end
end

% Regress and Calc Residual
c = M\S;
res = M*c - S;
results(k) = norm(res);



