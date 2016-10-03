function testInstance = load_problem(casename, contignum, fitting_method, analysis_method, PMU)

testInstance = Instance;

% Initialize testInstance.metadata
load(sprintf('data/%s/metadata.mat', casename));
testInstance.metadata.numcontigs = numcontigs;
testInstance.metadata.numbuses = numbuses;
testInstance.metadata.basefilename = basefilename;
testInstance.metadata.timestep = timestep;
testInstance.metadata.numlines = numlines;
testInstance.metadata.differential = differential;
testInstance.metadata.algebraic = algebraic;

% Initialize testInstance.dynamic_data
win = (differential + numlines + 1):(differential + numlines + numlines);
filename = sprintf('data/%s/busdata_%d.mat', casename, contignum);
load(filename);
offset = 50;
data = data(offset:end, win - (differential + numlines));

% Initialize rest
testInstance.casename = casename;
testInstance.dynamic_data = data;
testInstance.fitting_method = fitting_method;
testInstance.analysis_method = analysis_method;
testInstance.PMU = PMU;
testInstance.minfreq = 0.05;
testInstance.maxfreq = 0.5;

% Initialize testInstance.testbank
if(isempty(testInstance.metadata))
    error('Metadata field is empty. Please build problem instance first');
else
    if(isempty(testInstance.metadata.numcontigs))
        error('Metadata field is not initialized');
    end
end
differential = testInstance.metadata.differential;
algebraic = testInstance.metadata.algebraic;
testInstance.testbank = {};
n = testInstance.metadata.numcontigs;
for contignum = 1:n
    I = eye(differential);
    E = zeros(algebraic + differential);
    E(1:differential,1:differential) = I;
    A = full(matrix_read(sprintf('data/%s/matrixfull%d', testInstance.casename, contignum)));
    testInstance.testbank{contignum} = {A,E};
end

end