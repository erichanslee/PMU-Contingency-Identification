% A few scripts to try running. 

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ % 
% ~~~~~~~~ Sample One ~~~~~~~~ %
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ % 
% Run contingency identification on Contingency One with PMUs placed at buses 6, 16, and 26
% using the frequency domain approach with Gaussian Noise at 5 percent of signal amplitude
% in variance using nonlinear data 
addtopath();
contignum = 1;
PMU = [6 16 26];
noise = 0.05;
modelorder = 40; 
method = 'frequencydomain';
dataype = 'nonlinear';
[scores, ranking] = runInstance(method, datatype, contignum, PMU, noise, modelorder); 


% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ % 
% ~~~~~~~~ Sample Two ~~~~~~~~ %
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ % 
% Run contingency identification on Contingency One with PMUs placed at buses 6, 16, and 26
% using the time domain approach with Gaussian Noise at 5 percent of signal amplitude
% in variance using nonlinear data 
addtopath();
contignum = 1;
PMU = [6 16 26];
noise = 0.05;
modelorder = []; 
method = 'timedomain';
dataype = 'nonlinear';
[scores, ranking] = runInstance(method, datatype, contignum, PMU, noise, modelorder); 


% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ % 
% ~~~~~~~~ Sample Three ~~~~~~~~ %
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ % 
% Run contingency identification on Contingency One with PMUs placed at buses 6, 16, and 26
% using the time domain approach with Gaussian Noise at 5 percent of signal amplitude
% in variance using linear data 
addtopath();
contignum = 1;
PMU = [6 16 26];
noise = 0.05;
modelorder = []; 
method = 'timedomain';
dataype = 'linear';
[scores, ranking] = runInstance(method, datatype, contignum, PMU, noise, modelorder); 


% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ % 
% ~~~~~~~~ Sample Four ~~~~~~~~ %
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ % 
% Run contingency identification on all contingencies with PMUs placed at buses 6, 16, and 26
% using the frequency approach with Gaussian Noise at 5 percent of signal amplitude
% in variance using nonlinear data (warning, may take a while)
addtopath();
PMU = [6 16 26];
noise = 0.05;
modelorder = 40; 
numthreads = 1;
[result, result3, result5, scores, misdiagnoses] = testsparse(PMU, noise, modelorder, numthreads)