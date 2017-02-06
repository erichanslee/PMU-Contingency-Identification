% run_n4sid simply runs n4sid and then calculates the empirical eigenpairs
% (while also adding some noise, for testing)

% ~~~~~~~~~INPUTS~~~~~~~~~ %

% method = method type number one would like to use
% noise = percentage of max amplitude to add as gaussian noise
% modelorder = size of model to fit

% ~~~~~~~~~OUTPUTS~~~~~~~~~ %

% predcontig = the cotingency the chosen method predicts
% actualcontig = the contingency that was actually simulated
% confidence = the confidence levels for correctly identified contigs

function [empvecs, empvals] = runN4SID(obj, modelorder, noise)
[numcontigs, numbuses, filename, timestep, numlines, differential, algebraic] = getMetadata(obj);
data = obj.dynamic_data;

if noise == 0
    mode = 'none';
else
    amp = max(abs(data)) - min(abs(data));
    perturbation = randn(size(data))*noise*diag(amp, 0);
    data = data + perturbation;
    mode = 'estimate';
end

len = size(data,1);


z = iddata(data,zeros(len,1),timestep);
% set model order
opt = n4sidOptions('N4Weight', 'auto', 'Focus', 'simulation');
m = n4sid(z, modelorder,'Form','modal','DisturbanceModel',mode, opt);


%% Calculate Eigenvalue and Eigenvector Predictions from N4SID
[ mx, md] = eig(m.A);
empvals = (log(md)/timestep);
empvecs = m.C*mx;


end