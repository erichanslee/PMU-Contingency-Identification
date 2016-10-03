% [A, comment] = matrix_read(fname)
%
% Read a sparse or dense matrix from a file.
%
% Inputs:
%   fname:   Input file name
%
% Outputs:
%   A:       Matrix read from file
%   comment: Optional string about matrix contents
%
function [A, comment] = matrix_read(fname)

  % Read header lines
  fid = fopen(fname, 'r');
  line_comment = fgetl(fid);
  line_params = fgetl(fid);
  fclose(fid);

  % Unpack header lines
  comment = line_comment(2:end);
  params = sscanf(line_params(2:end), '%d');
  sparseA = params(1);
  m = params(2);
  n = params(3);

  % Read data after header
  A = csvread(fname, 2);
  if sparseA
    A = sparse(A(:,1), A(:,2), A(:,3), m, n);
  end

end
