ublmt=150000;
lblmt=100;

%% No velvet shirts
c = [110 210 114 53.5 143.25 155.25 136 100 33.75 26.625];
b = [28000; 45000; 9000; 30000; 20000; 30000; 18000; 15000];
A = [2 0   0 0   1.5 1.5 2 0 0	 0;
     3 0   0 0   0   2.5 0 0 0	 0;
     0 1.5 0 0   0   0   0 0 0	 0;
     0 0   0 0   2   0   0 0 0	 1.5;
     0 0   0 0   0   0   3 0 0	 0;
     0 0   0 0   0   0   0 2 0.5 0;
     0 0   2 0.5 0   0   0 0 0   0;
     0 0   1 1   0   0   0 0 0   0];
lb= [4200  lblmt lblmt lblmt 2800  3000  lblmt lblmt lblmt lblmt];
u = [ublmt 4000  12000 15000 ublmt ublmt 5500  ublmt ublmt ublmt];
options = optimoptions('linprog','Algorithm','dual-simplex');

[xvec_1, fval_1, exitflag, output, lambda] = linprog(-c, A, b, [], [], lb, u, options);
fval_1=-fval_1;

%% 2

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
lb= [4200  lblmt lblmt lblmt 2800  3000  lblmt lblmt lblmt lblmt lblmt];
u = [ublmt 4000  12000 15000 ublmt ublmt 5500  ublmt ublmt 6000  ublmt];
options = optimoptions('linprog','Algorithm','dual-simplex');

[xvec_2, fval_2, exitflag, output, lambda] = linprog(-c2, A, b, [], [], lb, u, options);
fval_2=-fval_2;


[intxvec_2, intfval_2, exitflag, output] = intlinprog(-c2, [1 2 3 4 5 6 7 8 9 10 11], A, b, [], [], lb, u);
intfval_2=-intfval_2;

%% 3: No returns for velvet

c3 = [110 210 114 53.5 143.25 155.25 172 100 33.75 40 26.625];
[xvec_3, fval_3, exitflag, output, lambda] = linprog(-c3, A, b, [], [], lb, u, options);
fval_3=-fval_3-20000*12;

%% 4: Blouse production costs
c4 = [110 210 114 53.5 143.25 155.25-80 136 100 33.75 22 26.625];
[xvec_4, fval_4, exitflag, output, lambda] = linprog(-c4, A, b, [], [], lb, u, options);
fval_4=-fval_4;

%% 5: More Acetate
c5 = c2;
b5 = [38000; 45000; 9000; 30000; 20000; 30000; 18000; 15000];
[xvec_5, fval_5, exitflag, output, lambda] = linprog(-c5, A, b5, [], [], lb, u, options);
fval_5=-fval_5;

%% 6: Outlet Stores

xvec_6=xvec_2;
xvec_6(4)=xvec_6(3)+xvec_6(4); %silk blouses/camisoles
xvec_6(9)=xvec_6(8)+xvec_6(9); %cotton sweaters/miniskirts

demand=[7000; 4000; 12000; 15000; 2800; 5000; 5500; 0; 0; 6000; 0];

to_outlets=xvec_6-demand;
for i=1:11
    if to_outlets(i)<0
       to_outlets(i)=0;
    end
end
lost_profits = to_outlets.*(c2'*0.4);

fval_2 - sum(lost_profits);

% 6b

c6 = [110 210 114 53.5 143.25 155.25 136 100 33.75 22 26.625 -10 30 -6 5.5 35.25 27.25 -4 18 3.75 -58 -21.375];
b = [28000; 45000; 9000; 30000; 20000; 30000; 18000; 15000];
AA = [A A];
AA(8,13)=0;
AA(8,14)=0;
lb6b = [4200 lblmt lblmt lblmt 2800 3000 lblmt lblmt lblmt lblmt lblmt     0     0     0     0     0     0     0     0     0     0     0];
ub6b = [7000 4000  12000 15000 2800 5000 5500  ublmt ublmt 6000  ublmt ublmt ublmt ublmt ublmt ublmt ublmt ublmt ublmt ublmt ublmt ublmt];
%      Original                                                        Outlet
[xvec_6b, fval_6b, exitflag, output, lambda] = linprog(-c6, AA, b, [], [], lb6b, ub6b, options);
fval_6b=-fval_6b;

%% SCARVES!!!

%Assumptions:
% - Sale price same as that for cotton skirts ($75)
% - Production cost $25
% - Uses 0.5 yards of cashmere ($30)
% - Cannot be made with scraps from sweaters
c_scarf = [110 210 114 53.5 143.25 155.25 136 100 33.75 22 26.625 65];
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
c_comb_all = [110 210 114 53.5 143.25 155.25-80 172 100 33.75 40 26.625 65];
[xvec_comb_all, fval_comb_all, exitflag, output, lambda] = linprog(-c_comb_all, A, b, [], [], lb_comb, ub_comb, options);
fval_comb_all=-fval_comb_all-20000*12;