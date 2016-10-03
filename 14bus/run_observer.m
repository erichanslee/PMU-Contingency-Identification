% Constructs observer from discrete system A
% initial guess x0 and gain matrix K

% 
function dataobs = run_observer(data, M, K, x0)

[~, len] = size(data);
dataobs = zeros(size(data));
dataobs(:,1) = x0;
for i = 1:(len-1)
	xobs_old = dataobs(:,i);
	xdata_old = data(:,i);
	xnew = M*xobs_old - K*(xdata_old - xobs_old);
	dataobs(:,i+1) = xnew;
end

end