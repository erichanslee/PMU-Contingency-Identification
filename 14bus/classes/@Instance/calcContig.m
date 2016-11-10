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

function [listvecs, listres] = calcContig(obj)


fitting_method = obj.fitting_method;
PMU = obj.PMU;
dynamic_data = obj.dynamic_data;
[numcontigs, numbuses, filename, timestep, numlines, differential, algebraic] = getMetadata(obj);

maxfreq = obj.maxfreq;
minfreq = obj.minfreq;
listvecs = cell(1,numcontigs);
listres = cell(1,numcontigs);


%use n4sid
[empvecs, empvals]  = runN4SID(obj, length(PMU));
empvecs = normalizematrix(empvecs);
mode = 'freq';
[empvecs, empvals] = filter_eigpairs(minfreq, maxfreq, empvals, empvecs, mode);



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
