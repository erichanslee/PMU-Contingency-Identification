% Script Saving N4SID intermediate data to save large amounts of time when running tests for the 57 bus system
% with PMUs on buses 6, 16, and 26
function n4sidGenerateData(noise)

load metadata.mat
PMU = [6 16 26];
modelorder = 20;

for contignum = 1:numcontigs
	win = place_PMU(contignum, PMU);
	load(sprintf('busdata%d.mat', contignum));

	% Offset Data
	front_offset = 50;
	back_offset = 100;
	data = data(front_offset:(end - back_offset), win - differential);

	if noise == 0
		[empvecs, empvals, ~] = runN4SID(data, modelorder, 0);
	else
		data = addNoise(data, 'gaussianSection', noise);
		[empvecs, empvals, ~] = runN4SID(data, modelorder, 1);	
	end
	fname = sprintf('data/57bus/n4sidDataNoise%dContig%d.mat', noise*100 , contignum);
	save(fname, 'empvecs', 'empvals');
end

end