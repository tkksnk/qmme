// Dynare version of Solow2.m
var k a; // endogenous variable
varexo e; // exogenous variable 
parameters B C RHO; // parameter

// setting parameter value
delta = 0.1; % depreciation rate
sigma = 0.2; % 1-saving rate
theta = 0.36; % capital share
n = 0.02; % population growth
Abar = 1.0; % steady state TFP
RHO = 0.9; % persistence of TFP

% steady state values
kbar = (sigma*Abar/(n+delta))^(1/(1-theta));
ykbar = Abar*kbar^(theta-1)

% coefficients in the dynamic equation
B = (1-delta+sigma*theta*ykbar)/(1+n);
C = sigma*ykbar/(1+n);

model;

k = B*k(-1) + C*a;
a = RHO*a(-1) + e;

end;

steady;

// initial value of the endogenous variable
initval;
a = 0;
k = 0;
end;

// sequence of the exogenous variable
shocks;
var e;
periods 1;
values 0.01;
end;

// simulate the model
simul(periods=20);

// plot the result
figure;
plot(k);