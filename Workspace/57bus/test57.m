% 100.0  1961 W IEEE 57 Bus Test Case
Bus.con = [
      1      100    1.047      0.0    1    1;
      2      100    1.049  -0.1004    1    1;
      3      100     1.03  -0.1501    1    1;
      4      100    1.004  -0.1677    1    1;
      5      100    1.005  -0.1503    1    1;
      6      100    1.008  -0.1387    1    1;
      7      100    0.997  -0.1767    1    1;
      8      100    0.996  -0.1473    1    1;
      9      100    1.028  -0.1802    1    1;
     10      100    1.017 -0.09472    1    1;
     11      100    1.013  -0.1097    1    1;
     12      100        1   -0.109    1    1;
     13      100    1.014  -0.1064    1    1;
     14      100    1.012  -0.1336    1    1;
     15      100    1.015   -0.135    1    1;
     16      100    1.032   -0.108    1    1;
     17      100    1.034  -0.1274    1    1;
     18      100    1.031  -0.1435    1    1;
     19      100     1.05 -0.01785    1    1;
     20      100   0.9912 -0.03516    1    1;
     21      100    1.032 -0.06598    1    1;
     22      100     1.05  0.01166    1    1;
     23      100    1.045 0.008203    1    1;
     24      100    1.037  -0.1059    1    1;
     25      100    1.058 -0.07616    1    1;
     26      100    1.052 -0.09646    1    1;
     27      100    1.038  -0.1308    1    1;
     28      100     1.05 -0.03517    1    1;
     29      100     1.05  0.01299    1    1;
     30      100    1.048 -0.05819    1    1;
     31      100    0.982  -0.1853    1    1;
     32      100   0.9831  0.04484    1    1;
     33      100   0.9972  0.07321    1    1;
     34      100    1.012  0.05541    1    1;
     35      100    1.049  0.09826    1    1;
     36      100    1.063   0.1453    1    1;
     37      100    1.028  0.04226    1    1;
     38      100    1.027   0.1363    1    1;
     39      100     1.03  -0.1755    1    1;
     40      100   0.9912 -0.03516    1    1;
     41      100    1.032 -0.06598    1    1;
     42      100     1.05  0.01166    1    1;
     43      100    1.045 0.008203    1    1;
     44      100    1.037  -0.1059    1    1;
     45      100    1.058 -0.07616    1    1;
     46      100    1.052 -0.09646    1    1;
     47      100    1.038  -0.1308    1    1;
     48      100     1.05 -0.03517    1    1;
     49      100     1.05  0.01299    1    1;
     50      100    1.048 -0.05819    1    1;
     51      100    0.982      0.0    1    1;
     52      100   0.9831  0.04484    1    1;
     53      100   0.9972  0.07321    1    1;
     54      100    1.012  0.05541    1    1;
     55      100    1.049  0.09826    1    1;
     56      100    1.063   0.1453    1    1;
     57      100    1.028  0.04226    1    1;

]


SW.con = [ ...
     1     1000      100    0.982        0     99.9    -99.9      1.1      0.9   0.5208 1 1  1;
   ];


Line.con = [
   1    2   100   100   60   0  0  0.0035   0.0411   0.6987     0     0     0    0   0   1;
   2    3   100   100   60   0  0   0.001    0.025     0.75     0     0     0    0   0   1;
   3    4   100   100   60   0  0  0.0013   0.0151   0.2572     0     0     0    0   0   1;
   4    5   100   100   60   0  0   0.007   0.0086    0.146     0     0     0    0   0   1;
   4    6   100   100   60   0  0  0.0013   0.0213   0.2214     0     0     0    0   0   1;
   6    7   100   100   60   0  0  0.0011   0.0133   0.2138     0     0     0    0   0   1;
   6    8   100   100   60   0  0  0.0008   0.0128   0.1342     0     0     0    0   0   1;
   8    9   100   100   60   0  0  0.0008   0.0129   0.1382     0     0     0    0   0   1;
   9   10   100   100   60   0  0  0.0002   0.0026   0.0434     0     0     0    0   0   1;
   9   11   100   100   60   0  0  0.0008   0.0112   0.1476     0     0     0    0   0   1;
   9   12   100   100   60   0  0  0.0006   0.0092    0.113     0     0     0    0   0   1;
   9   13   100   100   60   0  0  0.0007   0.0082   0.1389     0     0     0    0   0   1;
  13   14   100   100   60   0  0  0.0004   0.0046    0.078     0     0     0    0   0   1;
  13   15   100   100   60   0  0  0.0023   0.0363   0.3804     0     0     0    0   0   1;
   1   15   100   100   60   0  0   0.001    0.025      1.2     0     0     0    0   0   1;
   1   16   100   100   60   0  0  0.0004   0.0043   0.0729     0     0     0    0   0   1;
   1   17   100   100   60   0  0  0.0004   0.0043   0.0729     0     0     0    0   0   1;
   3   15   100   100   60   0  0  0.0009   0.0101   0.1723     0     0     0    0   0   1;
   5    6   100   100   60   0  0  0.0018   0.0217    0.366     0     0     0    0   0   1;
   7    8   100   100   60   0  0  0.0009   0.0094    0.171     0     0     0    0   0   1;
  10   12   100   100   60   0  0  0.0007   0.0089   0.1342     0     0     0    0   0   1;
  11   13   100   100   60   0  0  0.0016   0.0195    0.304     0     0     0    0   0   1;
  12   13   100   100   60   0  0  0.0008   0.0135   0.2548     0     0     0    0   0   1;
  12   16   100   100   60   0  0  0.0003   0.0059    0.068     0     0     0    0   0   1;
  12   17   100   100   60   0  0  0.0007   0.0082   0.1319     0     0     0    0   0   1;
  14   15   100   100   60   0  0  0.0013   0.0173   0.3216     0     0     0    0   0   1;
  18   19   100   100   60   0  0  0.0008    0.014   0.2565     0     0     0    0   0   1;
  19   20   100   100   60   0  0  0.0006   0.0096   0.1846     0     0     0    0   0   1;
  21   22   100   100   60   0  0  0.0022   0.0035    0.361     0     0     0    0   0   1;
  22   23   100   100   60   0  0  0.0032   0.0323    0.513     0     0     0    0   0   1;
  23   24   100   100   60   0  0  0.0014   0.0147   0.2396     0     0     0    0   0   1;
  26   27   100   100   60   0  0  0.0043   0.0474   0.7802     0     0     0    0   0   1;
  27   28   100   100   60   0  0  0.0057   0.0625    1.029     0     0     0    0   0   1;
  28   29   100   100   60   0  0  0.0014   0.0151    0.249     0     0     0    0   0   1;
  25   30   100   100   60   0  0  0.0035   0.0411   0.6987     0     0     0    0   0   1;
  30   31   100   100   60   0  0   0.001    0.025     0.75     0     0     0    0   0   1;
  31   32   100   100   60   0  0  0.0013   0.0151   0.2572     0     0     0    0   0   1;
  32   33   100   100   60   0  0   0.007   0.0086    0.146     0     0     0    0   0   1;
  34   35   100   100   60   0  0  0.0013   0.0213   0.2214     0     0     0    0   0   1;
  35   36   100   100   60   0  0  0.0011   0.0133   0.2138     0     0     0    0   0   1;
  36   37   100   100   60   0  0  0.0008   0.0128   0.1342     0     0     0    0   0   1;
  37   38   100   100   60   0  0  0.0008   0.0129   0.1382     0     0     0    0   0   1;
  37   39   100   100   60   0  0  0.0002   0.0026   0.0434     0     0     0    0   0   1;
  36   40   100   100   60   0  0  0.0008   0.0112   0.1476     0     0     0    0   0   1;
  22   38   100   100   60   0  0  0.0006   0.0092    0.113     0     0     0    0   0   1;
  41   42   100   100   60   0  0  0.0007   0.0082   0.1389     0     0     0    0   0   1;
  38   44   100   100   60   0  0  0.0004   0.0046    0.078     0     0     0    0   0   1;
  46   47   100   100   60   0  0  0.0023   0.0363   0.3804     0     0     0    0   0   1;
  47   48   100   100   60   0  0   0.001    0.025      1.2     0     0     0    0   0   1;
  48   49   100   100   60   0  0  0.0004   0.0043   0.0729     0     0     0    0   0   1;
  49   50   100   100   60   0  0  0.0004   0.0043   0.0729     0     0     0    0   0   1;
  50   51   100   100   60   0  0  0.0009   0.0101   0.1723     0     0     0    0   0   1;
  29   52   100   100   60   0  0  0.0018   0.0217    0.366     0     0     0    0   0   1;
  52   53   100   100   60   0  0  0.0009   0.0094    0.171     0     0     0    0   0   1;
  53   54   100   100   60   0  0  0.0007   0.0089   0.1342     0     0     0    0   0   1;
  54   55   100   100   60   0  0  0.0016   0.0195    0.304     0     0     0    0   0   1;
  44   45   100   100   60   0  0  0.0008   0.0135   0.2548     0     0     0    0   0   1;
  56   41   100   100   60   0  0  0.0003   0.0059    0.068     0     0     0    0   0   1;
  56   42   100   100   60   0  0  0.0007   0.0082   0.1319     0     0     0    0   0   1;
  57   56   100   100   60   0  0  0.0013   0.0173   0.3216     0     0     0    0   0   1;
  38   49   100   100   60   0  0  0.0008    0.014   0.2565     0     0     0    0   0   1;
  38   48   100   100   60   0  0  0.0006   0.0096   0.1846        0     0     0    0   0   1;
   4   18   100   100   60   0  1       0    0.0181      0        1.025   0     0    0   0   1;
  21   20   100   100   60   0  1       0      0.02      0         1.07   0     0    0   0   1;
  24   25   100   100   60   0  1  0.0016    0.0435      0        1.006   0     0    0   0   1;
  24   26   100   100   60   0  1  0.0007    0.0138      0         1.06   0     0    0   0   1;
   7   29   100   100   60   0  1  0.0007    0.0142      0         1.07   0     0    0   0   1;
  34   32   100   100   60   0  1  0.0009     0.018      0        1.009   0     0    0   0   1;
  11   41   100   100   60   0  1       0    0.0143      0        1.025   0     0    0   0   1;
  41   43   100   100   60   0  1  0.0005    0.0272      0            1   0     0    0   0   1;
  14   46   100   100   60   0  1  0.0006    0.0232      0        1.025   0     0    0   0   1;
  15   45   100   100   60   0  1  0.0008    0.0156      0        1.025   0     0    0   0   1;
  10   51   100   100   60   0  1  0.0016    0.0435      0        1.006   0     0    0   0   1;
  13   49   100   100   60   0  1  0.0016    0.0435      0        1.006   0     0    0   0   1;
  11   43   100   100   60   0  1  0.0007    0.0138      0         1.06   0     0    0   0   1;
  40   56   100   100   60   0  1  0.0007    0.0142      0         1.07   0     0    0   0   1;
  39   57   100   100   60   0  1  0.0009     0.018      0        1.009   0     0    0   0   1;
   9   55   100   100   60   0  1       0    0.0143      0        1.025   0     0    0   0   1;
];


PV.con = [ ...
  1      1000      100     0.25    1.048        1       -1      1.1      0.9 1  1;
  2      1000      100     0.65   0.9831        1       -1      1.1      0.9 1  1;
  3      1000      100    0.632   0.9972        1       -1      1.1      0.9 1  1;
  6      1000      100    0.508    1.012        1       -1      1.1      0.9 1  1;
  8      1000      100     0.65    1.049        1       -1      1.1      0. 91  1;
  9      1000      100     0.56    1.063        1       -1      1.1      0.9 1  1;
  12     1000      100     0.54    1.028        1       -1      1.1      0.9 1  1;
   ];

PQ.con = [ ...
   1   100    100       0.0/10000000      0.0/10000000    1.1   0.9   0  1;
   2   100    100     -1.18/10000000      3.0/10000000    1.1   0.9   0  1;
   3   100    100     -5.97/10000000     41.0/10000000    1.1   0.9   0  1;
   4   100    100     -7.32/10000000      0.0/10000000    1.1   0.9   0  1;
   5   100    100     -8.52/10000000     13.0/10000000    1.1   0.9   0  1;
   6   100    100     -8.65/10000000     75.0/10000000    1.1   0.9   0  1;
   7   100    100     -7.58/10000000      0.0/10000000    1.1   0.9   0  1;
   8   100    100     -4.45/10000000    150.0/10000000    1.1   0.9   0  1;
   9   100    100     -9.56/10000000    121.0/10000000    1.1   0.9   0  1;
  10   100    100    -11.43/10000000      5.0/10000000    1.1   0.9   0  1;
  11   100    100    -10.17/10000000      0.0/10000000    1.1   0.9   0  1;
  12   100    100    -10.46/10000000    377.0/10000000    1.1   0.9   0  1;
  13   100    100     -9.79/10000000     18.0/10000000    1.1   0.9   0  1;
  14   100    100     -9.33/10000000     10.5/10000000    1.1   0.9   0  1;
  15   100    100     -7.18/10000000     22.0/10000000    1.1   0.9   0  1;
  16   100    100     -8.85/10000000     43.0/10000000    1.1   0.9   0  1;
  17   100    100     -5.39/10000000     42.0/10000000    1.1   0.9   0  1;
  18   100    100    -11.71/10000000     27.2/10000000    1.1   0.9   0  1;
  19   100    100    -13.20/10000000      3.3/10000000    1.1   0.9   0  1;
  20   100    100    -13.41/10000000      2.3/10000000    1.1   0.9   0  1;
  21   100    100    -12.89/10000000      0.0/10000000    1.1   0.9   0  1;
  22   100    100    -12.84/10000000      0.0/10000000    1.1   0.9   0  1;
  23   100    100    -12.91/10000000      6.3/10000000    1.1   0.9   0  1;
  24   100    100    -13.25/10000000      0.0/10000000    1.1   0.9   0  1;
  25   100    100    -18.13/10000000      6.3/10000000    1.1   0.9   0  1;
  26   100    100    -12.95/10000000      0.0/10000000    1.1   0.9   0  1;
  27   100    100    -11.48/10000000      9.3/10000000    1.1   0.9   0  1;
  28   100    100    -10.45/10000000      4.6/10000000    1.1   0.9   0  1;
  29   100    100     -9.75/10000000     17.0/10000000    1.1   0.9   0  1;
  30   100    100    -18.68/10000000      3.6/10000000    1.1   0.9   0  1;
  31   100    100    -19.34/10000000      5.8/10000000    1.1   0.9   0  1;
  32   100    100    -18.46/10000000      1.6/10000000    1.1   0.9   0  1;
  33   100    100    -18.50/10000000      3.8/10000000    1.1   0.9   0  1;
  34   100    100    -14.10/10000000      0.0/10000000    1.1   0.9   0  1;
  35   100    100    -13.86/10000000      6.0/10000000    1.1   0.9   0  1;
  36   100    100    -13.59/10000000      0.0/10000000    1.1   0.9   0  1;
  37   100    100    -13.41/10000000      0.0/10000000    1.1   0.9   0  1;
  38   100    100    -12.71/10000000     14.0/10000000    1.1   0.9   0  1;
  39   100    100    -13.46/10000000      0.0/10000000    1.1   0.9   0  1;
  40   100    100    -13.62/10000000      0.0/10000000    1.1   0.9   0  1;
  41   100    100    -14.05/10000000      6.3/10000000    1.1   0.9   0  1;
  42   100    100    -15.50/10000000      7.1/10000000    1.1   0.9   0  1;
  43   100    100    -11.33/10000000      2.0/10000000    1.1   0.9   0  1;
  44   100    100    -11.86/10000000     12.0/10000000    1.1   0.9   0  1;
  45   100    100     -9.25/10000000      0.0/10000000    1.1   0.9   0  1;
  46   100    100    -11.89/10000000      0.0/10000000    1.1   0.9   0  1;
  47   100    100    -12.49/10000000     29.7/10000000    1.1   0.9   0  1;
  48   100    100    -12.59/10000000      0.0/10000000    1.1   0.9   0  1;
  49   100    100    -12.92/10000000     18.0/10000000    1.1   0.9   0  1;
  50   100    100    -13.39/10000000     21.0/10000000    1.1   0.9   0  1;
  51   100    100    -12.52/10000000     18.0/10000000    1.1   0.9   0  1;
  52   100    100    -11.47/10000000      4.9/10000000    1.1   0.9   0  1;
  53   100    100    -12.23/10000000     20.0/10000000    1.1   0.9   0  1;
  54   100    100    -11.69/10000000      4.1/10000000    1.1   0.9   0  1;
  55   100    100    -10.78/10000000      6.8/10000000    1.1   0.9   0  1;
  56   100    100    -16.04/10000000      7.6/10000000    1.1   0.9   0  1;
  57   100    100    -16.56/10000000      6.7/10000000    1.1   0.9   0  1;
  ];



%Bus No. Type H[pu] Dmp     Rs    Xd      Xq      Xd'    Xq'    Tdo'    Tqo'
%**********************************************************************
mach = [
1   0  4.200  2  0  0.01  0.0069  0.0031  0.0008  10.200  1.500
2   0  3.030  2  0  0.0295  0.0282  0.00697  0.017  6.560  1.500 
3   0  3.580  2  0  0.02495  0.0237  0.00531  0.00876  5.700  1.500
6   0  2.860  2  0  0.0262  0.0258  0.00436  0.0166  5.690  1.500
8   0  2.600  2  0  0.0670  0.0620  0.0132  0.0166  5.400  0.440 
9   0  3.480  2  0  0.0254  0.0241  0.005  0.00814  7.300  0.400
12  0  2.640  2  0  0.0295  0.0292  0.0049  0.0186  5.660  1.500
];


numsyn=size(mach,1);
Syn.con=zeros(numsyn,28);
Syn.con(:,1)=mach(:,1);
Syn.con(:,2)=100*ones(numsyn,1);
Syn.con(:,3)=Bus.con(mach(:,1),2);
Syn.con(:,4)=60*ones(numsyn,1);
for i=1:numsyn
    if mach(i,10)==0
        Syn.con(i,5)=2;
    else
        Syn.con(i,5)=4;
        Syn.con(i,11)=mach(i,10);
    end
end
Syn.con(:,7)=mach(:,5);%zeros(numsyn,1);
Syn.con(:,8)=mach(:,6);
Syn.con(:,9)=mach(:,8);
Syn.con(:,13)=mach(:,7);
Syn.con(:,14)=mach(:,9);
Syn.con(:,16)=mach(:,11);
Syn.con(:,18)=2*mach(:,3);
Syn.con(:,19)=mach(:,4);
Syn.con(:,28)=ones(numsyn,1);


Bus.names = {...
      'Bus 1'; 'Bus 2'; 'Bus 3'; 'Bus 4'; 'Bus 5'; 
      'Bus 6'; 'Bus 7'; 'Bus 8'; 'Bus 9'; 'Bus 10'; 
      'Bus 11'; 'Bus 12'; 'Bus 13'; 'Bus 14'; 'Bus 15'; 
      'Bus 16'; 'Bus 17'; 'Bus 18'; 'Bus 19'; 'Bus 20'; 
      'Bus 21'; 'Bus 22'; 'Bus 23'; 'Bus 24'; 'Bus 25'; 
      'Bus 26'; 'Bus 27'; 'Bus 28'; 'Bus 29'; 'Bus 30'; 
      'Bus 31'; 'Bus 32'; 'Bus 33'; 'Bus 34'; 'Bus 35'; 
      'Bus 36'; 'Bus 37'; 'Bus 38'; 'Bus 39';
'Bus 40';
'Bus 41';
'Bus 42';
'Bus 43';
'Bus 44';
'Bus 45';
'Bus 46';
'Bus 47';
'Bus 48';
'Bus 49';
'Bus 50';
'Bus 51';
'Bus 52';
'Bus 53';
'Bus 54';
'Bus 55';
'Bus 56';
'Bus 57'
      };


Exc.con = [ ... 
  1  2  5  -5  20  0.2  0.063  0.35  1  0.314  0.001  0.0039  1.555;
  2  2  5  -5  20  0.2  0.063  0.35  1  0.314  0.001  0.0039  1.555;
  3  2  5  -5  20  0.2  0.063  0.35  1  0.314  0.001  0.0039  1.555;
  4  2  5  -5  20  0.2  0.063  0.35  1  0.314  0.001  0.0039  1.555;
  5  2  5  -5  20  0.2  0.063  0.35  1  0.314  0.001  0.0039  1.555;
  6  2  5  -5  20  0.2  0.063  0.35  1  0.314  0.001  0.0039  1.555;
  7  2  5  -5  20  0.2  0.063  0.35  1  0.314  0.001  0.0039  1.555;
 ];