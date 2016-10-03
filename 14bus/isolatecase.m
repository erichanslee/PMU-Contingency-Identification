% isolatecase is an auxillary function for data analysis that checks
% runs a time-domain simulation for contingency <contignum> and then
% calculates residuals for the linearized system <matrixnum>


% NOTE: code contains quite a bit of similarity with other files but
% is separate due to large amount of output. 

% ~~~~~~~~~INPUTS~~~~~~~~~ %

% method = method type number one would like to use
% contignum = contingency to simulate
% matrixnum = linearized system to use for residual calculation
% noise = percentage of max amplitude to add as gaussian noise

% ~~~~~~~~~OUTPUTS~~~~~~~~~ %

% linearvecs = eigenvectors from the linearized system Jacobian
% empvecsEntire = eigenvectors from fitting
% empresidual = residual from fittings

function [linvecsEntire, empvecsEntire, empresidual, dotmatrix] = isolatecase(method, contignum, matrixnum, noise, PMUidx)

maxfreq = .5;
minfreq = .05;
load('metadata.mat')

%% Basic Pre-Run Checks
if(method > 5 || method < 1)
    error('Problems with parameter "Method". Please an integer in [1,3]')
end

if(noise > 1 || noise < 0)
    error('Problems with parameter "Noise". Please enter in a real number in the range of [0,1]')
end

if(contignum > numcontigs)
    error('Contigency Number not found! Please enter a smaller integer')
end

%%  Randomly Place PMUs and Offset data
win = place_PMU(contignum, PMUidx);
rangebus = (differential + numlines + 1):(differential + numlines + numlines);

%   Load and offset data
filename = ['data/busdata_' num2str(contignum) '.mat'];
load(filename);
offset = 50;
data = data(offset:end, win - (differential + numlines));

[empvals, empvecs]  = run_n4sid(data, timestep, numlines, maxfreq, minfreq);
empvecs = normalizematrix(empvecs);
data_dump = zeros(1,numcontigs);

% Calculate Eigenvalue and Eigenvector Predictions from State Matrix
% from the reduced state matrix
I = eye(differential);
E = zeros(algebraic + differential);
E(1:differential,1:differential) = I;
Atrue = full(matrix_read(sprintf('data/matrixfull%d', contignum)));
[vi,di] = eig(Atrue,E);

% Organize data from State Matrix properly
[linvecsEntire, linvals] = filter_eigpairs(minfreq, maxfreq, diag(di), vi);

A = full(matrix_read(sprintf('data/matrixfull%d', matrixnum)));
format long

[empresidual, empvecsEntire] = id_contig(A, E, method, empvals, empvecs, win);
dotmatrix = empvecsEntire'*normalizematrix(linvecsEntire);

end
