%add 10000 to 28000

U_bnd=150000; %arbitraty upper bound
L_bnd=100; %arbitrary lower bound

c = [110 210 114 53.5 143.25 155.25 136 100 33.75 22 26.625];

b = [28000+10000; 45000; 9000; 30000; 20000; 30000; 18000; 15000];

A = [2	0	0	0	1.5	1.5	2	0	0	0	0;
    3	0	0	0	0	2.5	0	0	0	0	0;
    0	1.5	0	0	0	0	0	0	0	0	0;
    0	0	0	0	2	0	0	0	0	0	1.5;
    0	0	0	0	0	0	3	0	0	1.5	0;
    0	0	0	0	0	0	0	2	0.5	0	0;
    0 0 2 0.5 0 0 0 0 0 0 0;
    0 0 1 1   0 0 0 0 0 0 0];

lb= [4200 L_bnd L_bnd L_bnd 2800 3000 L_bnd L_bnd L_bnd L_bnd L_bnd];

u = [U_bnd 4000 12000 15000 U_bnd U_bnd 5500 U_bnd U_bnd 6000 U_bnd];

options = optimoptions('linprog','Algorithm','dual-simplex');

[xsim, fvalsim, exitflag, output, lambda] = linprog(-c, A, b, [], [], lb, u, options);