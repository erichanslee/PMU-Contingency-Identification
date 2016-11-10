% Takes saved data from psat_runtrials() and
% extracts the minimum amount to that a PMU configuration
% would be able to see. 

function prune_datafiles()
load metadata.mat
skip = 10; % assumed that simulation discretization is .005 seconds and PMU 
           % reads occur every .05 seconds. 
for i = 1:numcontigs
    lname = sprintf('simfull-contig%d.mat', i);
    load(lname);
    n = differential + numbuses + 1; 
    data = Varout.vars(:, n:n+numbuses-1); 
    data = data(1:skip:end,:);
    sname = sprintf('busdata%d.mat', i);
    save(sname, 'data', 'timestep');
    A = [DAE.Fx DAE.Fy; DAE.Gx DAE.Gy];
    mname = sprintf('matrixdata%d.mat', i);
    save(mname, 'A');
end
    