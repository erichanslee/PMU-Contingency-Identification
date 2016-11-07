function L = gainmatrix(A,C)
    method = 'LQR';
    eigvals = eig(A);
    
    %% Only try to place subset of poles
    pole_subset1 = eigvals(real(eigvals) > -1);
    n = floor((length(eigvals) - length(pole_subset1))/2);
    pole_subset2 = -30*abs(randn(n,1)) + 10i*randn(n,1); 
    pole_subset3 = -20*rand(length(eigvals) - 2*length(pole_subset2) - length(pole_subset1),1) - 20;
    
    Poles = [pole_subset1; pole_subset2; conj(pole_subset2); pole_subset3];


    switch method
        case 'Robust'
            [L, prec] = place(Abar, D, Poles);
        case 'LQR'

            Q = eye(size(A));
            R = .1*eye(size(C',2));
            N = zeros(size(C'));
            %[L, S, e] = lqr(Abar, D, Q, R, N);
            [L, S, e] = lqr(A', C', Q, R, N);
            L = L';
            
        case 'Sylvester'
            D = diag(4*eigvals);
            [~, n] = size(C');
            G = rand(size(C));
            X = sylvester(A, D, C'*G);
            L = (G/X)';
    end

end