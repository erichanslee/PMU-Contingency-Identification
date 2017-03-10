% This test checks the degregation in performance due to increasing noise
function [results, results3, results5] = testChangeInNoise(PMU, modelorder, mode, numtrials)

results = zeros(1, numtrials);
results3 = zeros(1, numtrials);
results5 = zeros(1, numtrials);

for i = 1:numtrials
    noise = .02*i;
    [result, result3, result5, ~, ~] = testsparse(PMU, noise, modelorder, mode);
    results(i) = result;
    results3(i) = result3;
    results5(i) = result5;
    try
        fid = fopen('results.txt','w');
        fprintf(fid,'Noise: %f, Result: %d, Results3: %d Results5: %d\n', noise, result, result3, result5);
    catch
    end
end

end