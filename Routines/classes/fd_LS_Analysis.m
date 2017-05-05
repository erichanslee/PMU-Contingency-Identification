% fd_LS_Analysis stands for frequency domain least squares analysis. 
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ %
% ~~~~~~~~~~~~~ Class Properties~~~~~~~~~~~~~~~~ %
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ %
% noise = amount of noise injected
% N4SID_modelorder = order of model for N4SID to fit


% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ %
% ~~~~~~~~~~~~~~~~~ CLASSDEF ~~~~~~~~~~~~~~~~~~~ % 
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ %

classdef fd_LS_Analysis < Analysis
	properties (Access = public)
		name = 'fd_LS_Analysis';
		N4SID_modelorder
		noise
	end

	methods (Access = public)
		function obj = fd_LS_Analysis(modelorder, noise)
			obj.N4SID_modelorder = modelorder;
			obj.noise = noise;
		end

		function [scores, ranking] = calcContig(obj, objInstance)
			[scores, ~] = calcContigInner(obj, objInstance);
			[~, ranking] = sort(scores);
		end

	end
end


% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ %
% ~~~~~~~~~~~~~~~ calcContig Def ~~~~~~~~~~~~~~~ % 
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ %

function [scores, num_eigenfits] = calcContigInner(obj, objInstance)
	load metadata.mat
	win = objInstance.win;
	maxfreq = objInstance.maxfreq;
	minfreq = objInstance.minfreq;
	modelorder = obj.N4SID_modelorder;
	ampparam = 0.0;

	try
	    % Preload N4SID Data If Needed
	    fname = sprintf('n4sidDataNoise%dContig%d.mat',obj.noise*100,  objInstance.correctContig); 
	    load(fname);
	    [empvecs, empvals] = filter_eigpairs_all(empvecs, empvals, minfreq, maxfreq, ampparam);
	catch
	    disp('The Amount of Error Added is not supported when fetching N4SID Data... running N4SID in real time');
	    [empvecs, empvals, ~]  = runN4SID(objInstance.PMU_data, modelorder);
	    [empvecs, empvals] = filter_eigpairs_all(empvecs, empvals, minfreq, maxfreq, ampparam);

	end 

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
	num_eigenfits = zeros(1, numcontigs);
	scores = zeros(1, numcontigs);

	for k = 1:numcontigs
	    [A,E] = objInstance.retrieveModel(k);

	    % Run fitting via assessContig
	    [residuals, ~] = assessContig(A, E, empvals, empvecs, win, numevals);
	    
	    % Calculate Score via Weighted Sum
	    scores(k) = calcScore(residuals, weightsScore);
	    num_eigenfits(k) = numevals;
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
