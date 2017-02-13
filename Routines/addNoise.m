% addNoise is self explanatory; it adds noise of type
% noisetype and amplitude noisemagnitude to a time-domain signal


function noisydata = addNoise(data, noisetype, noisemagnitude)
noise_list = {'gaussian', 'heavytailed'};
if(~(any(ismember(noise_list, noisetype))))
    error('Input a Correct Mode of Smoothing Please');
end

noisydata = data;

switch noisetype
    case 'gaussian'
        numintervals = 30;
        intervalsize = floor(size(data,1)/numintervals);
        for i = 1:numintervals
                    
            startoffset = (i-1)*intervalsize + 1;
            endoffset = i*intervalsize;
            datainterval = data(startoffset:endoffset, :);
            amp = max(abs(datainterval)) - min(abs(datainterval)); 
            perturbation = randn(size(datainterval))*noisemagnitude*diag(amp, 0);
            noisydata(startoffset:endoffset, :) = noisydata(startoffset:endoffset, :) + perturbation;
        end
    case 'heavytailed'
end

end