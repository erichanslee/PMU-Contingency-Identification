function [scores, ranking, vecs, res] = unit_test_id_contig4()
scores{10} = [];
ranking{10} = [];
vecs{10} = [];
res{10} = [];

for i = 1:10
    win = 64:77;
    load(sprintf('14bus/sim14_%d.mat',i));
    data = Varout.vars;
    data = data(:,win);
    data = data(50:end,:);
    testInstance = load_problem('14bus',i, 'OrthReg', 'Equal', win);
    testInstance.dynamic_data = data;
    [scores{i}, ranking{i}, vecs{i}, res{i}] = run_problem(testInstance);
    temp = ranking{i};
    fprintf('Contig Identified: %d\n', temp(1));
end