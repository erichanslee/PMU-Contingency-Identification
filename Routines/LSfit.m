function out = LSfit(empvals, empvecs, instance)

signal = instance.dynamic_data;
signal = signal';
tstep = .05;
tsteps = size(signal, 2);
len = size(signal, 1);
S = reshape(signal, [], 1);
nummodes = length(empvals);
A = zeros(nummodes, length(S));
for i = 1:tsteps
    for j = 1:nummodes
        A(i*len:i*(len+1), j) = exp(empvals(j)*tstep*i)*empvecs(j);
    end
end

c = A\S;
res = A*c - S;