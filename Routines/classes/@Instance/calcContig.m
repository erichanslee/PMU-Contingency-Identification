%% calc_contig loads 

% ~~~~~~~~~INPUTS~~~~~~~~~ %
% method = method type number one would like to use
% data = voltage readings from PMUs
% win = indices where we see/infer voltages
% rangerest = indices of everything else
% noise = boolean value indicating presence of noise

% ~~~~~~~~~OUTPUTS~~~~~~~~~ %
% predcontig = the cotingency the chosen method predicts
% confidence = the confidence levels for correctly identified contigs

function [listvecs, listres, weights] = calcContig(obj, noise, modelorder)

load metadata.mat
fitting_method = obj.fitting_method;
PMU = obj.PMU;

maxfreq = obj.maxfreq;
minfreq = obj.minfreq;
minfreq = 0.1; %% TEMPORARY
listvecs = cell(1,numcontigs);
listres = cell(1,numcontigs);


%use n4sid
[empvecs, empvals]  = runN4SID(obj, modelorder, noise);
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



for k = 1:numcontigs    
    % Read in matrix
    [A,E] = obj.retrieveModel(k);
    format long
    
    %% Calculate Backward Error
    [fittedres, fittedvecs] = assessContig(A, E, fitting_method, empvals, empvecs, PMU);
    listvecs{k} = fittedvecs;
    listres{k} = fittedres;
end


end
