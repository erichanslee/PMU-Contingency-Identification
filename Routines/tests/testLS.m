% Tests Least Squares Fitting LSfit() on all possible contingencies and
% then outputs ranking of correct contingencies
function ranking = testLS()

load metadata.mat
ranking = zeros(1,numcontigs);

for i = 1:numcontigs
    results = testLS_inner(i);
    [~, idx] = sort(results);
    ranking(i) = find(idx == i);
end
