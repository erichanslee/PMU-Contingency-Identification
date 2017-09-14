% Script Saving N4SID intermediate data to save large amounts of time when running tests for the 57 bus system
% with PMUs on buses 6, 16, and 26
% INPUT: NOISE PERCENTAGE
function n4sidRegenerateData(PMU, modelorder, contignum)

load metadata.mat

    win = place_PMU(contignum, PMU);
    load(sprintf('nonlinearbusdata%d.mat', contignum));
    
    % Offset Data
    front_offset = 50;
    back_offset = 100;
    data = data(front_offset:(end - back_offset), win - differential);
    
    %  run N4SID and filter data. 
    [empvecs, empvals, ~]  = runN4SID(data, modelorder);
    mode = 'freq';
    [empvecs, empvals] = filter_eigpairs(0.5, 100, empvals, empvecs, mode);
    mode = 'amp';
    [empvecs, empvals] = filter_eigpairs(0.00, [], empvals, empvecs, mode);
    mode = 'damp';
    [empvecs, empvals] = filter_eigpairs(0, 20, empvals, empvecs, mode);
    empvals = exp(empvals*timestep);
    
    
    % Perform Small LS Fit to estimate constants stored in array c
    [m, n] = size(empvecs);
    num_timesteps = 50;
    datavec = data(1:num_timesteps, :)';
    datavec = reshape(datavec, num_timesteps*m, 1);
    V = empvecs;
    for i = 2:num_timesteps
        cur_row = empvecs;
        for j = 1:n
            cur_row(:,j) = cur_row(:,j) * empvals(j)^(i-1);
        end
        V = [cur_row; V];
    end
    c = V\datavec;
    c = 5*ones(size(c));
    empvecs = empvecs * diag(c);
    
    re_data = sim_system(empvecs, empvals, size(data,1));
    fname = sprintf('data/57bus/reconstructedbusdata%d.mat', contignum);
    save(fname, 're_data');


end


% From scaled eigenvectors (empvecs) and discrete-time eigenvalues
% (empvals), simulate system by num_timesteps
function re_data = sim_system(empvecs, empvals, num_timesteps)
   
    % Reconstruct data after estimating constants
    re_data = sum(empvecs,2)';
    for i = 2:num_timesteps
        tempvals = power(empvals, i-1);
        temp = empvecs*diag(tempvals);
        re_data = [re_data; sum(temp,2)'];
    end
end