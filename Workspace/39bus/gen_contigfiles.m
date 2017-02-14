load metadata.mat

%run initial file to generate data fields
if(exist('numbuses', 'var') && exist('numcontigs', 'var'))
    initfile = sprintf('bus%d', numbuses);
else
    error('Metadata not initalized properly, var numbuses or numcontigs missing');
end
run(initfile);


for i = 1:numcontigs
    contignum = i;
    linenum = Line.con(i, 1);
    
    % This string is appended to PSAT file to simulate line failure by
    % Opening a breaker at time 1.2 seconds
    str = sprintf('\n \n Breaker.con = [%d  %d  100  230  60  1   1.2   200   1   0];', contignum, linenum);
    filename = sprintf('contig%d.m', i);
    fid = fopen(filename, 'a');
    fprintf(fid, str);
    fclose(fid);
end