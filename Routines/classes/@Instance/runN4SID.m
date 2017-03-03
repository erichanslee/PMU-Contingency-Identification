% [empvecs, empvals, error] = runN4SID(obj, modelorder, noise)
% run_n4sid simply runs n4sid and then calculates the empirical eigenpairs
% (while also adding some noise, for testing)
% ~~~~~~~~~~~~~~~~~~~~~~~~
% ~~~~~~~~~INPUTS~~~~~~~~~
% ~~~~~~~~~~~~~~~~~~~~~~~~
% method = method type number one would like to use
% modelorder = size of model to fit
% noise = to fit noise or not (bool value)
% ~~~~~~~~~~~~~~~~~~~~~~~~~
% ~~~~~~~~~OUTPUTS~~~~~~~~~
% ~~~~~~~~~~~~~~~~~~~~~~~~~
% empvals = the fitted eigenvalues
% empvecs = the fitted eigenvectors
% Vector of errors along each component of signal

function [empvecs, empvals, errors] = runN4SID(obj, modelorder, noise)
load metadata.mat
data = obj.dynamic_data;

if noise == 0
    mode = 'none';
elseif noise == 1
    mode = 'estimate';
else
    error('Noise must have value either 0 or 1');
end

len = size(data,1);
z = iddata(data,zeros(len,1),timestep);

% set model order
opt = n4sidOptions('N4Weight', 'auto', 'Focus', 'simulation');
[m, x0] = n4sid(z, modelorder,'Form','modal','DisturbanceModel',mode, opt);

% Calculate Eigenvalue and Eigenvector Predictions from N4SID
[ mx, md] = eig(m.A);
empvals = (log(md)/timestep);
empvecs = m.C*mx;

% Reconstruct data to get error and reporting info. 
[timesteps, dim] = size(data);
Y = zeros(size(m.A,1), timesteps);
for i = 1:timesteps
    Y(:,i) = m.A^(i-1)*x0;
end
dataFitted = (m.C*Y)';
errors = zeros(1, dim);
for i = 1:dim
   errors(i) = norm(data(:,i) - dataFitted(:,i));
end

% If report variable is true (report configured in metadata.mat), print out pngs
if(report)
    
    figure('Visible','off');
    for k = 1:dim;
        ymax = max(data(:,k)); ymin = min(data(:,k));
        xmin = 0; xmax = length(data(:,k));
        plot(1:length(data(:,k)), data(:,k), '-b', 1:length(dataFitted(:, k)), dataFitted(:, k), '-r');
        axis([xmin, xmax, ymin, ymax]);
        legend('Original', 'Fitted');
        fname = sprintf('figures/images/fittingerror%d.jpeg', k);
        saveas(gcf, fname);
    end
end

end