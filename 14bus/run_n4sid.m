% run_n4sid simply runs n4sid and then calculates the empirical eigenpairs

% ~~~~~~~~~INPUTS~~~~~~~~~ %

% method = method type number one would like to use
% noise = percentage of max amplitude to add as gaussian noise
% window = percentage of PMUs visible

% ~~~~~~~~~OUTPUTS~~~~~~~~~ %

% predcontig = the cotingency the chosen method predicts
% actualcontig = the contingency that was actually simulated
% confidence = the confidence levels for correctly identified contigs

function [empvals, empvecs] = run_n4sid(data, timestep, n, maxfreq, minfreq)

[len,num] = size(data);
range = max(max(data)) - min(min(data));

z = iddata(data,zeros(len,1),timestep);
% set model order
modelorder = n*2 + 4;
m = n4sid(z, modelorder,'Form','modal','DisturbanceModel','none');


%% Calculate Eigenvalue and Eigenvector Predictions from N4SID
[ mx, ~] = eig(m.A);
empvals = (log(eig(m.A))/timestep);
rangeactual = find(abs(imag(empvals)/2/pi) > minfreq & abs(imag(empvals)/2/pi) < maxfreq);
empvals = empvals(rangeactual);
[~, idx2] = sort(abs(imag(empvals)));
empvecs = m.C*mx;
empvecs = empvecs(:,rangeactual);
empvals = empvals(idx2);
empvecs = empvecs(:,idx2);

end