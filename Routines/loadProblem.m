function Inst = loadProblem(casename, contignum, fitting_method, analysis_method, evaluation_method, PMU)

Inst = Instance;

% Initialize Inst.metadata
load(sprintf('metadata.mat', casename));
Inst.metadata.numcontigs = numcontigs;
Inst.metadata.numbuses = numbuses;
Inst.metadata.filename = casename;
Inst.metadata.timestep = timestep;
Inst.metadata.numlines = numlines;
Inst.metadata.differential = differential;
Inst.metadata.algebraic = algebraic;

% Initialize Inst.dynamic_data
filename = sprintf('busdata%d.mat',contignum);
load(filename);
front_offset = 50;
back_offset = 100;
%data = data + .00001*abs(data).*randn(size(data));

% Initialize rest
Inst.casename = casename;
Inst.correctContig = contignum;
Inst.PMU_data = data(front_offset:(end - back_offset), PMU - differential);
Inst.Full_data = data(front_offset:(end - back_offset), :);
Inst.fitting_method = fitting_method;
Inst.analysis_method = analysis_method;
Inst.evaluation_method = evaluation_method; 
Inst.PMU = PMU;
Inst.minfreq = 0.5;
Inst.maxfreq = 30; %10 because we assume PMU sampling at 30hz and by Shannon Nyquist we should only be able to fit 15hz

% Initialize Inst.testbank
if(isempty(Inst.metadata))
    error('Metadata field is empty. Please build problem instance first');
else
    if(isempty(Inst.metadata.numcontigs))
        error('Metadata field is not initialized');
    end
end
differential = Inst.metadata.differential;
algebraic = Inst.metadata.algebraic;
Inst.testbank = {};
n = Inst.metadata.numcontigs;
for contignum = 1:n
    I = eye(differential);
    E = zeros(algebraic + differential);
    E(1:differential,1:differential) = I;
    load(sprintf('matrixdata%d.mat', contignum));
    Inst.testbank{contignum} = {A,E};
end

end