// Gali Ch.4 examples.
// December 2015, Takeki Sunakawa

parameters beta sigma kappa phip phiy rho rhov rhoz rhoa psiy psiya vphi alpha eta;
var x pai r rr v z a yn rn y n w p m;
varexo epsv epsz epsa;

beta = 0.99;
sigma = 1.0;
vphi = 5;
eps = 9;
theta = 3/4;
phip = 1.5;
phiy = 0.5/4;
rhov = 0.5;
rhoz = 0.5;
rhoa = 0.9;
eta = 4;
alpha = 0;
//alpha = 0.25;

Theta = (1-alpha)/(1-alpha+alpha*eps);
lambda = (1-theta)*(1-beta*theta)/theta*Theta;
kappa = lambda*(sigma+(vphi+alpha)/(1-alpha));

rho = -log(beta);
mu = log(eps/(eps-1)); // logged markup
psiy = -(1-alpha)*(mu-log(1-alpha))/(sigma*(1-alpha)+vphi+alpha);
psiya = (1+vphi)/(sigma*(1-alpha)+vphi+alpha);

model(linear);

// key equations
r = rho + phip*pai + phiy*x + phiy*(yn-psiy) + v;
pai = beta*pai(+1) + kappa*x;
x = x(+1) - 1/sigma*(r-pai(+1)-rn);

// natural rate
rn = rho - sigma*(1-rhoa)*psiya*a + (1-rhoz)*z;
// natural level of output
yn = psiya*a + psiy;
y = x + yn;

// other variables
rr = r - pai(+1);
(1-alpha)*n = y - a;
w = sigma*y + vphi*n;
p = p(-1) + pai;
m = p + y - eta*r;

v = rhov*v(-1) + epsv;
z = rhoz*z(-1) + epsz;
a = rhoa*a(-1) + epsa;

end;

initval;
x   = 0;
pai = 0;
r   = rho;
rr  = rho;
rn  = rho;
yn  = psiy;
y   = psiy;
n   = psiy/(1-alpha);
w   = (sigma+vphi/(1-alpha))*psiy;
p   = 0;
m   = psiy - eta*rho;
a   = 0;
v   = 0;
end;

steady;

check;

// comment in either shock only
shocks;
//var epsa; stderr 1.0; // technology shock
var epsz; stderr 1.0; // demand shock
end;

phip = 1.5;
phiy = 0.125;
stoch_simul(order=1,nograph,noprint);
stdx(1)   = sqrt(oo_.var(1,1));
stdpai(1) = sqrt(oo_.var(2,2));
stdy(1)   = sqrt(oo_.var(10,10));

phip = 1.5;
phiy = 0.0;
stoch_simul(order=1,nograph,noprint);
stdx(2)   = sqrt(oo_.var(1,1));
stdpai(2) = sqrt(oo_.var(2,2));
stdy(2)   = sqrt(oo_.var(10,10));

phip = 5.0;
phiy = 0;
stoch_simul(order=1,nograph,noprint);
stdx(3)   = sqrt(oo_.var(1,1));
stdpai(3) = sqrt(oo_.var(2,2));
stdy(3)   = sqrt(oo_.var(10,10));

phip = 1.5;
phiy = 1.0;
stoch_simul(order=1,nograph,noprint);
stdx(4)   = sqrt(oo_.var(1,1));
stdpai(4) = sqrt(oo_.var(2,2));
stdy(4)   = sqrt(oo_.var(10,10));

loss = .5*(1-beta)*((sigma+(vphi+alpha)/(1-alpha))*(stdx).^2 + eps/lambda.*(stdpai).^2);

disp([stdy; stdx; stdpai; loss]);
