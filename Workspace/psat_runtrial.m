% psat_runtrial(basename, matfname)
%
% Run a time domain simulation.
%
% Inputs:
%   psatname: Name of PSAT input file
%   matfname: Output mat file name
%
function psat_runtrial(psatname, matfname, timestep)
  initpsat;
  Settings.freq = 60;     % System frequency is 60 Hz
  Settings.fixt = 1;      % Simulate with fixed time step
  Settings.tstep = timestep ; 
  runpsat(psatname, 'data');
  runpsat('td');          % Simulate 20 s by default
  save(matfname);
end
