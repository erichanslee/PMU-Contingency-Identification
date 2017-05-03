function configMetadata(reportstatus)

load metadata.mat

switch reportstatus
    
    case 'fullreport'
        report = 1;
        
    case 'none'
        report = 0;
end

save('metadata.mat', 'algebraic', 'differential', 'numcontigs', 'report', 'numbuses', 'numlines', 'timestep');
end



