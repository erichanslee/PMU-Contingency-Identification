%% calc_contig (Filtered Version)

% ~~~~~~~~~INPUTS~~~~~~~~~ %
% obj = instance object
% noise = amount of noise injected
% modelorder = order of model for N4SID to fit

% ~~~~~~~~~OUTPUTS~~~~~~~~~ %
% scores = scores with filtering
% eigenfits = number of eigenvectors fitted before scoring. 

function [scores, eigenfits] = calcContigFiltered(obj, noise, modelorder)


fitting_method = obj.fitting_method;
PMU = obj.PMU;
[numcontigs, numbuses, filename, timestep, numlines, differential, algebraic] = getMetadata(obj);

maxfreq = obj.maxfreq;
minfreq = obj.minfreq;


% Use n4sid
[empvecs, empvals]  = runN4SID(obj, modelorder, noise);
mode = 'freq';
[empvecs, empvals] = filter_eigpairs(minfreq, maxfreq, empvals, empvecs, mode);
mode = 'amp';
[empvecs, empvals] = filter_eigpairs(1e-8, [], empvals, empvecs, mode);
mode = 'damp';
[empvecs, empvals] = filter_eigpairs(0, 20, empvals, empvecs, mode);

% Fill weights with amplitudes
weights = zeros(length(empvals), 1);
for i = 1:length(empvals)
    weights(i) = norm(empvecs(:,i));
end
weights = weights/norm(weights);

% Normalize eigenvectors
empvecs = normalizematrix(empvecs);

% Get contig eval order
evalorder = calcEvalOrder(obj);


min = inf;

%allocate vectors
eigenfits = zeros(1, numcontigs);
scores = zeros(1, numcontigs);

for k = 1:numcontigs    
    % Read in matrix
    contig = evalorder(k);
    [A,E] = obj.retrieveModel(contig);
    format long
    
    %% Calculate Backward Error (cutoff right now is 2*min)
    [score, numfits] = assessContigFiltered(A, E, fitting_method, empvals, empvecs, PMU, 1.1*min, weights);
    if score < min
        min = score;
    end
    scores(contig) = score;
    eigenfits(contig) = numfits;
end


end
