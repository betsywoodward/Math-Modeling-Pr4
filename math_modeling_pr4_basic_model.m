NA=150000;

c = [110 210 114 53.5 143.25 155.25 136 100 33.75 22 26.625];

b = [28000; 45000; 9000; 30000; 20000; 30000; 18000; 15000];

A = [2	0	0	0	1.5	1.5	2	0	0	0	0;
    3	0	0	0	0	2.5	0	0	0	0	0;
    0	1.5	0	0	0	0	0	0	0	0	0;
    0	0	0	0	2	0	0	0	0	0	1.5;
    0	0	0	0	0	0	3	0	0	1.5	0;
    0	0	0	0	0	0	0	2	0.5	0	0;
    0 0 2 0.5 0 0 0 0 0 0 0;
    0 0 1 1   0 0 0 0 0 0 0];

lb= [4200 0 0 0	2800 3000 0 0 0 0 0];

u = [NA	4000 12000 15000 NA NA 5500	NA NA 6000 NA];

%options = optimoptions('linprog','Algorithm','dual-simplex');

%[xsim, fvalsim, exitflag, output, lambda] = linprog(-c, A, b, [], [], lb, u, options);

[xsim, fvalsim, exitflag, output] = intlinprog(-c, [1,2,3,4,5,6,7,8,9,10,11], A, b, [], [], lb, u);