% ~~~~~~~~~INPUTS~~~~~~~~~ %

% win = percentage of PMUs visible
% numbuses = number of buses in network

% ~~~~~~~~~OUTPUTS~~~~~~~~~ %

% idx = index of PMU placement

function PMUidx = gen_PMUidx(win, numbuses)
	load metadata.mat

	PMUnum = round(win*numbuses);
	PMUidx = randsample(1:numbuses,PMUnum);

end