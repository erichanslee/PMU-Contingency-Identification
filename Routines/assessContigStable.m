% [fittedRes, fittedVec] = assessContig(A, E, method, empvals, empvecs, win, numevals, weights)
% ~~~~~~~~~~~~~~~~~~~~~~~~
% ~~~~~~~~~INPUTS~~~~~~~~~
% ~~~~~~~~~~~~~~~~~~~~~~~~
% method = method type number one would like to use
% A,E = generalized eigenvalue problem matrices
% empvals = empirical eigenvalues
% empvecs = empirical eigenvectors
% win = indices in which voltages can be read/inferred
% weights = weights corresponding to PMU data to put in weighted least squares
% ~~~~~~~~~~~~~~~~~~~~~~~~~
% ~~~~~~~~~OUTPUTS~~~~~~~~~
% ~~~~~~~~~~~~~~~~~~~~~~~~~
% fittedVecs = fitted eigenvectors
% fittedRes = residuals from fittedVecs

function [fittedRes, fittedVec] = assessContigStable(A, E, method, empvals, empvecs, win, numevals, weights)
load metadata.mat


% Form Discrete Algebraic Equations
%A11 = A(1:differential, 1:differential);
%A12 = A(1:differential, differential+1:differential+algebraic);
%A21 = A(differential+1:differential+algebraic, 1:differential);
%A22 = A(differential+1:differential+algebraic, differential+1:differential+algebraic);
%As = A11 - A12*(A22\A21);
%Ash = expm(As*0.05);
%Ah = [Ash, zeros(size(A12)); A21, A22];

% Solve
for j = 1:numevals
    lambda = empvals(j);
    lambdah =    exp(lambda*.05);
    Ashift = A - lambda*E;
    x1 = empvecs(:,j);
    rangerest = 1:(differential + algebraic);
    rangerest = rangerest(~ismember(rangerest, win));
    [fittedRes(j), fittedVec(:,j)] = calcResidual('FullLS', Ashift, x1, win, rangerest);
end
end
%
% ~~~~~~~~~INPUTS~~~~~~~~~
%
% method = method type number one would like to use
% Ashift = matrix in question
% x1 = subset of eigenvector
% win = indices x1 is located on
% rangerest = indices of the rest of the eigenvector
% xfull = empty vector of size length(win) + length(rangerest)
% P = permutation matrix passed in for
%
% ~~~~~~~~~OUTPUTS~~~~~~~~~
%
% residual = calculated residual
% vec = full fitted eigenvector

function [residual, vec] = calcResidual(method, Ashift, x1, win, rangerest)
load metadata.mat
switch method
    case 'simple'
        sigma = svds(Ashift',1,'smallest');
        residual = sigma;
        vec = x1;
    
    case 'backward'
        opts.tol = 1e-4;
        [T,Bshift] = balance(Ashift);
        try
            [bvs,~] = eigs(Bshift - 1e-1*eye(size(Bshift)),1,'SM', opts);
        catch
            display(rcond(Bshift - 1e-1));
            error('Problem with Conditioning of Matrix')
        end
        vs = T*bvs;
        x2 = vs(rangerest);
        ax1 = Ashift(:,win)*x1;
        ax2 = Ashift(:,rangerest)*x2;
        alpha = -(ax1'*ax2)/(ax1'*ax1);
        x = zeros(size(Ashift,1),1);
        x(win) = alpha*x1;
        x(rangerest) = x2;
        residual = norm(Ashift*x);
        vec = [x1; x2];
        
    case 'forward'
        [T,Bshift] = balance(Ashift);
        [bvs,~] = eigs(Bshift - 1e-1*eye(size(Bshift)),1,'SM');
        vs = T*bvs;
        vs_win = vs(win,:);
        vs_win = normalizematrix(vs_win);
        c = vs_win'*x1;
        residual = 1-max(abs(c));
        vec = c;

    case 'FullLS'

        %% Form Matrices
        H = zeros(length(win), differential + algebraic);
        for i = 1:length(win)
            H(i, win(i)) = 1;
        end
        alpha = 1.5; 
        % Solve Mx=b
        M = [alpha*H; Ashift ];
        b = [alpha*x1; zeros(differential + algebraic, 1)];

        vec = M\b;
        residual = norm(M*vec - b);

end
end