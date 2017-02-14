% Run time-domain simulations for each contingency
%
function psat_runtrials()
load metadata.mat
tstep = 1/300;
    for k = 1:numcontigs
        psatname = sprintf('contig%d.m', k);
        matfname = sprintf('simfull-contig%d', k);
        psat_runtrial(psatname, matfname, tstep);
    end
end
