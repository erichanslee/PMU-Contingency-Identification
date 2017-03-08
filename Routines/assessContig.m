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

function [fittedRes, fittedVec] = assessContig(A, E, method, empvals, empvecs, win, numevals, weights)
load metadata.mat

fittedRes = zeros(size(A, 1), numevals);
fittedVec = zeros(size(A, 1), numevals);

for j = 1:numevals
    lambda = empvals(j);
    Ashift = A-lambda*E;
    x1 = empvecs(:,j);
    rangerest = 1:(differential + algebraic);
    rangerest = rangerest(~ismember(rangerest, win));
    [fittedRes(:,j), fittedVec(:,j)] = calcResidual(method, Ashift, x1, win, rangerest, weights);
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

function [residual, vec] = calcResidual(method, Ashift, x1, win, rangerest, weights)
load metadata.mat

xfull = zeros(length(win) + length(rangerest), 1);

switch method
    case 'Unconstrained'
        % Solve an OLS problem to fill in unknown entries (min residual)
        xfull(win) = x1;
        xfull(rangerest) = (-1*Ashift(:,rangerest))\(Ashift(:,win)*xfull(win));
        
        % Compute the residual and save the norm
        residual = Ashift*xfull;
        vec = xfull;
        
    case 'Constrained'  % Constrained Fitting
        Ifull = eye(differential + algebraic);
        order = [win, rangerest];
        P = Ifull(order,:);
        Ashift = Ashift*ctranspose(P);
        
        % Form Gramian
        T = zeros(differential + algebraic,1+length(rangerest));
        T(1:length(win),1) = x1;
        T((length(win)+1):end,2:end) = eye(length(rangerest));
        G = Ashift*T;
        
        % Calculate smallest eigenvector and then form eigenvector
        [vs,~] = svds(G',1,'smallest');
        xfull(1:length(win)) = vs(1)*x1;
        xfull((length(win)+1):end) = vs(2:end);
        residual = Ashift*xfull;
        vec = P'*xfull;
        
    case 'Weighted'  % Constrained Fitting
        
        D = ones(1, length(Ashift));
        Ifull = eye(differential + algebraic);
        order = [win, rangerest];
        P = Ifull(order,:);
        Ashift = Ashift*ctranspose(P);
        D(1:length(win)) = weights;
        
        % Set specific weights based on unit
        %(UNNECESSARY FOR NOW: DATA ALREADY ALL IN PER UNIT FORM)
        
        Ashift = diag(D)*Ashift*diag(1./D);
        %[~,Ashift] = balance(Ashift);
        
        % Form Gramian
        T = zeros(differential + algebraic,1+length(rangerest));
        T(1:length(win),1) = x1;
        T((length(win)+1):end,2:end) = eye(length(rangerest));
        G = Ashift*T;
        
        % Calculate smallest eigenvector and then form eigenvector
        [vs,~] = svds(G',1,'smallest');
        xfull(1:length(win)) = vs(1)*x1;
        xfull((length(win)+1):end) = vs(2:end);
        residual = Ashift*xfull;
        vec = P'*xfull;
        
        
    case 'OrthReg'  % Orthogonal Regularization.
        
        
end

end