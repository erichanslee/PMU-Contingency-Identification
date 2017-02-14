load metadata.mat

for i = 1:numcontigs
    initpsat
    filename = sprintf('contig%d.m', i);
    runpsat(filename, 'data');
    Settings.freq = 60;
    Settings.dynmit = 20; 
    Settings.fixt = 1; 
    Settings.tstep = .003; 
end