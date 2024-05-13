%% Sensitivity with Scarves!

% Absolute lower/upper production bounds
lblmt = 100;
ublmt = inf;

% Model Alterations (Scenarios)
addAce = 10000; % additional acetate
blazercost=80;
velvet = 19650;% * Based on optimal pants + shirt production

% Scales for upper and lower bounds **INCREASING lbscale / DECREASING
% ubscale REQUIRES CHANGES TO THE UPPER BOUND LIST FOR TAILORED SKIRTS.
ubscale=1;
lbscale=1;

% Sale Price, Manufacturing Cost, and Material Cost
slprice = [300 450 300 120 270 320 350 205 75 200 120 135];
mnfcost = [160 150 160 60 120 140+blazercost 175 100 40 160 90 40];
matcost = [30 90 26 6.5 6.75 24.75 39-3*12 5 1.25 18-1.5*12 3.375 30];

c = slprice-mnfcost-matcost;
b = [28000 + addAce; 45000; 9000; 30000; velvet; 30000; 18000; 15000*ubscale; ublmt];
A = [2 0   0 0   1.5 1.5 2 0 0	 0	 0   0;
     3 0   0 0   0   2.5 0 0 0	 0	 0   0;
     0 1.5 0 0   0   0   0 0 0	 0	 0   0.5;
     0 0   0 0   2   0   0 0 0	 0	 1.5 0;
     0 0   0 0   0   0   3 0 0	 1.5 0   0;
     0 0   0 0   0   0   0 2 0.5 0	 0   0;
     0 0   2 0.5 0   0   0 0 0   0   0   0;
     0 0   1 1   0   0   0 0 0   0   0   0;
     0 0   0 0   0   0   0 1 1   0   0   0];
lb = [4200 lblmt lblmt lblmt 2800 3000 lblmt lblmt lblmt lblmt lblmt lblmt]*lbscale;
ub = [7000*2 4000 12000 15000 6000*2 5000*2 5500  ublmt ublmt 6000 ublmt ublmt]*ubscale;
options = optimoptions('linprog','Algorithm','dual-simplex');

[xvec, fval, exitflag, output, lambda] = linprog(-c, A, b, [], [], lb, ub, options);
fval=-fval-velvet*12;
