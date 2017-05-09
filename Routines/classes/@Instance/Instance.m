% Class Instance
% ~~~PROPERTIES~~~%
%
% correctContig = index of correct contingency
% PMU_data = PMU data
% testbank = Dictionary of Jacobian Matrices
% win = Indices of buses PMUs can see, relative to System Matrix (win is short for window)
% minfreq = Minimum Frequency to Filter Fitted Eigenpairs by
% maxfreq = Maximum Frequency to Filter Fitten Eigenpairs by

classdef Instance
    
    properties (Access = public)
        PMU_data
        testbank
        win
        minfreq
        maxfreq
        correctContig
    end

end