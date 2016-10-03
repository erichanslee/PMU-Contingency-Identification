% Simply prints vectors for comparison

% ~~~~~~~~~INPUTS~~~~~~~~~ %
% linearvecs = eigenvectors from Jacobian
% empvecs = eigenvectors from fit
% idx = column index selecting pair of vectors to compare
% pmode = if 'entire' print everything if 'PMU' print just buses

function printvecs(linearvecs, empvecs, idx, pmode)
	load metadata.mat

	%	Isolate indices if necessary
	if(strcmp(pmode,'entire'))
		lvec = linearvecs(:,idx);
		evec = empvecs(:,idx);
	elseif(strcmp(pmode,'PMU'))
		rangebus = (differential + numlines + 1):(differential + numlines + numlines);
		lvec = linearvecs(rangebus,idx);
		evec = empvecs(rangebus,idx);
	else
		disp('Incorrect mode for printing, entter either "entire" or "PMU"\n');
	end

	% print
	fprintf('				Linear vectors					 	Empirical vectors				\n');
	disp([lvec, evec]);
end