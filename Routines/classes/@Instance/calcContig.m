%% calc_contig (Filtered Version)

% ~~~~~~~~~INPUTS~~~~~~~~~ %
% obj = instance object
% noise = amount of noise injected
% modelorder = order of model for N4SID to fit
%

% ~~~~~~~~~OUTPUTS~~~~~~~~~ %
% scores = scores with filtering
% eigenfits = number of eigenvectors fitted before scoring.

function [scores, eigenfits] = calcContig(obj, noise, modelorder)

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ %
% ~~~~~~~~~~~~~~~~ Preprocessing ~~~~~~~~~~~~~~~~% 
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ %

load metadata.mat
PMU = obj.PMU;
maxfreq = obj.maxfreq;
minfreq = obj.minfreq;

try
    % Preload N4SID Data If Needed
    ampparam = 0.0;
    fname = sprintf('n4sidDataNoise%dContig%d.mat',noise*100,  obj.correctContig);
    load(fname);
    [empvecs, empvals] = filter_eigpairs_all(empvecs, empvals, minfreq, maxfreq, ampparam);
catch
    ampparam = 0.0;
    disp('The Amount of Error Added is not supported when fetching N4SID Data... running N4SID in real time');
    [empvecs, empvals, ~]  = runN4SID(obj.PMU_data, modelorder);
    [empvecs, empvals] = filter_eigpairs_all(empvecs, empvals, minfreq, maxfreq, ampparam)

end 

% Smooth Data
%obj.dynamic_data = smoothData(obj.dynamci_data, 2, 1/30, 'gaussfilter');


% Fill weightsScore with amplitudes
weightsScore = zeros(length(empvals), 1);
for i = 1:length(empvals)
    weightsScore(i) = norm(empvecs(:,i));
end
weightsScore = weightsScore/norm(weightsScore);
numevals = sum(weightsScore > .05);

% Sort empvecs, empvals properly
[weightsScore, idx] = sort(weightsScore, 'descend');
empvecs = empvecs(:, idx);
empvals = empvals(idx);
empvecs = normalizematrix(empvecs);

%allocate outputs
eigenfits = zeros(1, numcontigs);
scores = zeros(1, numcontigs);

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ %
% ~~~~~~~~~~~~~~~~~~ Main Loop ~~~~~~~~~~~~~~~~~~% 
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ %

for k = 1:numcontigs
    contig = k;
    [A,E] = obj.retrieveModel(contig);

    % Run fitting via assessContig
    [residuals, ~] = assessContig(A, E, empvals, empvecs, PMU, numevals);
    
    % Calculate Score via Weighted Sum
    scores(contig) = calcScore(residuals, weightsScore);
    eigenfits(contig) = numevals;
end

end

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ %
% ~~~~~~~~~~~~~~~ Helper Functions ~~~~~~~~~~~~~ % 
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ %


function [filtered_empvecs, filtered_empvals] = filter_eigpairs_all(empvecs, empvals, minfreq, maxfreq, ampparam)
    ampparam = 0.0;
    mode = 'freq';
    [empvecs, empvals] = filter_eigpairs(minfreq, maxfreq, empvals, empvecs, mode);
    mode = 'amp';
    [empvecs, empvals] = filter_eigpairs(ampparam, [], empvals, empvecs, mode);
    mode = 'damp';
    [filtered_empvecs, filtered_empvals] = filter_eigpairs(0, 20, empvals, empvecs, mode);

end


function score = calcScore(residuals, weightsScore)
    score = 0;
    for j = 1:length(residuals)
        nfr = norm(residuals(:,j));
        score = score + weightsScore(j)*nfr;
    end
end

function write_intermediate()
end