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
obj.dynamic_data = addNoise(obj.dynamic_data, 'gaussianConstant', noise);

% Smooth Data
%obj.dynamic_data = smoothData(obj.dynamic_data, 2, 1/30, 'gaussfilter');

% Use n4sid
noiseparam = (noise > 0);
[empvecs, empvals, errors]  = runN4SID(obj, modelorder, noiseparam);
mode = 'freq';
[empvecs, empvals] = filter_eigpairs(minfreq, maxfreq, empvals, empvecs, mode);
mode = 'amp';
[empvecs, empvals] = filter_eigpairs(1e-8, [], empvals, empvecs, mode);
mode = 'damp';
[empvecs, empvals] = filter_eigpairs(.05, 20, empvals, empvecs, mode);


% Weights for fitting
%weightsFit = -(log10(errors) + 1);
weightsFit = ones(size(errors));

% Fill weightsScore with amplitudes
weightsScore = zeros(length(empvals), 1);
for i = 1:length(empvals)
    weightsScore(i) = norm(empvecs(:,i));
end
weightsScore = weightsScore/norm(weightsScore);
if numevals == 0
    numevals = sum(weightsScore > .1);
end

% Sort empvecs, empvals properly
[weightsScore, idx] = sort(weightsScore, 'descend');
empvecs = empvecs(:, idx);
empvals = empvals(idx);


% Normalize eigenvectors
empvecs = normalizematrix(empvecs);

% Get contig eval order
if strcmp(evaluation_method, 'filtered');
    evalorder = calcEvalOrder(obj);
else
    evalorder = 1:numcontigs;
end

%allocate outputs
eigenfits = zeros(1, numcontigs);
scores = zeros(1, numcontigs);
min = inf;
histWeighted = zeros(numcontigs, numevals);
histUnweighted = zeros(numcontigs, numevals);

for k = 1:numcontigs
    % Read in matrix
    contig = evalorder(k);
    [A,E] = obj.retrieveModel(contig);
    format long
    
    %No Filtering
    switch evaluation_method
        case 'all'
            
            % Run fitting via assessContig
            [fittedRes, ~] = assessContig(A, E, fitting_method, empvals, empvecs, PMU, numevals, weightsFit);
            
            % Calculate Score via Weighted Sum
            score = 0;
            for j = 1:numevals
                nfr = norm(fittedRes(:,j));
                score = score + weightsScore(j)*nfr;
                histWeighted(k,j) = nfr;
                histUnweighted(k,j) = weightsScore(j)*nfr;
            end
            scores(contig) = score;
            eigenfits(contig) = numevals;
            
            
        case 'filtered'
            % Calculate Backward Error (cutoff right now is 2*min)
            [score, numfits] = assessContigFiltered(A, E, fitting_method, empvals, empvecs, PMU, 1.1*min, weightsScore, numevals);
            if score < min
                min = score;
            end
            scores(contig) = score;
            eigenfits(contig) = numfits;
    end
end

[~, idx] = sort(scores);

% Plot graphs for report if needed
if(report)
    
    %Unweighted Bar Graph
    numbars = 20;
    x = [1, 3:(numbars+2)];
    y = [histUnweighted(obj.correctContig,:); histUnweighted(idx(1:numbars),:)];
    figure('Visible','off');
    bar(x, y, 'stacked');
    fname = 'figures/images/histUnweighted.jpeg';
    saveas(gcf, fname);
    
    %Weighted Bar Graph
    numbars = 20;
    x = [1, 3:(numbars+2)];
    y = [histWeighted(obj.correctContig,:); histWeighted(idx(1:numbars),:)];
    figure('Visible','off');
    bar(x, y, 'stacked');
    fname = 'figures/images/histWeighted.jpeg';
    saveas(gcf, fname);

end


end
