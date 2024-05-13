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

price_item = [300 450 300 120 270 320 350 205 75 200 120];
cost_materials_item = [30 90 26 6.5 6.75 24.75 3 5 1.25 0 3.375];
cost_labor_item = [160 150 160 60 120 140 175 100 40 160 90];

revenue_item_factory = price_item - (cost_materials_item+cost_labor_item);
revenue_item_outlet = 0.6*price_item - (cost_materials_item+cost_labor_item);

velvet_purchased = 9300; % 20000 when the order cannot be altered, 9300 when it can be altered

% Acetate, Wool, Cashmere, Rayon, Velvet, Cotton, Silk
b = [28000; 45000; 9000; 30000; velvet_purchased; 30000; 18000; 15000];

A = [2	0	0	0	1.5	1.5	2	0	0	0	0;
    3	0	0	0	0	2.5	0	0	0	0	0;
    0	1.5	0	0	0	0	0	0	0	0	0;
    0	0	0	0	2	0	0	0	0	0	1.5;
    0	0	0	0	0	0	3	0	0	1.5	0;
    0	0	0	0	0	0	0	2	0.5	0	0;
    0   0   2  0.5  0   0   0   0   0   0   0;
    0   0   1   1   0   0   0   0   0   0   0];

U_bnd=inf; %arbitraty upper bound
L_bnd=100; %arbitrary lower bound

lb= [4200 L_bnd L_bnd L_bnd 2800 3000 L_bnd L_bnd L_bnd L_bnd L_bnd];
u = [U_bnd 4000 12000 15000 U_bnd U_bnd 5500 U_bnd U_bnd 6000 U_bnd];

options = optimoptions('linprog','Algorithm','dual-simplex');

[xsim, fvalsim, exitflag, output, lambda] = linprog(-revenue_item_factory, A, b, [], [], lb, u, options);

fvalsim1 = (-fvalsim) -(velvet_purchased*12) %adding the cost of total velvet materials