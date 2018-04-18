// Cooley and Hansen's model with indivisible labor
// Solving for equilibrium dynamics (numerically with Dynare)
parameters beta delta theta B gss rhog;
var lk lh lp lw lr lg lc;
varexo epsg;

beta = .99;
delta = .025;
theta = .36;
A = 1.72;
h0 = .583;
B = A*log(1-h0)/h0;
pi4ss = 0.0; // annual inflation
gss = (1+pi4ss)^(1/4); // quarterly inflation / money growth
rhog = 0.481;

// dynamic version of the model' equilibrium condition
model;

1 = beta*exp(lw-lw(+1))*(1+exp(lr(+1))-delta);

B/exp(lw+lp) = -beta*1/exp(lp(+1)+lc(+1)+lg(+1));

exp(lp+lc) = 1;

exp(lk) + exp(-lp) = exp(lw+lh) + exp(lr+lk(-1)) + (1-delta)*exp(lk(-1));

exp(lw) = (1-theta)*exp(theta*(lk(-1)-lh));

exp(lr) = theta*exp((theta-1)*(lk(-1)-lh));

lg = (1-rhog)*log(gss) + rhog*lg(-1) + epsg;

end;

steady;

check;

shocks;
var epsg; stderr 0.0086;
end;

stoch_simul(order=1,irf=40);