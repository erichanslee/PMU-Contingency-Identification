function L = gainmatrix(A,C)
    method = 'LQR';
    eigvals = eig(A);
    
    %% Only try to place subset of poles
    pole_subset1 = eigvals(real(eigvals) > -1);
    n = floor((length(eigvals) - length(pole_subset1))/2);
    pole_subset2 = -30*abs(randn(n,1)) + 10i*randn(n,1); 
    pole_subset3 = -20*rand(length(eigvals) - 2*length(pole_subset2) - length(pole_subset1),1) - 20;
    
    Poles = [pole_subset1; pole_subset2; conj(pole_subset2); pole_subset3];
    [U, D, V] = svd(C');
    Abar = U'*A'*U;

    switch method
        case 'Robust'
            [L, prec] = place(Abar, D, Poles);
        case 'LQR'
            temp = rand(size(A));
            Q = eye(size(A));
            R = eye(size(D,2));
            N = zeros(size(D));
            [L, S, e] = lqr(Abar, D, Q, R, N);
            
        case 'Sylvester'
            D = diag(4*eigvals);
            [~, n] = size(C');
            G = rand(size(C));
            X = sylvester(A, D, C'*G);
            L = (G/X)';
    end
    
    L = (V*L*U')';

end