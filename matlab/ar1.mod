// simple AR(1) example of Dynare
var x; // endogenous variable
varexo e; // exogenous variable 
parameters RHO; // parameter

// setting parameter value
RHO = 0.8;

model;

x = RHO*x(-1) + e;

end;

steady;

// initial value of the endogenous variable
initval;
x = 0;
//x = -5;
end;

// sequence of the exogenous variable
shocks;
var e;
periods 1;
values -5;
end;

// simulate the model
simul(periods=20);

// plot the result
figure;
plot(x);