%% Loads simulation files and writes subset (only bus voltages) to data/sim*.mat

function gendata(numcontigs)

for i = 1:numcontigs
    filename = ['../data/sim14_' num2str(i) '.mat'];
    load(filename);
    rangebus = (DAE.n + Bus.n + 1):(DAE.n + Bus.n + Bus.n);
    data = Varout.vars(:,rangebus);
    filename = ['../data/busdata_' num2str(i) '.mat'];
    save(filename,'data');
end