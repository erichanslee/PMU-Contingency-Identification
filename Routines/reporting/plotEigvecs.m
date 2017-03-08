function plotEigvecs(originalEigvecs, shiftedEigvecs)

% Normalize Vectors First

originalEigvecs = normalizematrix(originalEigvecs);
shiftedEigvecs = normalizematrix(shiftedEigvecs);

% Plot Angles in Bar Graph
figure('Visible','off');
comparison = shiftedEigvecs'*originalEigvecs;
for i = 1:size(comparison,2)
    x1 = abs((comparison(:,i)));
    plot(1:length(x1), sort(x1, 'descend'), '-ob');
    fname = sprintf('reporting/angleplot%d.jpeg',i);
    saveas(gcf, fname);
end
