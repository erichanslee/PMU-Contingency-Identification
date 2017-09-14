%   place_PMU simulates virtual placement of PMUs by generating
%   a set of indices called "win" in which voltages can be read
%
% ~~~~~~~~~INPUTS~~~~~~~~~ %
%
% PMUidx = bus indices where PMUs are placed (between 1 and numbuses)
% contignum = contig number for knowledge of line faliure
%
% ~~~~~~~~~OUTPUTS~~~~~~~~~ %
%
% win = indices in which voltages can be read/inferred (indexed for PSAT)

function win = place_PMU(contignum, PMUidx)

load metadata.mat

rangebusVoltage = (differential + numbuses + 1):(differential + numbuses + numbuses);
rangebusAngle = (differential + 1):(differential + numbuses);
run(sprintf('bus57.m',contignum));
Lines = Line.con(:,1:2);
Lines(contignum,:) = [];

Agg_Neighbor = [];
for i = 1:length(PMUidx)
	busnum = PMUidx(i);
	[rowidx, colidx] = find(Lines == busnum);
	neighbors = Lines(rowidx,:);
	neighbors = neighbors(:)';
	neighbors = unique(neighbors);
	Agg_Neighbor = [Agg_Neighbor, neighbors]; 
end

PMUidx = sort(unique(Agg_Neighbor));
win = [  rangebusAngle(PMUidx) rangebusVoltage(PMUidx)];
end
	