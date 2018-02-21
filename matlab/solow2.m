% solow2.m: with persistent shocks
clear all;

%% 1. parameterization
delta = 0.1; % depreciation rate
sigma = 0.2; % 1-saving rate
theta = 0.36; % capital share
n = 0.02; % population growth
Abar = 1.0; % steady state TFP
RHO = 0.0; % persistence of TFP

% steady state values
kbar = (sigma*Abar/(n+delta))^(1/(1-theta));
ykbar = Abar*kbar^(theta-1)

% coefficients in the dynamic equation
B = (1-delta+sigma*theta*ykbar)/(1+n)
C = sigma*ykbar/(1+n)

%% 2. initial value of k and a
a0 = 0;
k0 = 0; %kbar;

%% 3. shock in period 1
eps = 0.01;

%% 4. next period's capital and TFP
a1 = RHO*a0 + eps;
k1 = B*k0 + C*a1

% a2 = RHO*a1;
% k2 = B*k1 + C*a2;
% 
% a3 = RHO*a2;
% k3 = B*k2 + C*a3;
% 
% ...

%% 5. use for loop
avec = zeros(40,1);
kvec = zeros(40,1);
avec(1) = a1;
kvec(1) = k1;

for i = 1:40-1

    avec(i+1) = RHO*avec(i);
    kvec(i+1) = B*kvec(i) + C*avec(i+1);
    
end

figure;
plot([1:40],kvec);
hold on;
plot([1:40],avec,'r-');
