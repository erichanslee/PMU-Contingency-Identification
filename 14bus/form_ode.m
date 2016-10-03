function M = form_ode(vecs, vals)

[numPMUs, numpairs] = size(vecs);
if(numPMUs == numpairs)
	M = vecs*diag(vals)*inv(vecs);
else if(numPMUs > numpairs)
	V = zeros(numPMUs);
	V(:, 1:numpairs) = vecs;
	V(:, numpairs) = ones(numPMUs,1);
	nullvecs = null(V);
	V(:,(numpairs+1):end) = nullvecs;
	d = zeros(1,numPMUs);
	d(1:numpairs) = vals;
	d((numpairs+2):end) = -20; %arbitrary dampening
	M = V*diag(d)*inv(V);
else
	1+1;
end
end