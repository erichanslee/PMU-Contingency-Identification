% ~~~~~~~~~INPUTS~~~~~~~~~ %

% method = method type number one would like to use
% A,E = generalized eigenvalue problem matrices
% empvals = empirical eigenvalues
% empvecs = empirical eigenvectors
% win = indices in which voltages can be read/inferred
% cutoff = residual in which cuttoff occurs. 
% weights = weight vector to calc residual

% ~~~~~~~~~OUTPUTS~~~~~~~~~ %
% score = contig id score
% numfits = total number of eigenvector fits. 

function [score, numfits] = assessContigFiltered(A, E, method, empvals, empvecs, win, cutoff, weights)
load metadata.mat
minfreq = 0.05;
maxfreq = .5;
score = 0;
numfits = 0;
[~, idx] = sort(weights, 'descend');

for i = 1:length(empvals)
    j = idx(i);
    
    % form variables to pass into calc_residual
    lambda = empvals(j);
    Ashift = A-lambda*E;
    xfull = zeros(differential + algebraic,1);
    x1 = empvecs(:,j);
    rangerest = 1:(differential + algebraic);
    rangerest = rangerest(~ismember(rangerest, win));
    [fittedres, ~] = calcResidual(method, Ashift, x1, win, rangerest, xfull);
    score = score + weights(j)*norm(fittedres);
    numfits = numfits + 1;
    if score > cutoff
        return;
    end
end
end

% ~~~~~~~~~INPUTS~~~~~~~~~ %

% method = method type number one would like to use
% Ashift = matrix in question
% x1 = subset of eigenvector
% win = indices x1 is located on
% rangerest = indices of the rest of the eigenvector
% xfull = empty vector of size length(win) + length(rangerest)
% P = permutation matrix passed in for

% ~~~~~~~~~OUTPUTS~~~~~~~~~ %

% residual = calculated residual
% vec = full fitted eigenvector

function [residual, vec] = calcResidual(method, Ashift, x1, win, rangerest, xfull, truevec)
load metadata.mat

method_list = {'Unconstrained', 'Constrained', 'OrthReg', 'Weighted'};
if(~(any(ismember(method_list, method))))
    disp('No Fitting Method Listed, Please Choose from the following list');
    disp(method_list);
    error('Input Error');
end

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
        [vs,ds] = svds(G',1,'smallest');
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
        D(1:length(win)) = 1; 
        
        % Weighing 
        curidx = 1 + length(win);
        D(curidx:curidx + 29) = .5;
        curidx = curidx + 29;
        D(curidx:curidx + 19) = .3;
        curidx = curidx + 19;
        D(curidx: curidx + 14) = .4;
        
        Ashift = diag(D)*Ashift*diag(1./D);
        %[~,Ashift] = balance(Ashift);
        
        % Form Gramian
        T = zeros(differential + algebraic,1+length(rangerest));
        T(1:length(win),1) = x1;
        T((length(win)+1):end,2:end) = eye(length(rangerest));
        G = Ashift*T;
        
        % Calculate smallest eigenvector and then form eigenvector
        [vs,ds] = svds(G',1,'smallest');
        xfull(1:length(win)) = vs(1)*x1;
        xfull((length(win)+1):end) = vs(2:end);
        residual = Ashift*xfull;
        vec = P'*xfull;
        
        
    case 'OrthReg'  % Orthogonal Regularization.
        
        
end

end