% addNoise is self explanatory; it adds noise of type
% noisetype and amplitude noisemagnitude to a time-domain signal


function noisydata = addNoise(data, noisetype, noisemagnitude)

load metadata.mat
regionsize = 30;
[len, dim] = size(data);
noisydata = data;
switch noisetype
    case 'gaussian'
        
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
        
    case 'heavytailed'
        
end

end

