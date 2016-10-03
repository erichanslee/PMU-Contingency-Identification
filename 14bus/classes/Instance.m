classdef Instance
    
    properties
        metadata
        casename
        fitting_method
        analysis_method
        dynamic_data
        testbank
        PMU
        minfreq
        maxfreq
    end
    
    methods
        function [A,E] = retrieve_testbank(obj,contignumber)
            temp = obj.testbank{contignumber};
            A = temp{1};
            E = temp{2};
        end
    end
end