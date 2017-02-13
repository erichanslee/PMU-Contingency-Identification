% addNoise is self explanatory; it adds noise of type
% noisetype and amplitude noisemagnitude to a time-domain signal


function noisydata = addNoise(data, noisetype, noisemagnitude)
noise_list = {'gaussian', 'heavytailed'};
if(~(any(ismember(noise_list, noisetype))))
    error('Input a Correct Mode of Smoothing Please');
end

switch noisetype
    case 'gaussian'
        amp = max(abs(data)) - min(abs(data));
        perturbation = randn(size(data))*noisemagnitude*diag(amp, 0);
        noisydata = data + perturbation;
    case 'heavytailed'
end

end