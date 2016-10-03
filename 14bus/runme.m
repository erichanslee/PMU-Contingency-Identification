% Please run the following:

Method = 3;
MatrixNum = 1; ContigNum = 1;
Noise = 0; PMUidx = 1:14;

[true_eigenvecs, fitted_eigenvecs, residual_vecs, dot_product] = isolatecase(Method, ContigNum, MatrixNum, Noise, PMUidx);

% Outputs should be self-explanatory: 
% -true_eigenvecs calcualtes the generalized eigenvectors of the linearized system
% -fitted_eigenvecs are empirical eigenvectors fitted from n4sid data
% -residual_vecs are the vectors of residuals
% -dot_product is the matrix of inner products between fitted and true eigenvecs
% Note that the residual vectors are each quite small, but the dot products indicate that in fact the eigenvectors are not close to each other. 




% Then run the unit_tests.m
unit_tests
% unit_tests.m simply runs the fitting procedure on a subset of generalized eigenvectors taken from the linearized system. You should be getting some
% sort of warning, saying that we get an ill-conditioned problem. I'm not sure if this is truly a problem or not: the fitting from the empirical 
% (n4sid) side of things doesn't seem to be a problem. But it might explain why the fit is not that great in the previous problem. 