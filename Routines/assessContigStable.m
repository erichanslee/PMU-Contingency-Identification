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

for j = 1:numevals
    lambda = empvals(j);
    Ashift = A-lambda*E;
    xfull = zeros(differential + algebraic,1);
    x1 = empvecs(:,j);
    rangerest = 1:(differential + algebraic);
    rangerest = rangerest(~ismember(rangerest, win));
    [fittedRes(j), fittedVec(:,j)] = calcResidual('forward', Ashift, x1, win, rangerest, xfull, weights);
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

function [residual, vec] = calcResidual(method, Ashift, x1, win, rangerest, xfull, weights)
load metadata.mat
switch method
    case 'backward'
        [vs,sigma] = svds(Ashift',1,'smallest');
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
        [vs,sigma] = svds(Ashift',1,'smallest');
        vs_win = vs(win);
        vs_win = normalizematrix(vs_win);
        residual = 1 - abs(x1'*vs_win);
        vec = vs_win;
end
end