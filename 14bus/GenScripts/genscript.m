% genscript(basename, numbuses, numcontigs)
%
% Generate a directory of basic power flow data for all contingencies.
%
% Inputs:
%     basename: Base name (no extension) of PSAT spec file
%     numbuses: Number of buses in PSAT spec
%     numcontigs: Number of contingencies to consider
%
% Output files:
%     data/matrixfull:  Full Jacobian for base problem
%     data/matrixfullN: Full Jacobian for contingency N
%     data/matrixred:   Reduced Jacobian for base problem
%     data/matrixredN:  Reduced Jacobian for contingency N
%     data/uN:          Left factor for base-contingency reduced J
%     data/vN:          Right factor for "
%
function genscript(basename, foldername, numcontigs)

  % Compute full and redued Jacobians for base case and write to file
  % DSB: Why do we trim tiny elements here and not below?
  [A, Aoriginal] = jacobian(basename);
  name = sprintf('../data/%s/matrixfull', foldername);
  matrix_write(name, A);

  for i = 1:numcontigs

    % Set up data file for contingency
    remove_line('contig.m', sprintf('%s.m', basename), i+1);

    % Compute full and reduced Jacobians and write to file
    [A, As] = jacobian('contig');
    matrix_write(sprintf('../data/%s/matrixfull%d', foldername, i), A);
    matrix_write(sprintf('../data/%s/matrixred%d', foldername, i), As);

    % Clean up data file
    delete('contig.m');

  end
end


% ------------------------------------------------------
% Remove an indicated line from file infname and write to outfname
%
function remove_line(outfname, infname, linenum)
  str = fileread(infname);
  pos = strfind(str, sprintf('\n'));
  str(pos(linenum-1)+1 : pos(linenum)) = [];
  fid = fopen(outfname, 'w');
  fprintf(fid, '%s', str);
  fclose(fid);
end


% ------------------------------------------------------
% Remove small entries from a matrix
%
function [A] = trim_tiny(A, thresh)
  if nargin < 2, thresh = 1e-10; end
  A(abs(A) < thresh) = 0;
end


% ------------------------------------------------------
% Run PSAT power flow to get full and reduced Jacobian matrices
%
function [A, Ared] = jacobian(fname)
  initpsat;
  runpsat(sprintf('GenScripts/%s.m',fname), 'data');
  runpsat('pf');
  A = [DAE.Fx DAE.Fy; DAE.Gx DAE.Gy];
  Ared = trim_tiny(DAE.Fx - DAE.Fy*(DAE.Gy\DAE.Gx));
end
