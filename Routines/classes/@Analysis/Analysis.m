% Abstract Class for Contingency Identification Routines
% The only things subclasses need to implement is the calcContig routine


classdef (Abstract) Analysis

	properties (Abstract)
		name;
	end

	methods (Abstract)
		% calcContig takes as input a data struct of type Instance called objInstance and returns fitting scores and rankings
		[scores, ranking] = calcContig(obj, objInstance);
	end

end