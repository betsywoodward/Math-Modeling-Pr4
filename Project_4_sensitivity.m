%% Model initialization
ublmt=150000;
lblmt=100;

sale_price = [300 450 300 120 270 320 350 205 75 200 120];
sale_price = [sale_price sale_price*0.6];
mnfctr_cst = [160 150 160 60 120 140 175 100 40 160 90];
mnfctr_cst = [mnfctr_cst mnfctr_cst];
mtrls_cost = [30 90 26 6.5 6.75 24.75 39 5 1.25 18 3.375];
mtrls_cost = [mtrls_cost mtrls_cost];

c = sale_price - mnfctr_cst - mtrls_cost;
b = [28000; 45000; 9000; 30000; 20000; 30000; 18000; 15000];
A = [2 0   0 0   1.5 1.5 2 0 0	 0	 0;
     3 0   0 0   0   2.5 0 0 0	 0	 0;
     0 1.5 0 0   0   0   0 0 0	 0	 0;
     0 0   0 0   2   0   0 0 0	 0	 1.5;
     0 0   0 0   0   0   3 0 0	 1.5 0;
     0 0   0 0   0   0   0 2 0.5 0	 0;
     0 0   2 0.5 0   0   0 0 0   0   0;
     0 0   1 1   0   0   0 0 0   0   0];
A = [A A];
A(8,13)=0;
A(8,14)=0;
lb = [4200 lblmt lblmt lblmt 2800 3000 lblmt lblmt lblmt lblmt lblmt 0 0 0 0 0 0 0 0 0 0 0];
ub = [7000 4000 12000 15000 2800 5000 5500 ublmt ublmt 6000 ublmt ublmt ublmt ublmt ublmt ublmt ublmt ublmt ublmt ublmt ublmt ublmt];
%      Original Price                                                  Outlet Sales

options = optimoptions('linprog','Algorithm','dual-simplex');
[xvec, fval, exitflag, output, lambda] = linprog(-c, AA, b, [], [], lb, ub, options);
fval=-fval;

%% Question 6 Sensitivity Analyses

% baseline price per item
c = sale_price*1.1 - mnfctr_cst - mtrls_cost;
c = sale_price*0.9 - mnfctr_cst - mtrls_cost;

% manufacturing costs
c = sale_price - mnfctr_cst*1.1 - mtrls_cost;
c = sale_price - mnfctr_cst*0.9 - mtrls_cost;

% materials cost
c = sale_price - mnfctr_cst - mtrls_cost*1.1;
c = sale_price - mnfctr_cst - mtrls_cost*0.9;

% demand levels
lb = [4200 lblmt lblmt lblmt 2800 3000 lblmt lblmt lblmt lblmt lblmt 0 0 0 0 0 0 0 0 0 0 0];
ub = [7000 4000 12000 15000 2800 5000 5500 ublmt ublmt 6000 ublmt ublmt ublmt ublmt ublmt ublmt ublmt ublmt ublmt ublmt ublmt ublmt];

lb = [4200 lblmt lblmt lblmt 2800 3000 lblmt lblmt lblmt lblmt lblmt 0 0 0 0 0 0 0 0 0 0 0];
ub = [7000 4000 12000 15000 2800 5000 5500 ublmt ublmt 6000 ublmt ublmt ublmt ublmt ublmt ublmt ublmt ublmt ublmt ublmt ublmt ublmt];


% item production lower bound
lblmt = 110;
lblmt = 90;

% original price sale upper bound
lb = [4200 lblmt lblmt lblmt 2800 3000 lblmt lblmt lblmt lblmt lblmt 0 0 0 0 0 0 0 0 0 0 0];
ub = [7000 4000 12000 15000 2800 5000 5500 ublmt ublmt 6000 ublmt ublmt ublmt ublmt ublmt ublmt ublmt ublmt ublmt ublmt ublmt ublmt];

lb = [4200 lblmt lblmt lblmt 2800 3000 lblmt lblmt lblmt lblmt lblmt 0 0 0 0 0 0 0 0 0 0 0];
ub = [7000 4000 12000 15000 2800 5000 5500 ublmt ublmt 6000 ublmt ublmt ublmt ublmt ublmt ublmt ublmt ublmt ublmt ublmt ublmt ublmt];

% outlet discount rate
sale_price = [300 450 300 120 270 320 350 205 75 200 120];
sale_price = [sale_price sale_price*0.6];
c = sale_price - mnfctr_cst - mtrls_cost;

sale_price = [300 450 300 120 270 320 350 205 75 200 120];
sale_price = [sale_price sale_price*0.6];
c = sale_price - mnfctr_cst - mtrls_cost;