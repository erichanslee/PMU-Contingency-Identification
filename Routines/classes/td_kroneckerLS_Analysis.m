% td_kroneckerLS_Analysis stands for frequency domain least squares analysis. 
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ %
% ~~~~~~~~~~~~~ Class Properties~~~~~~~~~~~~~~~~ %
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ %
% noise = amount of noise injected


% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ %
% ~~~~~~~~~~~~~~~~~ CLASSDEF ~~~~~~~~~~~~~~~~~~~ % 
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ %

classdef td_kroneckerLS_Analysis < Analysis
	properties (Access = public)
		name = 'fd_LS_Analysis';
		noise
	end

	methods (Access = public)
		function obj = td_kroneckerLS_Analysis(noise)
			obj.noise = noise;
		end

		function [scores, ranking] = calcContig(obj, objInstance)
			[scores, ~] = calcContigInner(obj, objInstance);
			[~, ranking] = sort(scores);
		end

	end
end


% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ %
% ~~~~~~~~~~~~~~~ calcContig Def ~~~~~~~~~~~~~~~ % 
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ %

function [scores, num_eigenfits] = calcContigInner(obj, objInstance)
	% Misc. Parameters Initialized
	load metadata.mat
	PMU = objInstance.win;
	    PMU = sort(PMU, 'ascend');
	PMUdata = objInstance.PMU_data;
	alpha = 1;
	len = 100;

	% Form Matrices for Kronecker Products
	H = zeros(length(PMU), differential + algebraic);
	for i = 1:length(PMU)
	    H(i, PMU(i)) = 1;
	end
	L = diag(ones(len-1,1), 1);
	L = sparse(L);
	I = speye(len);
	I(end, end) = 0;
	b1 = MatToVec(PMUdata(1:len, :));

	for i = 1:numcontigs
	    [A,E] = objInstance.retrieveModel(i);
	    
	    % Form Discrete Algebraic Equations
	    Ad = GetDiscrete(A, differential, algebraic, timestep);
	    Ad = sparse(Ad);
	    E = sparse(E);
	    M1 = kron(speye(len), alpha*H);
	    M2 = kron(I, Ad) - kron(L, E);
	    b2 = zeros(size(M2, 1), 1);
	    b = sparse([alpha*b1; b2]);
	    Mk = [M1; M2];
	    x = Mk\b;
	    
	    % Solve LS problem and return residual
	    scores(i) = norm(Mk*x - b)/norm(b);
	    num_eigenfits(i) = 0;
	end
end

% Forms Discrete Matrix Ad from the DAE Ex' = Ax
function Ad = GetDiscrete(A, n, m, timestep)
A11 = A(1:n, 1:n);
A22 = A(n+1:n+m, n+1:n+m);
A12 = A(1:n, n+1:n+m);
A21 = A(n+1:n+m, 1:n);
As = A11 - A12*(A22\A21);
Asd = expm(As*timestep);
Ad = [Asd, zeros(size(A12)); A21, A22];
end

% Reshapes the data matrix X = [x1'; x2' ... xn'] to
% x = [x1; x2; ... xn]
function x = MatToVec(X)
len = size(X,1)*size(X,2);
x = reshape(X', [len, 1]);
end

% Reshapes the vector x = [x1; x2; ... xn] to the to
% the data matrix X = [x1'; x2' ... xn'] where xi has size ssize
function X = VecToMat(x, ssize)
dim1 = length(x)/ssize;
dim2 = ssize;
X = reshape(x, [dim2, dim1])';
end
