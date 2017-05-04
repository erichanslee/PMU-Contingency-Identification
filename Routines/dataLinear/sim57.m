% Contingency 1

load metadata.mat

E = zeros(differential + algebraic);
E(1:differential, 1:differential) = eye(differential);

for i = 1:numcontigs
    % ~~~~~~~~~~~~~~~~~~~~~~~~~~ %
    % ~~~~ Load Matrices ~~~~~~~ %
    % ~~~~~~~~~~~~~~~~~~~~~~~~~~ %
    
    fname = sprintf('matrixdata%d.mat',i);
    load(fname);
    
    % ~~~~~~~~~~~~~~~~~~~~~~~~~~ %
    % ~~~~~~ Run ode23t ~~~~~~~~ %
    % ~~~~~~~~~~~~~~~~~~~~~~~~~~ %
    x0 = ones(differential + algebraic, 1);
    f = @(t,x) A*x;
    tstep = 1/30;
    iteratestep = 10;
    tspan = 0:tstep/iteratestep:20;
    opts = odeset('Mass', E);
    [t,X] = ode23t(f,tspan,x0,opts);
    
    % ~~~~~~~~~~~~~~~~~~~~~~~~~~ %
    % ~~~~~ Process Data ~~~~~~~ %
    % ~~~~~~~~~~~~~~~~~~~~~~~~~~ %
    data = X(1:iteratestep:end, :);
    fname = sprintf('LinearData%d.mat',i);
    save(fname);
    
end