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

function [listvecs, listres] = calc_contig(instance)


fitting_method = instance.fitting_method;
PMU = instance.PMU;
dynamic_data = instance.dynamic_data;
differential = instance.metadata.differential;
numlines = instance.metadata.numlines;
numcontigs = instance.metadata.numcontigs;
timestep = instance.metadata.timestep;

maxfreq = instance.maxfreq;
minfreq = instance.minfreq;
listvecs = cell(1,numcontigs);
listres = cell(1,numcontigs);


%use n4sid
offset = 50;
dynamic_data = dynamic_data(offset:end, PMU - (differential + numlines));
[empvals, empvecs]  = run_n4sid(dynamic_data, timestep, numlines, maxfreq, minfreq);
empvecs = normalizematrix(empvecs);



for k = 1:numcontigs    
    % Read in matrix
    [A,E] = instance.retrieve_testbank(k);
    format long
    
    %% Calculate Backward Error
    [fittedres, fittedvecs] = id_contig(A, E, fitting_method, empvals, empvecs, PMU);
    listvecs{k} = fittedvecs;
    listres{k} = fittedres;
end


end
