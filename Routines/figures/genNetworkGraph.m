% Generate Network Graph for Contig 1 in 39 bus System

% Run contig1.m to obtain Line information
run('contig1.m')

% Generate Adjacency Matrices for main and highlighted graphs
X1 = Line.con(:,1);
X2 = Line.con(:,2);
X3 = ones(2*length(X1),1);
Y1 = X1(1, :);
Y2 = X2(1, :);
Y3 = ones(2*length(Y1),1);
Z1 = X1(2, :);
Z2 = X2(2, :);
Z3 = ones(2*length(Z1),1);
A = sparse([X1; X2], [X2; X1], X3);
A = full(A);
B = sparse([Y1; Y2], [Y2; Y1], Y3);
B = full(B);
C = sparse([Z1; Z2], [Z2; Z1], Z3);
C = full(C);

% Bus Position Data
P = ...
[...
0.7*1.0, -3.0;
0.7*3.0, -3.0;
0.7*3.0, -5.0;
0.7*3.0, -7.0;
0.7*2.0, -9.0;
0.7*1.0, -12.0;
0.7*1.0, -11.0;
0.7*1.0, -10.0;
0.7*1.0, -8.0;
0.7*5.0, -11.0;
0.7*4.0, -10.0;
0.7*5.0, -8.0;
0.7*6.0, -9.0;
0.7*6.0, -7.0;
0.7*6.0, -6.0;
0.7*7.0, -5.0;
0.7*5.0, -4.0;
0.7*4.0, -4.0;
0.7*7.0, -10.0;
0.7*7.0, -11.0;
0.7*9.0, -6.0;
0.7*9.0, -8.0;
0.7*9.0, -12.0;
0.7*8.0, -9.0;
0.7*4.0, -2.0;
0.7*6.0, -2.0;
0.7*6.0, -3.0;
0.7*8.0, -2.0;
0.7*9.0, -2.0;
0.7*3.0, -1.0;
0.7*2.0, -13.0;  
0.7*5.0, -13.0;
0.7*8.0, -13.0;
0.7*7.0, -13.0;
0.7*9.0, -10.0;
0.7*9.0, -13.0;
0.7*4.0, -1.0;
0.7*9.0, -3.0;
0.7*1.0, -5.0 ...
];

% Plot Graph from Adjacency Matrix
hold on
axis([0 7 -14 0])
set(gca,'xtick',[])
set(gca,'ytick',[])
set(gca, 'visible', 'off') ;

% Plot Main Graph
gplot(B, P, '-r');
ChildrenBefore=get(gca,'children');
set(ChildrenBefore,'LineWidth',5)

% Plot Main Graph
gplot(A, P, '-sk');
ChildrenAfter=get(gca,'children');
NewChildren=setdiff(ChildrenAfter,ChildrenBefore);
set(intersect(findall(gcf,'type','line'),NewChildren),'LineWidth', 2.5)


