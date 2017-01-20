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
        [listvecs, listres, weights] = calcContig(obj)
        [scores, eigenfits] = calcContigFiltered(obj)
        [ranking, scores] = calcScores(obj, method, vecs, residuals, weights)
        [empvals, empvecs] = runN4SID(obj, modelsize)
        [numcontigs, numbuses, basefilename, timestep ...
        ,numlines, differential, algebraic] = getMetadata(obj)

    end

end