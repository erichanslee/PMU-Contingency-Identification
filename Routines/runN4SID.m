% [empvecs, empvals, error] = runN4SID(data, modelorder, noise)
% run_n4sid simply runs n4sid and then calculates the empirical eigenpairs
% (while also adding some noise, for testing)
% ~~~~~~~~~~~~~~~~~~~~~~~~
% ~~~~~~~~~INPUTS~~~~~~~~~
% ~~~~~~~~~~~~~~~~~~~~~~~~
% data = time domain signal
% modelorder = size of model to fit
% ~~~~~~~~~~~~~~~~~~~~~~~~~
% ~~~~~~~~~OUTPUTS~~~~~~~~~
% ~~~~~~~~~~~~~~~~~~~~~~~~~
% empvals = the fitted eigenvalues
% empvecs = the fitted eigenvectors
% Vector of errors along each component of signal

function [empvecs, empvals, errors] = runN4SID(data, modelorder)
load metadata.mat
mode = 'estimate';

len = size(data,1);
z = iddata(data,zeros(len,1),timestep);

% set model order
opt = n4sidOptions('N4Weight', 'auto', 'Focus', 'simulation');
[m, x0] = n4sid(z, modelorder,'Form','modal','DisturbanceModel',mode, opt);

% Calculate Eigenvalue and Eigenvector Predictions from N4SID
[ mx, md] = eig(m.A);
empvals = (log(md)/timestep);
% empvals = md;
empvecs = m.C*mx;

% Reconstruct data to get error
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


end