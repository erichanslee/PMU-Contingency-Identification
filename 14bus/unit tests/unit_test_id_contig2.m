% Checks pole placement

clear all;
load data/14bus/metadata.mat
contignum = 1;
test = load_problem('14bus', contignum, 'OrthReg', 'Equal', 64:77);
data = test.dynamic_data;


%% Test Case: Power System 
maxfreq = .5;
minfreq = .05;
n = differential + algebraic;
method = 3;

I = eye(differential);
E = zeros(algebraic + differential);
E(1:differential,1:differential) = I;
A = full(matrix_read(sprintf('data/14bus/matrixfull%d', contignum)));
win = (differential + numlines + 1):(differential + numlines + numlines);
observer(A, E, differential, algebraic, data, .05, win)


