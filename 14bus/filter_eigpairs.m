% Takes eigenpairs given in the form (vals, vecs) and returns only
% those pairs with frequency between minfreq and maxfreq, sorted

% Note that vals should be an 1D array and not a sparse/dense matrix

function [vi, di] = filter_eigpairs(minfreq, maxfreq, vals, vecs)

% if vals is matrix then consider take diag of it
if(size(vals,1) ~= 1 && size(vals,2) ~= 1)
    vals = diag(vals);
end

rangepairs = find(abs(imag(vals)/2/pi) > minfreq & abs(imag(vals)/2/pi) < maxfreq);
vals = vals(rangepairs);
[~, idx1] = sort(abs(imag(vals)));
vals = vals(idx1);
vecs = vecs(:,rangepairs);
vecs = vecs(:,idx1);

di = vals;
vi = vecs;
end