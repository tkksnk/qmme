// neoclassical growth model
var c k;
varexo A;
parameters beta theta delta;

// setting parameter value
beta = 0.96;
theta = 0.36;
delta = 0.1;
Abar = 1.0;

// analytical steady state values
kss = (theta*beta*Abar/(1-beta*(1-delta)))^(1/(1-theta));
css = Abar*kss^theta - delta*kss;

model;

c(+1)/c = beta*(1+theta*A(+1)*k^(theta-1)-delta);
k - k(-1) = A*k(-1)^theta - delta*k(-1) - c;

end;

// any (educated) initial guess for the steady state
initval;
c = 1.0;
k = 1.0;
A = Abar;
end;

// solving for the steady state numerically
steady;

disp([css;kss]);

// initial value of the endogenous variable
initval;
k = 0.5*kss;
end;

// simulate the model
simul(periods=100);

// plot the result
figure;
plot(k(1:101),c(2:102),'r*');
hold on;

// draw the phase diagram
kgrid = linspace(0.3*kss,2.0*kss,101)';
gk = Abar*kgrid.^theta - delta*kgrid;
plot(kgrid,gk); // gk line
plot([kss kss],[0.8*css 1.2*css]); // gc line