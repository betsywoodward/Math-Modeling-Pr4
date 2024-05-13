% x_1	Tailored wool slacks
% x_2	Cashmere sweater
% x_3	Silk blouse**
% x_4	Silk camisole*
% x_5	Tailored skirt
% x_6	Wool blazer
% x_7	Velvet pants
% x_8	Cotton sweater**
% x_9	Cotton miniskirt*
% x_10	Velvet shirt
% x_11	Button-down blouse

U_bnd=10000000000; %arbitraty upper bound
L_bnd=100; %arbitrary lower bound

extra_wool_expense =80*(1-0.7);

price_item = [300 450 300 120 270 320 350 205 75 200 120];
cost_materials_item = [30 90 26 6.5 6.75 24.75 39 5 1.25 18 3.375];
cost_labor_item = [160 150 160 60 120 140+extra_wool_expense 175 100 40 160 90];

revenue_item_factory = price_item - (cost_materials_item+cost_labor_item);

b = [28000; 45000; 9000; 30000; 20000; 30000; 18000; 15000];

A = [2	0	0	0	1.5	1.5	2	0	0	0	0;
    3	0	0	0	0	2.5	0	0	0	0	0;
    0	1.5	0	0	0	0	0	0	0	0	0;
    0	0	0	0	2	0	0	0	0	0	1.5;
    0	0	0	0	0	0	3	0	0	1.5	0;
    0	0	0	0	0	0	0	2	0.5	0	0;
    0   0   2   0.5 0   0   0   0   0   0   0;
    0   0   1   1   0   0   0   0   0   0   0];

lb= [4200 L_bnd L_bnd L_bnd 2800 3000 L_bnd L_bnd L_bnd L_bnd L_bnd];

u = [U_bnd 4000 12000 15000 U_bnd U_bnd 5500 U_bnd U_bnd 6000 U_bnd];

options = optimoptions('linprog','Algorithm','dual-simplex');

[xsim, fvalsim, exitflag, output, lambda] = linprog(-revenue_item_factory, A, b, [], [], lb, u, options);