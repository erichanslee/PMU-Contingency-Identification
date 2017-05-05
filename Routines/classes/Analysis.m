classdef (Abstract) Analysis

	properties (Abstract)
		name;
	end

	methods (Abstract)
		[scores, ranking] = calcContig(obj, objInstance);
	end

end