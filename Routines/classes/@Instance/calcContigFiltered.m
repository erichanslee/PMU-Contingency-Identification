%% calc_contig loads 

% ~~~~~~~~~INPUTS~~~~~~~~~ %
% method = method type number one would like to use
% data = voltage readings from PMUs
% win = indices where we see/infer voltages
% rangerest = indices of everything else
% noise = boolean value indicating presence of noise

% ~~~~~~~~~OUTPUTS~~~~~~~~~ %
% scores = scores with filtering
% eigenfits = number of eigenvectors fitted before scoring. 

function [scores, eigenfits] = calcContigFiltered(obj)


fitting_method = obj.fitting_method;
PMU = obj.PMU;
dynamic_data = obj.dynamic_data;
[numcontigs, numbuses, filename, timestep, numlines, differential, algebraic] = getMetadata(obj);

maxfreq = obj.maxfreq;
minfreq = obj.minfreq;


%use n4sid
modelorder = 60;
[empvecs, empvals]  = runN4SID(obj, modelorder);
mode = 'freq';
[empvecs, empvals] = filter_eigpairs(minfreq, maxfreq, empvals, empvecs, mode);
mode = 'amp';
[empvecs, empvals] = filter_eigpairs(1e-8, [], empvals, empvecs, mode);
mode = 'damp';
[empvecs, empvals] = filter_eigpairs(0, 20, empvals, empvecs, mode);

%fill weights with amplitudes
weights = zeros(length(empvals), 1);
for i = 1:length(empvals)
    weights(i) = norm(empvecs(:,i));
end
weights = weights/norm(weights);

%normalize eigenvectors
empvecs = normalizematrix(empvecs);

%get contig eval order
evalorder = 1:numcontigs;
%evalorder = randperm(numcontigs);
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
