% matrix_write(fname, A, comment)
%
% Write a sparse or dense matrix to a file.
%
% Inputs:
%   fname:   Input file name
%   A:       Matrix to be output
%   comment: Optional string about matrix contents
%
function matrix_write(fname, A, comment)

  if nargin < 3, comment = 'Unlabeled matrix'; end
  [m,n] = size(A);

  fid = fopen(fname, 'w');
  fprintf(fid, '# %s\n', comment);
  fprintf(fid, '# %d %d %d\n', issparse(A), m, n);
  fclose(fid);

  if issparse(A)
    [col,row,val] = find(A);
    data_dump = [col,row,val];
    dlmwrite(fname, data_dump, '-append', 'precision', 16);
  else
    dlmwrite(fname, A, '-append', 'precision', 16);
  end

end
