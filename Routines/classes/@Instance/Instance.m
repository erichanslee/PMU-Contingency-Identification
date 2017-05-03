% Class Instance

% ~~~PROPERTIES~~~%
%
% correctContig = index of correct contingency
% PMU_data = PMU data
% testbank = Dictionary of Jacobian Matrices
% PMU = Indices of PMU Locations, relative to System
% minfreq = Minimum Frequency to Filter Fitted Eigenpairs by
% maxfreq = Maximum Frequency to Filter Fitten Eigenpairs by

classdef Instance
    
    properties (Access = public)
        PMU_data
        testbank
        PMU
        minfreq
        maxfreq
        correctContig
    end
    


end