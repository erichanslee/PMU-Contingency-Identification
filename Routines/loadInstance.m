%	function Inst = loadProblem(contignum, win)
%
% ~~~~~~~~~INPUTS~~~~~~~~~ %
% contignum = contingency number
% win = Indices of buses wins can see 
%
% ~~~~~~~~~OUTPUTS~~~~~~~~~ %
%
% Inst = problem instance 

function Inst = loadInstance(contignum, win)

Inst = Instance;
load metadata.mat

% Initialize Inst.dynamic_data
filename = sprintf('LinearData%d.mat',contignum);
load(filename);
front_offset = 50;
back_offset = 100;

% Initialize rest
Inst.correctContig = contignum;
idx = size(data,1);
Inst.PMU_data = data(front_offset:(idx - back_offset), win - differential);
Inst.win = win;
Inst.minfreq = 0.5;
Inst.maxfreq = 30; %10 because we assume win sampling at 30hz and by Shannon Nyquist we should only be able to fit 15hz


% testbank a set of models to fit over
Inst.testbank = {};
n = numcontigs;
for contignum = 1:n
    E = zeros(algebraic + differential);
    E(1:differential,1:differential) = eye(differential);
    load(sprintf('matrixdata%d.mat', contignum));
    Inst.testbank{contignum} = {A,E};
end

end