% Takes saved data from psat_runtrials() and
% extracts the minimum amount to that a PMU configuration
% would be able to see. 

% ~~~INPUTS~~~ % 
% offset (seconds) 

function prune_datafiles(offset)
load metadata.mat
skip = 10; % assumed that simulation discretization is .003 seconds and PMU 
           % reads occur 30/s. 
           
offsetsteps = skip*offset/timestep + 1;
for i = 1:numcontigs
    lname = sprintf('simfull-contig%d.mat', i);
    load(lname);
    n = differential + 1; 
    data = Varout.vars(:, n:n+2*numbuses - 1); 
    data = data(offsetsteps:skip:end, :);
    sname = sprintf('busdata%d.mat', i);
    save(sname, 'data', 'timestep');
    A = [DAE.Fx DAE.Fy; DAE.Gx DAE.Gy];
    mname = sprintf('matrixdata%d.mat', i);
    save(mname, 'A');
end
    