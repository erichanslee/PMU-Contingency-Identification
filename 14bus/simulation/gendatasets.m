%%  Generates data sets via PSAT



%% Basic Pre-Run Checks
load metadata.mat
initpsat;
%% run simulation, generate data
% at 60hz with fixed timesteps of 0.05s, simulating 20 polls/second on PMU
%
Settings.freq = 60;
Settings.fixt = 1;
Settings.tstep = 0.05;

for k = 1:numcontigs
    runpsat(strcat('contig',int2str(k)),'data');
    runpsat('td');
    
    differential = DAE.n;
    algebraic = DAE.m;
    %A = dlmread('matrix1'); A = spconvert(A); A = full(A);
    rangebus = (DAE.n + Bus.n + 1):(DAE.n + Bus.n + Bus.n);
    
    %% use n4sid
    data = Varout.vars(:,rangebus);
    name = strcat('simulation/14busContig',int2str(k));
    save(name,'data');
end