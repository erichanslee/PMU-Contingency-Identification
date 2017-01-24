function [scores, numfits] = testFiltering(contignum)
% Displays score gap for Contingency contignum with a single PMU on 16

% NOTE: Nice Gap, Contingency 3. Bad Gap, Contingency 10
load metadata.mat

% Run Contingency Identification Routine
PMUidx = 16;
PMU = place_PMU(contignum, PMUidx);
[scores, ranking, numfits, res] = testinstanceFiltered(contignum, PMU);
display(sum(numfits)/(max(numfits)*numcontigs));

%Generate Plot
hold on
[X, idx] = sort(scores);
offset = X(1);
Y = numfits(idx);
plot(X, '-ob');
plot(1:numcontigs, 1.01*X(1)*ones(1, numcontigs), '-r', 'LineWidth', 2);
text(floor(numcontigs/2), X(1) + offset, 'True Cutoff Line', 'FontSize', 12);

% hold on
% set(gca,'xtick',[])
% Y = numfits;
% X = scores;
% offset = min(X)*.2;
% plot(X, '-ob');

% Add Labeling
for i = 1:numcontigs
   y = X(i) + offset;
   txt = num2str(Y(i));
   text(i, y, txt, 'FontSize', 12);
end
ylabel('Likelihood Score')
xlabel('Contingency (Sorted)')

% Save Figure
set(gca,'xtick',[]);
%set(gca,'fontsize', 12);
fig = gcf;
fig.PaperUnits = 'inches';
fig.PaperPosition = [0 0 10 5];
print('FigFiltering', '-dpng');

end
