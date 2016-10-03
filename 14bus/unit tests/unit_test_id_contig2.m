% Checks correctness of id_contig.m

cd ..;
clear all;
load metadata.mat



%% Test Case: Power System 
maxfreq = .5;
minfreq = .05;
contignum = 1;
n = differential + algebraic;
method = 3;

I = eye(differential);
E = zeros(algebraic + differential);
E(1:differential,1:differential) = I;
A = full(matrix_read(sprintf('data/matrixfull%d', contignum)));
win = (differential + numlines + 1):(differential + numlines + numlines);
[v2,d2] = eig(A,E); 
[v2_subset, d2_subset] = filter_eigpairs(minfreq, maxfreq, diag(d2), v2);

% Pick out window and normalize %
v2_arg = normalizematrix(v2_subset(win,:));
[res2, vec2] = id_contig(A, E, method, d2_subset, v2_arg, win);

disp('Dot Product of Fitted and Real eigenvector:');
disp(abs(vec2'*normalizematrix(v2_subset)));

cd 'unit tests'/