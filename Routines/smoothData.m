% Function for filtering noise out of time domain signal
% ~~~INPUTS~~~ %
%   data = time domain signal, N x K, K = dim, N = # samples
%   freqCutoff = cutoff frequency
%   timestep = sampling rate of data
%   method = type of filtering procedue e.g. 'lowpass'

% ~~~OUTPUTS~~~ %
%   dataFiltered = output


function dataFiltered = smoothData(data, freqCutoff, timestep, method)
method_list = {'fft', 'gaussfilter', 'moving', 'rloess', 'rlowess'};
if(~(any(ismember(method_list, method))))
    error('Input a Correct Mode of Smoothing Please');
end

[n, k] = size(data);
for i = 1:k
    temp = data(:, i);
    switch method
        case 'fft'
            temp = fft(temp);
            temp(freqCutoff,:) = 0;
            data(:, i) = ifft(temp);
        case 'gaussfilter';
            g = gausswin(5); % <-- this value determines the width of the smoothing window
            g = g/sum(g);
            data(:,i) = conv(temp, g, 'same');
        case 'moving'
            data(:,i) = smooth(temp);
        case 'rloess'
            data(:,i) = smooth(temp, 'rloess');
        case 'rlowess'
            data(:,i) = smooth(temp, 'rlowess');
    end
end
dataFiltered = data;
end