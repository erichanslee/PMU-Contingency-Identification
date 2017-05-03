% obtains an evaluation order of contingencies, default uses a
% least-squares fit
function evalorder = calcEvalOrder(obj, options)
    load metadata.mat
    fitscores = zeros(1, numcontigs);
    for i = 1:numcontigs
        fitscores(i) = LSfit(obj, i);
    end
    [~, evalorder ] = sort(fitscores); 
    
end