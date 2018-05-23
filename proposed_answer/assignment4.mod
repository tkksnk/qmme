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
//Lambda = (1-beta*rhov)*(sigma*(1-rhov)+phiy)+kappa*(phip-rhov);
//Lambda = 1/Lambda;

rho = log(beta);
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
z = rhoz*z(-1) - epsz;
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

shocks;
var epsz; stderr 0.5;
end;

stoch_simul(order=1,irf=16,nograph);

// plot graphs
T = 15;
xvec  = x_epsz;
paivec = pai_epsz;
yvec  = y_epsz;
nvec  = n_epsz;
wvec  = w_epsz;
pvec  = p_epsz;
rvec = r_epsz;
rrvec  = rr_epsz;
mvec  = m_epsz;
zvec  = z_epsz;

figure;
subplot(521);
plot([0:T],xvec,'bo-');
xlim([-1 T+2]);
//ylim([-0.2 0]);
title('Output gap');
subplot(522);
plot([0:T],4*paivec,'bo-');
xlim([-1 T+2]);
//ylim([-1.5 0]);
title('Inflation');
subplot(523);
plot([0:T],yvec,'bo-');
xlim([-1 T+2]);
//ylim([0.2 0.8]);
title('Output');
subplot(524);
plot([0:T],nvec,'bo-');
xlim([-1 T+2]);
//ylim([-0.4 0]);
title('Employment');
subplot(525);
plot([0:T],wvec,'bo-');
xlim([-1 T+2]);
//ylim([-0.8 0]);
title('Real wage');
subplot(526);
plot([0:T],pvec,'bo-');
xlim([-1 T+2]);
//ylim([-3.0 0]);
title('Price level');
subplot(527);
plot([0:T],4*rvec,'bo-');
xlim([-1 T+2]);
//ylim([-1.5 0.0]);
title('Nominal rate');
subplot(528);
plot([0:T],4*rrvec,'bo-');
xlim([-1 T+2]);
//ylim([-0.4 0.0]);
title('Real rate');
subplot(529);
plot([0:T],mvec,'bo-');
xlim([-1 T+2]);
//ylim([-4 2]);
title('Money supply');

subplot(5,2,10);
plot([0:T],zvec,'bo-');
xlim([-1 T+2]);
//ylim([0 1.5]);
title('z');