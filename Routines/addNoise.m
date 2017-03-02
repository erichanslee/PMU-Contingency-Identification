% addNoise is self explanatory; it adds noise of type
% noisetype and amplitude noisemagnitude to a time-domain signal


function noisydata = addNoise(data, noisetype, noisemagnitude)

load metadata.mat
regionsize = 50;
[len, dim] = size(data);
noisydata = data;
switch noisetype
    
    %Add noise by estimating dampening factor
    case 'gaussianDamp'        
        for i = 1:dim
            % Estimate Dampening Factor
            maxstart = max(abs(data(1:regionsize, i)));
            minstart = min(abs(data(1:regionsize, i)));
            ampstart = maxstart - minstart;
            maxend = max(abs(data(end-regionsize:end, i)));
            minend = min(abs(data(end-regionsize:end, i)));
            ampend = maxend - minend;
            damp = log(ampend/ampstart)/len;            
            % Add dampened gaussian noise
            dampvec = exp((1:len)*timestep*damp);
            noisydata(:,i) = noisydata(:,i) + (ampstart*noisemagnitude*randn(1,len).*dampvec)';
        end
        
    % Add noise by dividing data up into sections and adding noise based in
    % the max amp of that section
    case 'gaussianSection'    
        intervalsize = 10;
        numintervals = floor(len/intervalsize);
        for i = 1:numintervals            
            startoffset = (i-1)*intervalsize + 1;
            endoffset = i*intervalsize;
            datainterval = data(startoffset:endoffset, :);
            amp = max(abs(datainterval)) - min(abs(datainterval));
            perturbation = randn(size(datainterval))*noisemagnitude*diag(amp, 0);
            noisydata(startoffset:endoffset, :) = noisydata(startoffset:endoffset, :) + perturbation;
        end
        
    % Represents some sort of constant noise, perhaps from sensors
    case 'gaussianConstant'
        mag = max(max(abs(data))) - min(min(abs(Data)));
        noisydata = noisemagnitude*mag*randn(size(data)).*data + data;
end

