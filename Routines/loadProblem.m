function Inst = loadProblem(contignum, PMU)

Inst = Instance;
load metadata.mat

% Initialize Inst.dynamic_data
filename = sprintf('busdata%d.mat',contignum);
load(filename);
front_offset = 50;
back_offset = 100;

% Initialize rest
Inst.correctContig = contignum;
Inst.PMU_data = data(front_offset:(end - back_offset), PMU - differential);
Inst.PMU = PMU;
Inst.minfreq = 0.5;
Inst.maxfreq = 30; %10 because we assume PMU sampling at 30hz and by Shannon Nyquist we should only be able to fit 15hz


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