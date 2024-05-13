% Absolute upper/lower production bounds
ublmt=150000;
lblmt=100;
options = optimoptions('linprog','Algorithm','dual-simplex');

% Scarf Assumptions:
% - Sale price same as that for cotton skirts ($75)
% - Production cost $25
% - Uses 0.5 yards of cashmere ($30)
% - Cannot be made with scraps from sweaters
c_scarf = [110 210 114 53.5 143.25 155.25 136 100 33.75 22 26.625 65];
b = [28000; 45000; 9000; 30000; 20000; 30000; 18000; 15000];
A = [2 0   0 0   1.5 1.5 2 0 0	 0	 0   0;
     3 0   0 0   0   2.5 0 0 0	 0	 0   0;
     0 1.5 0 0   0   0   0 0 0	 0	 0   0.5;
     0 0   0 0   2   0   0 0 0	 0	 1.5 0;
     0 0   0 0   0   0   3 0 0	 1.5 0   0;
     0 0   0 0   0   0   0 2 0.5 0	 0   0;
     0 0   2 0.5 0   0   0 0 0   0   0   0;
     0 0   1 1   0   0   0 0 0   0   0   0];
lb_scarf = [4200 lblmt lblmt lblmt 2800 3000 lblmt lblmt lblmt lblmt lblmt lblmt];
ub_scarf = [7000*2 4000  12000 15000 6000*2 5000*2 5500  ublmt ublmt 6000 ublmt ublmt];
[xvec_scarf, fval_scarf, exitflag, output, lambda] = linprog(-c_scarf, A, b, [], [], lb_scarf, ub_scarf, options);
fval_scarf=-fval_scarf;

%% Combinations

% Additional Acetate
c_comb = [110 210 114 53.5 143.25 155.25 136 100 33.75 22 26.625 65];
b = [38000; 45000; 9000; 30000; 20000; 30000; 18000; 15000];
lb_comb = [4200 lblmt lblmt lblmt 2800 3000 lblmt lblmt lblmt lblmt lblmt lblmt];
ub_comb = [7000*2 4000  12000 15000 6000*2 5000*2 5500  ublmt ublmt 6000  ublmt ublmt];
[xvec_comb, fval_comb, exitflag, output, lambda] = linprog(-c_comb, A, b, [], [], lb_comb, ub_comb, options);
fval_comb=-fval_comb;

% Additional Acetate + Wool Blazer Cost Increase
c_comb2 = [110 210 114 53.5 143.25 155.25-80 136 100 33.75 22 26.625 65];
[xvec_comb2, fval_comb2, exitflag, output, lambda] = linprog(-c_comb2, A, b, [], [], lb_comb, ub_comb, options);
fval_comb2=-fval_comb2;

% Previous + No Velvet Returns
c_comb_all = [110 210 114 53.5 143.25 155.25-80 172 100 33.75 40 26.625 65]; % remove velvet cost from velvet items
[xvec_comb_all, fval_comb_all, exitflag, output, lambda] = linprog(-c_comb_all, A, b, [], [], lb_comb, ub_comb, options);
fval_comb_all=-fval_comb_all-20000*12; % subtract cost of velvet from profit
