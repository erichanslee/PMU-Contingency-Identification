load metadata.mat

for i = 1:numcontigs
    initpsat
    filename = sprintf('contig%d.m', i);
    runpsat(filename, 'data');
    Settings.freq = 60;
    Settings.dynmit = 200; 
    Settings.fixt = 1; 
    Settings.tstep = .005; 
end