numtrials = 10;
results = zeros(1, numtrials);
results3 = zeros(1, numtrials);
results5 = zeros(1, numtrials);

for i = 1:numtrials
    noise = .01*i;
    [results(i), results3(i), results5(i), ~] = testsparse(noise); 
end

hold on;
plot(results);
plot(results3);
plot(results5);
legend('Top One', 'Top Three', 'Top Five');