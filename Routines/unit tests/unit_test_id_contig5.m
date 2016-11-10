function unit_test_id_contig5(i)

%% Plots Gershgorin Circles and Bauer-Fike Circles

casename = '14bus';
load metadata.mat;
n = differential;

A = full(matrix_read('matrixfull'));
A11 = A(1:n, 1:n); A12 = A(1:n, (n+1):end);
A21 = A((n+1):end, 1:n); A22 = A((n+1):end, (n+1):end);
Sold = A11 - A12*(A22\A21);
for contignum = 2:4
    I = eye(differential);
    E = zeros(algebraic + differential);
    E(1:differential,1:differential) = I;
    A = full(matrix_read(sprintf('data/%s/matrixfull%d', casename, contignum)));
    A11 = A(1:n, 1:n); A12 = A(1:n, (n+1):end);
    A21 = A((n+1):end, 1:n); A22 = A((n+1):end, (n+1):end);
    Snew = A11 - A12*(A22\A21);
    PlotSpectra(Sold, Snew - Sold, i, 'b');
end
