function testscoregap(contignum)
% Displays score gap for Contingency contignum with a single PMU on 16

% NOTE: Nice Gap, Contingency 3. Bad Gap, Contingency 10
load metadata.mat

% Run Contingency Identification Routine
PMUidx = [1, 3, 4, 16];
PMU = place_PMU(contignum, PMUidx);
[scores, ranking, vecs, res] = testinstance(contignum, PMU);


X = sort(scores);
hold on
set(gca,'xtick',[])
plot(X, 'db', 'linewidth', 1.5);
plot(X, '-b', 'linewidth', 1.5);
plot(1, X(1), 'dr', 'linewidth', 4);
ylabel('Contingency Scores')
xlabel('Contigency (Sorted)')
end

