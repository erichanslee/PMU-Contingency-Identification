% ~~~~~~~~~INPUTS~~~~~~~~~ %

% method = method type number one would like to use
% A,E = generalized eigenvalue problem matrices
% empvals = empirical eigenvalues
% empvecs = empirical eigenvectors
% win = indices in which voltages can be read/inferred

% ~~~~~~~~~OUTPUTS~~~~~~~~~ %
% fittedvecs = fitted eigenvectors

function [fittedres, fittedvecs] = id_contig(A, E, method, empvals, empvecs, win)
load metadata.mat
minfreq = 0.05;
maxfreq = .5;
fittedvecs = zeros(differential + algebraic, length(empvals));
fittedres = zeros(differential + algebraic, length(empvals));

[v2,d2] = eig(A,E);
[v2_subset, ~] = filter_eigpairs(minfreq, maxfreq, diag(d2), v2);

for j = 1:length(empvals)
    
    % form variables to pass into calc_residual
    lambda = empvals(j);
    Ashift = A-lambda*E;
    xfull = zeros(differential + algebraic,1);
    x1 = empvecs(:,j);
    rangerest = 1:(differential + algebraic);
    rangerest = rangerest(~ismember(rangerest, win));
    [fittedres(:,j), fittedvecs(:,j)] = calc_residual(method, Ashift, x1, win, rangerest, xfull, v2_subset(rangerest,j));
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

function [residual, vec] = calc_residual(method, Ashift, x1, win, rangerest, xfull, truevec)
load metadata.mat

method_list = {'Unconstrained', 'Constrained', 'OrthReg', 'Weighted', 'RWeighted'};
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
        alpha = 0.8;
        
        Ifull = eye(differential + algebraic);
        order = [win, rangerest];
        P = Ifull(order,:);
        Ashift = Ashift*ctranspose(P);
        
        % Form Gramian
        T = zeros(differential + algebraic,1+length(rangerest));
        T(1:length(win),1) = x1;
        T((length(win)+1):end,2:end) = eye(length(rangerest));
        G = Ashift*T;
        G(:,1) = G(:,1)*alpha;
        G(:,2:end) = (1-alpha)*G(:, 2:end);
        
        % Calculate smallest eigenvector and then form eigenvector
        [vs,ds] = svds(G',1,'smallest');
        xfull(1:length(win)) = vs(1)*x1;
        xfull((length(win)+1):end) = vs(2:end);
        residual = Ashift*xfull;
        vec = P'*xfull;
        
    case 'RWeighted'  % Constrained Fitting
        
        
        Ifull = eye(differential + algebraic);
        order = [win, rangerest];
        P = Ifull(order,:);
        Ashift = Ashift*ctranspose(P);
        
        % Form Gramian
        T = zeros(differential + algebraic,1+length(rangerest));
        T(1:length(win),1) = x1;
        T((length(win)+1):end,2:end) = eye(length(rangerest));
        G = Ashift*T;
        n = size(G,2);
        Q = importdata('QQ.mat');
        
        % Calculate smallest eigenvector and then form eigenvector
        T = G' * diag(rand(102,1)) * G;
        %[vs,ds] = svds(G',1,'smallest');
        [vs, ds] = eigs(T, 1, 'sm');
        xfull(1:length(win)) = vs(1)*x1;
        xfull((length(win)+1):end) = vs(2:end);
        residual = Ashift*xfull;
        vec = P'*xfull;
        
    case 'OrthReg'  % Orthogonal Regularization.
        temp = rand(length(truevec));
        temp(:,1) = truevec;
        [Q,~] = qr(temp);
        Q(:,1) = 0;
        Q = [zeros(1,length(truevec));Q];
        Gamma = Q';
        alpha = 0.1;
        
        
        Ifull = eye(differential + algebraic);
        order = [win, rangerest];
        P = Ifull(order,:);
        Ashift = Ashift*ctranspose(P);
        
        % Form Gramian
        T = zeros(differential + algebraic,1+length(rangerest));
        T(1:length(win),1) = x1;
        T((length(win)+1):end,2:end) = eye(length(rangerest));
        G = [Ashift*T; alpha*Gamma];
        
        % Calculate smallest eigenvector and then form eigenvector
        [vs,ds] = svds(G',1,'smallest');
        xfull(1:length(win)) = vs(1)*x1;
        xfull((length(win)+1):end) = vs(2:end);
        residual = Ashift*xfull;
        vec = P'*xfull;
        
end

end