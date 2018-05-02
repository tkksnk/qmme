parameters theta varphi beta rho kappa sigma phip phiy psiya psiy rhoa;
var r rr rrgap pai y ytilde yn rn a lab;
varexo epsa;

// structural parameters
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
psiy = -mu/(sigma+varphi); // (natural) output in SS
psiya = (1+varphi)/(sigma+varphi); // natural output's coefficient on tech shock
//rhov = 0.5; // AR(1) of monetary policy shock
rhoa = 0.9; // AR(1) of technology shock

model(linear);

r = rho + phip*pai + phiy*(y-psiy); // + v;
ytilde = y - yn;
pai = beta*pai(+1) + kappa*ytilde;
ytilde = ytilde(+1) - 1/sigma*(r-pai(+1)-rn);

rr = r - pai(+1);
rrgap = rr - rn;
lab = y - a;

yn = psiy + psiya*a;
rn = rho - sigma*(1-rhoa)*psiya*a;
//v = rhov*v(-1) + epsv;
a = rhoa*a(-1) + epsa;

end;

steady;

check;

shocks;
//var epsv; stderr 0.25;
var epsa; stderr 1.0;
end;

stoch_simul(order=1,irf=0,periods=1000) ytilde pai r rrgap y lab;
