function [results, results3, confidence] = testall()
% Runs contig identification on all contingencies

load metadata.mat

results = zeros(1,numbuses);
results3 = zeros(1,numbuses);
confidence = zeros(1,numbuses);

for i = 1:numbuses
    for j = 1:numcontigs
        contig = j;
        numberPMU = i:numbuses;
        PMU = place_PMU(contig, numberPMU);
        [scores, ranking, vecs, res] = testinstance(contig, PMU);
        if(contig ==  ranking(1)) results(i) = results(i) + 1; end
        if(ismember(contig, ranking(1:3))) results3(i) = results3(i) + 1; end
        confidence(i) = confidence(i) + abs(scores(1) - scores(4)) / scores(1);
    end
end

confidence = confidence / numcontigs;

end