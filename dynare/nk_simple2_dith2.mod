// Gali Ch.5 examples. We set alpha = 1.
// January 2016, Takeki Sunakawa

parameters beta sigma kappa rho rhou vtheta;
var x pai u;
varexo epsu;

beta = 0.99;
sigma = 1.0;
vphi = 5;
eps = 9;
theta = 3/4;
alpha = 0; //0.25;
rhou = 0;

Theta = (1-alpha)/(1-alpha+alpha*eps);
lambda = (1-theta)*(1-beta*theta)/theta*Theta;
kappa = lambda*(sigma+(vphi+alpha)/(1-alpha));

rho = -log(beta); // typo 01/06/16 
//mu = log((1-tau)*eps/(eps-1)); // logged markup, added tau 01/09/16
//psiy = -mu/(sigma+vphi);
//psiya = (1+vphi)/(sigma+vphi);

vtheta = kappa/eps;

model(linear);

// key equations
//r = rho + phip*pai + phiy*x + phiy*(yn-psiy) + v;
pai = beta*pai(+1) + kappa*x + u; // kappa/(sigma+vphi)*u;
//x = x(+1) - 1/sigma*(r-pai(+1)-rho);

u = rhou*u(-1) + epsu;

// FOCs
x = -kappa/vtheta*pai;

end;

initval;
x   = 0;
pai = 0;
//r   = rho;
end;

steady;

check;

shocks;
var epsu; stderr 1.0;
end;

rhou = 0.0;
stoch_simul(order=1,irf=16,nograph);

irfmat(:,1,1) = x_epsu;
irfmat(:,2,1) = pai_epsu;
irfmat(:,3,1) = cumsum(pai_epsu);
irfmat(:,4,1) = u_epsu;

rhou = 0.8;
stoch_simul(order=1,irf=16,nograph);

irfmat(:,1,2) = x_epsu;
irfmat(:,2,2) = pai_epsu;
irfmat(:,3,2) = cumsum(pai_epsu);
irfmat(:,4,2) = u_epsu;

save nk_dith.mat irfmat;