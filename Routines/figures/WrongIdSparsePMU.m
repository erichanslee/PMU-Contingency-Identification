load metadata.mat

% Run Contingency Identification Routine
PMUidx = [1, 3, 4, 16];
contignum = 1;
PMU = place_PMU(contignum, PMUidx);
[scores, ranking, vecs, res] = testinstance(contignum, PMU);


X = sort(scores);
hold on
set(gca,'xtick',[])
plot(X, '-ob', 'linewidth', 1.5);
plot(1, X(1), '*r', 'linewidth', 2);
ylabel('Likelihood Scores')
xlabel('Contigency (Sorted)')   

% Save Figure
set(gca,'xtick',[]);
fig = gcf;
fig.PaperUnits = 'inches';
print('WrongIdSparsePMU', '-dpng');
hold off; 
clf;