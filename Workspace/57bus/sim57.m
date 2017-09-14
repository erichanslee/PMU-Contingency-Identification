
load metadata.mat

E = zeros(differential + algebraic);
E(1:differential, 1:differential) = eye(differential);

for i = 1:numcontigs
    % ~~~~~~~~~~~~~~~~~~~~~~~~~~ %
    % ~~~~ Load Matrices ~~~~~~~ %
    % ~~~~~~~~~~~~~~~~~~~~~~~~~~ %
    
    fname = sprintf('matrixdata%d.mat',i);
    load(fname);
    fname = sprintf('simfull-contig%d.mat',i);
    load(fname);
    % ~~~~~~~~~~~~~~~~~~~~~~~~~~ %
    % ~~~~~~ Run ode23t ~~~~~~~~ %
    % ~~~~~~~~~~~~~~~~~~~~~~~~~~ %
    x0 = Varout.vars(1,:);


    f = @(t,x) A*x;
    tstep = 1/30;
    iteratestep = 10;
    tspan = 0:tstep/iteratestep:20;
    opts = odeset('Mass', E);
    [t,X] = ode23t(f,tspan,x0,opts);
    
    % ~~~~~~~~~~~~~~~~~~~~~~~~~~ %
    % ~~~~~ Process Data ~~~~~~~ %
    % ~~~~~~~~~~~~~~~~~~~~~~~~~~ %
    n = differential + 1;
    data = X(1:iteratestep:end, n:n+2*numbuses - 1);
    fname = sprintf('linearbusdata%d.mat',i);
    save(fname, 'data');
    
end