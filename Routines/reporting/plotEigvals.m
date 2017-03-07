function plotEigvals(original_Eigvals, shifted_Eigvals)

figure('Visible','off');
hold on;
% Plot Unit Circle
theta = linspace(0, 2*pi, 500);
x = cos(theta); y = sin(theta);
plot(x,y,'-k');

% Put Eigenvalues in unit circle via complex exponential
load metadata.mat
original_Eigvals = exp(timestep*original_Eigvals);
shifted_Eigvals= exp(timestep*shifted_Eigvals);


% Plot original Eigenvalues
for i = 1:length(shifted_Eigvals)
    plot(real(original_Eigvals), imag(original_Eigvals), 'ob');
end


% Plot Shifted Eigenvalues
for i = 1:length(shifted_Eigvals)
    plot(real(shifted_Eigvals), imag(shifted_Eigvals), '+r');
end

legend('Unit Circle', 'Original Eigenvalues', 'Shifted Eigenvalues');
fname = 'reporting/eigenvaluesPlot.jpeg';
saveas(gcf, fname);
hold off;