% Takes eigenpairs given in the form (vals, vecs) and returns only
% those pairs with frequency between minfreq and maxfreq, sorted

% Note that vals should be an 1D array and not a sparse/dense matrix

function [vi, di] = filter_eigpairs(minbound, maxbound, vals, vecs, mode)

% if vals is matrix instead of matrix then consider take diag of it
if(size(vals,1) ~= 1 && size(vals,2) ~= 1)
    vals = diag(vals);
end

switch mode
    
    % Filter by frequency i.e. imaginary part of eigenvalue
    case 'freq'
        rangepairs = find(abs(imag(vals)/pi) >= minbound & abs(imag(vals)/pi) <= maxbound);
        
        % Filter by dampening factor i.e. real part of eigenvalue
    case 'damp'
        rangepairs = find(abs(real(vals)) >= minbound & abs(real(vals)) <= maxbound);
        
        % Get rid of low amplitude modes i.e. norms of eigenvectors
    case 'amp'
        norms = zeros(1, length(vals));
        for i = 1:length(vals)
            norms(i) = norm(vecs(:,i));
        end
        rangepairs = find(abs(norms) >= minbound);
end

%Filter and Sort eigenpairs
vals = vals(rangepairs);
[~, idx1] = sort(abs(imag(vals)));
vals = vals(idx1);
vecs = vecs(:,rangepairs);
vecs = vecs(:,idx1);

di = vals;
vi = vecs;
end