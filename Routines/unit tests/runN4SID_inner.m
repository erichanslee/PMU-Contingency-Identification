
function [eigvecs, eigvals] = runN4SID_inner(data, timestep, modelorder)

% Put data into Matlab Object
len = size(data,1);
z = iddata(data,zeros(len,1),timestep);

% set model order
opt = n4sidOptions('N4Weight', 'auto', 'Focus', 'prediction');
m = n4sid(z, modelorder,'Form','modal','DisturbanceModel','estimate', opt);

% Calc eigenvecs
[ mx, md] = eig(m.A);
eigvals = (log(md)/timestep);
eigvals = diag(eigvals, 0);
eigvecs = m.C*mx;
end