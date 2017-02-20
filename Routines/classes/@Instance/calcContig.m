%% calc_contig (Filtered Version)

% ~~~~~~~~~INPUTS~~~~~~~~~ %
% obj = instance object
% noise = amount of noise injected
% modelorder = order of model for N4SID to fit
%

% ~~~~~~~~~OUTPUTS~~~~~~~~~ %
% scores = scores with filtering
% eigenfits = number of eigenvectors fitted before scoring.

function [scores, eigenfits] = calcContig(obj, noise, modelorder, numevals)

load metadata.mat
fitting_method = obj.fitting_method;
evaluation_method = obj.evaluation_method;
PMU = obj.PMU;
maxfreq = obj.maxfreq;
minfreq = obj.minfreq;


% Add Noise
obj.dynamic_data = addNoise(obj.dynamic_data, 'gaussian', noise);

% Smooth Data
%obj.dynamic_data = smoothData(obj.dynamic_data, 2, 1/30, 'gaussfilter');

% Use n4sid
noiseparam = (noise > 0);
[empvecs, empvals]  = runN4SID(obj, modelorder, noiseparam);
mode = 'freq';
[empvecs, empvals] = filter_eigpairs(minfreq, maxfreq, empvals, empvecs, mode);
mode = 'amp';
[empvecs, empvals] = filter_eigpairs(1e-8, [], empvals, empvecs, mode);
mode = 'damp';
[empvecs, empvals] = filter_eigpairs(.05, 20, empvals, empvecs, mode);

% Fill weights with amplitudes
weights = zeros(length(empvals), 1);
for i = 1:length(empvals)
    weights(i) = norm(empvecs(:,i));
end
weights = weights/norm(weights);
if numevals == 0
    numevals = sum(weights > .1);
end
% Normalize eigenvectors
empvecs = normalizematrix(empvecs);

% Get contig eval order
if strcmp(evaluation_method, 'filtered');
    evalorder = calcEvalOrder(obj);
else
    evalorder = 1:numcontigs;
end



%allocate vectors
eigenfits = zeros(1, numcontigs);
scores = zeros(1, numcontigs);
min = inf;
for k = 1:numcontigs
    % Read in matrix
    contig = evalorder(k);
    [A,E] = obj.retrieveModel(contig);
    format long
    
    %No Filtering
    if strcmp(evaluation_method, 'all');
        [score, numfits, fittedVecs] = assessContig(A, E, fitting_method, empvals, empvecs, PMU, weights, numevals);
        save(sprintf('Results/fittedVecs%d.mat', k), 'fittedVecs');
        scores(contig) = score;
        eigenfits(contig) = numfits;
        
        % Filtering
    elseif strcmp(evaluation_method, 'filtered');
        % Calculate Backward Error (cutoff right now is 2*min)
        [score, numfits] = assessContigFiltered(A, E, fitting_method, empvals, empvecs, PMU, 1.1*min, weights, numevals);
        if score < min
            min = score;
        end
        scores(contig) = score;
        eigenfits(contig) = numfits;
    else
    end
    
    
end


end
