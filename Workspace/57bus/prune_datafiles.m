% Takes saved data from psat_runtrials() and
% extracts the minimum amount to that a PMU configuration
% would be able to see.

load metadata.mat
offset = 0;
skip = 10; % assumed that simulation discretization is .003 seconds and PMU
% reads occur 30/s.

offsetsteps = skip*offset/timestep + 1;
for i = 1:numcontigs
    lname = sprintf('simfull-contig%d.mat', i);
    load(lname);
    n = differential + 1;
    
    data = Varout.vars(offsetsteps:skip:end, n:n+2*numbuses - 1);
    sname = sprintf('nonlinearbusdata%d.mat', i);
    save(sname, 'data', 'timestep');
    
    statedata = Varout.vars(offsetsteps:skip:end, :);
    ssname = sprintf('statedata%d.mat',i);
    save(ssname, 'statedata', 'timestep');
    
    A = [DAE.Fx DAE.Fy; DAE.Gx DAE.Gy];
    mname = sprintf('matrixdata%d.mat', i);
    save(mname, 'A');
end
