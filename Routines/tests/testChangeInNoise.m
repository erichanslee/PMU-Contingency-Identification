% This test checks the degregation in performance due to increasing noise
function [results, results3, results5] = testChangeInNoise(PMU, modelorder, mode, numtrials)

results = zeros(1, numtrials);
results3 = zeros(1, numtrials);
results5 = zeros(1, numtrials);

for i = 1:numtrials
    noise = .005*i;
    [results(i), results3(i), results5(i), ~, ~] = testsparse(PMU, noise, modelorder, mode); 
end

end