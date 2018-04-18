parameters theta varphi beta rho kappa sigma phip phiy phiya psiy rhov;
var r rr pai y ytilde yn rn v;
varexo epsv;

eps = 9; // elasticity of demand
theta = 3/4; // probability of fixing the price
sigma = 1.0; // risk aversion
varphi = 5; // inverse of Frisch elasticity
beta = 0.99; // discount factor
rho = -log(beta); // nominal interest rate in SS
kappa = (1-theta)*(1-theta*beta)*(sigma+varphi)/theta; // the slope of the Phillips curve
phip = 1.5; // coefficient on inflation
phiy = 0.5/4; // coefficient on output
mu = log(eps/(eps-1)); // logged markup
psiy = -mu/(sigma+varphi); // output in SS
//psiya = 
rhov = 0.5; // AR(1) of monetary policy shock

model(linear);

r = rho + phip*pai + phiy*(y-psiy) + v;
ytilde = y - yn;
pai = beta*pai(+1) + kappa*ytilde;
ytilde = ytilde(+1) - 1/sigma*(r-pai(+1)-rn);

rr = r - pai(+1);

yn = psiy;
rn = rho;
v = rhov*v(-1) + epsv;

end;

steady;

check;

shocks;
var epsv; stderr 0.25;
end;

stoch_simul(order=1,irf=16) ytilde pai r rr;
