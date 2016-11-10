function plot_eigvecs(linvecs, empvecs)
load metadata.mat

[len,n] = size(linvecs)
n = floor(n/2);
rangebus = (differential + numlines + 1):(differential + numlines + numlines)
linvecs = normalizematrix(linvecs);
for i = 1:n
    subplot(n,1,i), plot(rangebus, abs(empvecs(rangebus,2*i)),'-k^'); hold on;
    subplot(n,1,i), plot(1:len, abs(linvecs(:,2*i)), '-b*'); hold on;
    range = 1:(rangebus(1)); 
    subplot(n,1,i), plot(range, abs(empvecs(range,2*i)), '-ro'); hold on;
    range = (rangebus(end)):len;
    subplot(n,1,i), plot(range, abs(empvecs(range,2*i)), '-ro'); hold on;

    legend('Eigenvector Subset Observable', 'Actual', 'Fitted');
    title(sprintf('Eigenpair %d',i));
end

end



