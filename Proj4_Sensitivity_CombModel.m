% Scarf Sensitivity!
lblmt = 100;
ublmt = inf;
addAce = 10000;
blazercost=80;
velvet = 20000;

c = [110 210 114 53.5 143.25 155.25-blazercost 136 100 33.75 22 26.625 65];
b = [28000 + addAce; 45000; 9000; 30000; velvet; 30000; 18000; 15000];
A = [2 0   0 0   1.5 1.5 2 0 0	 0	 0   0;
     3 0   0 0   0   2.5 0 0 0	 0	 0   0;
     0 1.5 0 0   0   0   0 0 0	 0	 0   0.5;
     0 0   0 0   2   0   0 0 0	 0	 1.5 0;
     0 0   0 0   0   0   3 0 0	 1.5 0   0;
     0 0   0 0   0   0   0 2 0.5 0	 0   0;
     0 0   2 0.5 0   0   0 0 0   0   0   0;
     0 0   1 1   0   0   0 0 0   0   0   0];
lb = [4200 lblmt lblmt lblmt 2800 3000 lblmt lblmt lblmt lblmt lblmt lblmt];
ub = [7000*2 4000 12000 15000 6000*2 5000*2 5500  ublmt ublmt 6000 ublmt ublmt];
[xvec, fval, exitflag, output, lambda] = linprog(-c, A, b, [], [], lb, ub, options);
fval=-fval;