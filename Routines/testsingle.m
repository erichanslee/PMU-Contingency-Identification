function [PMUresults, PMUresults3] = testsingle()
load metadata.mat
PMUresults = zeros(1, numbuses);
PMUresults3 = zeros(1, numbuses);
for i = 1:numbuses
    for contig = 1:numcontigs
        PMU = place_PMU(contig,i);
        [scores, ranking, vecs, res] = testinstance(contig, PMU);
        if(contig ==  ranking(1)) PMUresults(i) = PMUresults(i) + 1; end
        if(ismember(contig, ranking(1:3))) PMUresults3(i) = PMUresults3(i) + 1; end
    end
end