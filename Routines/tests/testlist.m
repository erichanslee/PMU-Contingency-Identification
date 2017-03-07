PMU = [16 1 5 20];
noise = 0; modelorder = 20; mode = 'parallel';
[result, result3, result5, scores, misdiagnoses] = testsparse(PMU, noise, modelorder, mode);

PMU = [16 1 5 20];
noise = 0.05; modelorder = 20; mode = 'parallel';
[result, result3, result5, scores, misdiagnoses] = testsparse(PMU, noise, modelorder, mode);

PMU = [6];
noise = 0; modelorder = 20; mode = 'parallel';
[result, result3, result5, scores, misdiagnoses] = testsparse(PMU, noise, modelorder, mode);

PMU = [6]; 
method = 'all'; contignum = 63; modelorder = 20; noise = 0; numevals = 0;
[scores, ranking, eigenfits, res] = contingencyReport(method, contignum, PMU, noise, modelorder, numevals, 'fullreport');

PMU = [16 1 5 20];
numtrials = 10; modelorder = 20; mode = 'parallel';
[results, results3, results5] = testChangeInNoise(PMU, modelorder, mode, numtrials);
