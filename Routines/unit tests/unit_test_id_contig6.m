function unit_test_id_contig6


clear all;
load data/14bus/metadata.mat
contignum = 1;
test = load_problem('14bus', contignum, 'OrthReg', 'Equal', 64:77);
data = test.dynamic_data;
minfreq = .05; maxfreq = .5;
[empvals, empvecs] = run_n4sid(data, timestep, numlines, maxfreq, minfreq);
n = differential;
A = full(matrix_read('matrixfull'));
A11 = A(1:n, 1:n); A12 = A(1:n, (n+1):end);
A21 = A((n+1):end, 1:n); A22 = A((n+1):end, (n+1):end);
Sold = A11 - A12*(A22\A21);
[vright,d] = eig(Sold'); 
[vleft, ~] = eig(Sold);
[Y,D] = filter_eigpairs(minfreq, maxfreq, diag(d), vright);
[X,~] = filter_eigpairs(minfreq, maxfreq, diag(d), vleft);
PredVals = zeros(length(D),numcontigs);
for i = 1:numcontigs
    [A, E] = test.retrieve_testbank(i);
    A11 = A(1:n, 1:n); A12 = A(1:n, (n+1):end);
    A21 = A((n+1):end, 1:n); A22 = A((n+1):end, (n+1):end);
    Snew = A11 - A12*(A22\A21);
    K = Snew - Sold;

    for j = 1:length(D)
        PredVals(j,i) = D(j) + Y(:,j)'*K*X(:,j);
    end
end

foo = 1+1;
end

