% run_n4sid simply runs n4sid and then calculates the empirical eigenpairs
% (while also adding some noise, for testing)

% ~~~~~~~~~INPUTS~~~~~~~~~ %

% method = method type number one would like to use
% modelorder = size of model to fit
% noise = to fit noise or not (bool value)

% ~~~~~~~~~OUTPUTS~~~~~~~~~ %

% empvals = the fitted eigenvalues
% empvecs = the fitted eigenvectors

function [empvecs, empvals] = runN4SID(obj, modelorder, noise)
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

% If report variable is true (report configured in metadata.mat), print out pngs 
if(report)
    timesteps = size(data,1);
    Y = zeros(size(m.A,1), timesteps);
    for i = 1:timesteps
        Y(:,i) = m.A^(i-1)*x0;
    end
    dataFitted = (m.C*Y)';
    
    for k = 1:size(data,2);
        figure('Visible','off');
        plot(1:length(data(:,k)), data(:,k), '-b', 1:length(dataFitted(:, k)), dataFitted(:, k), '-r');
        legend('Original', 'Fitted');
        fname = sprintf('figures/PNG/fittingerror%d.png', k);
        saveas(gcf, fname);
    end
end

end