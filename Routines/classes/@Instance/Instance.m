% Class Instance

% ~~~PROPERTIES~~~%

% metadata = Information about System including number of buses, lines, etc
% casename = Name of Power System (e.g. "39 bus") we are running test on
% fitting_method = fitting method used to fit eigenpairs
% analysis_method = 
% evaluation_method = method used to evaluate contingency e.g. filtered or not
% numevals = number of eigenpairs to fit
% dynamic_data = PMU data
% testbank = Dictionary of Jacobian Matrices
% PMU = Indices of PMU Locations, relative to System
% minfreq = Minimum Frequency to Filter Fitted Eigenpairs by
% maxfreq = Maximum Frequency to Filter Fitten Eigenpairs by

% ~~~METHODS~~~ %

% calcContig = Eigenvector Fitting Procedure
% calcScores = 
% runN4SID = self explanatory, wrapped for MATLABS n4sid procedure

classdef Instance
    
    properties (Access = public)
        metadata
        casename
        fitting_method
        analysis_method
        evaluation_method 
        numevals
        dynamic_data
        testbank
        PMU
        minfreq
        maxfreq
        correctContig
    end
    
    methods
        [scores, eigenfits] = calcContig(test, noise, modelorder, numevals);    
        [ranking, scores] = calcScores(obj, method, vecs, residuals, weights)
        [empvals, empvecs, errors] = runN4SID(obj, modelsize, noise)

    end

end