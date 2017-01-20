ranking3 = 34*ones(10,1);
ranking = ranking3;
%ranking(1) = 33;
x = 1:10;
ranking = ranking/34; ranking3 = ranking3/34;
plot(x, ranking, '-bo', 'LineWidth', 2.25);
hold on
plot(x, ranking3, '-r*', 'LineWidth', 1.5);
axis([1 10 0 1.5]);
xlabel('Number of PMUs')
ylabel('Percentage of Correct Diagnosis')
AX = legend('Top 1', 'Top 3');
set(AX,'FontSize',12)