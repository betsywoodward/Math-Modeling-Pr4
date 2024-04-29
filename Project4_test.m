%% 2
NA=150000;
c2 = [110 210 114 53.5 143.25 155.25 136 100 33.75 22 26.625];
b = [28000; 45000; 9000; 30000; 20000; 30000; 18000; 15000];
A = [2 0   0 0   1.5 1.5 2 0 0	 0	 0;
     3 0   0 0   0   2.5 0 0 0	 0	 0;
     0 1.5 0 0   0   0   0 0 0	 0	 0;
     0 0   0 0   2   0   0 0 0	 0	 1.5;
     0 0   0 0   0   0   3 0 0	 1.5 0;
     0 0   0 0   0   0   0 2 0.5 0	 0;
     0 0   2 0.5 0   0   0 0 0   0   0;
     0 0   1 1   0   0   0 0 0   0   0];
lb= [4200 0    0     0     2800 3000 0    0  0  0    0];
u = [NA	  4000 12000 15000 NA   NA   5500 NA NA 6000 NA];
options = optimoptions('linprog','Algorithm','dual-simplex');

[xvec_2, fval_2, exitflag, output, lambda] = linprog(-c2, A, b, [], [], lb, u, options);
fval_2=-fval_2;


[intxvec_2, intfval_2, exitflag, output] = intlinprog(-c2, [1 2 3 4 5 6 7 8 9 10 11], A, b, [], [], lb, u);
intfval_2=-intfval_2;

%% 3

c3 = [110 210 114 53.5 143.25 155.25 172 100 33.75 40 26.625];
[xvec_3, fval_3, exitflag, output, lambda] = linprog(-c3, A, b, [], [], lb, u, options);
fval_3=-fval_3-20000*12;

%% 4
c4 = [110 210 114 53.5 143.25 155.25-80 136 100 33.75 22 26.625];
[xvec_4, fval_4, exitflag, output, lambda] = linprog(-c4, A, b, [], [], lb, u, options);
fval_4=-fval_4;

%% 5
c5 = c2;
b5 = [38000; 45000; 9000; 30000; 20000; 30000; 18000; 15000];
[xvec_5, fval_5, exitflag, output, lambda] = linprog(-c5, A, b5, [], [], lb, u, options);
fval_5=-fval_5;

%% 6

xvec_6=xvec_2;
xvec_6(4)=xvec_6(3)+xvec_6(4); %silk blouses/camisoles
xvec_6(9)=xvec_6(8)+xvec_6(9); %cotton sweaters/miniskirts