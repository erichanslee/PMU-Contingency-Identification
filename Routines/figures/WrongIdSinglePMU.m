load metadata.mat

% Run Contingency Identification Routine
%PMUidx = [1, 3, 4, 16];
PMUidx = 16;
contignum = 1;
PMU = place_PMU(contignum, PMUidx);
[scores, ranking, vecs, res] = testinstance(contignum, PMU);


X = sort(scores);
hold on
set(gca,'xtick',[])
plot(X, '-ob', 'linewidth', 1.5);
plot(2, X(2), '*r', 'linewidth', 2);
ylabel('Likelihood Scores')
xlabel('Contigency (Sorted)')   

% Save Figure
set(gca,'xtick',[]);
fig = gcf;
fig.PaperUnits = 'inches';
print('WrongIdSinglePMU', '-dpng');
hold off; 
clf;