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

U_bnd=inf; %arbitraty upper bound
U_cotton_miniskirt = inf; %semi-arbitrary upper limit for the production of cotton miniskirts
L_bnd=100; %arbitrary lower bound


price_item = [300 450 300 120 270 320 350 205 75 200 120];
cost_materials_item = [30 90 26 6.5 6.75 24.75 39 5 1.25 18 3.375];
cost_labor_item = [160 150 160 60 120 140 175 100 40 160 90];

revenue_item_factory = price_item - (cost_materials_item+cost_labor_item);
revenue_item_outlet = 0.6*price_item - (cost_materials_item+cost_labor_item);

new_revenue_matrix = [revenue_item_factory revenue_item_outlet];

%change the 8th value here when altering demand
b = [28000; 45000; 9000; 30000; 20000; 30000; 18000; 15000; 10000000000];

% each row corresponds a material, each column corresponds to clothing
A = [2	0	0	0	1.5	1.5	2	0	0	0	0;
    3	0	0	0	0	2.5	0	0	0	0	0;
    0	1.5	0	0	0	0	0	0	0	0	0;
    0	0	0	0	2	0	0	0	0	0	1.5;
    0	0	0	0	0	0	3	0	0	1.5	0;
    0	0	0	0	0	0	0	2	0.5	0	0;
    0   0   2  0.5  0   0   0   0   0   0   0;
    0   0   1   1   0   0   0   0   0   0   0;
    0   0   0   0   0   0   0   1   1   0   0];

% this adds more columns, to account for the separate group of each of the
% clothing items that are instead being sent to the outlet stores
new_A = [A A];

%bc this was an extra row making sure that the silk camisole stays below
%its anticipated demand
new_A(8,13)=0;
new_A(8,14)=0;

%when the lower bound is decreased for 5th 
lb= [4200 L_bnd L_bnd L_bnd 2800*(1/1.01) 3000 L_bnd L_bnd L_bnd L_bnd L_bnd]*1.01;
lb_0 = [0 0 0 0 0+2800*0.01 0 0 0 0 0 0];
new_lb = [lb lb_0];

%u = [U_bnd 4000 12000 15000 U_bnd U_bnd 5500 U_bnd U_bnd 6000 U_bnd];
anticipated_demand = [7000 4000 12000 15000 2800 5000 5500 U_bnd U_cotton_miniskirt 6000 U_bnd];
u_0 = [U_bnd U_bnd U_bnd U_bnd U_bnd U_bnd U_bnd U_bnd U_bnd U_bnd U_bnd];
new_u = [anticipated_demand u_0];

options = optimoptions('linprog','Algorithm','dual-simplex');

[xsim, fvalsim, exitflag, output, lambda] = linprog(-new_revenue_matrix, new_A, b, [], [], new_lb, new_u, options);

%[xsim, fvalsim, exitflag, output] = intlinprog(-new_revenue_matrix, [1,2,3,4,5,6,7,8,9,10,11], new_A, b, [], [], new_lb, new_u);