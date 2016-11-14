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

function [listvecs, listres, weights] = calcContig(obj)


fitting_method = obj.fitting_method;
PMU = obj.PMU;
dynamic_data = obj.dynamic_data;
[numcontigs, numbuses, filename, timestep, numlines, differential, algebraic] = getMetadata(obj);

maxfreq = obj.maxfreq;
minfreq = obj.minfreq;
listvecs = cell(1,numcontigs);
listres = cell(1,numcontigs);


%use n4sid
modelorder = 40;
[empvecs, empvals]  = runN4SID(obj, modelorder);
mode = 'freq';
[empvecs, empvals] = filter_eigpairs(minfreq, maxfreq, empvals, empvecs, mode);

%fill weights with amplitudes
weights = zeros(length(empvals), 1);
for i = 1:length(empvals)
    weights(i) = norm(empvecs(:,1));
end

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
