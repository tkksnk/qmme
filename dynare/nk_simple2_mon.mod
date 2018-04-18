parameters beta sigma kappa phip phiy rhov rhoa psiy psiya vphi alpha eta;
var x pai rn r v a yn y n w p m;
varexo epsv epsa;

beta = 0.99;
sigma = 1.0;
vphi = 5;
eps = 9;
theta = 3/4;
phip = 1.5;
phiy = 0.5/4;
rhov = 0.5;
rhoa = 0.9;
eta = 4;
//alpha = 0;
alpha = 0.25;

Theta = (1-alpha)/(1-alpha+alpha*eps);
lambda = (1-theta)*(1-beta*theta)/theta*Theta;
kappa = lambda*(sigma+(vphi+alpha)/(1-alpha));
Lambda = (1-beta*rhov)*(sigma*(1-rhov)+phiy)+kappa*(phip-rhov);
Lambda = 1/Lambda;

mu = log(eps/(eps-1)); // logged markup
psiy = -(1-alpha)*(mu-log(1-alpha))/(sigma*(1-alpha)+vphi+alpha);
psiya = 1+vphi/(sigma*(1-alpha)+vphi+alpha);

model(linear);

rn = phip*pai + phiy*x + v;
pai = beta*pai(+1) + kappa*x;
x = x(+1) - 1/sigma*(rn-pai(+1));
r = rn - pai(+1);

// natural level of output
yn = psiya*a + psiy;
y = x + yn;

(1-alpha)*n = y - a;
w = sigma*y + vphi*n;
p = p(-1) + pai;
m = p + y - eta*rn;

v = rhov*v(-1) + epsv;
a = rhoa*a(-1) + epsa;

end;

initval;
x   = 0;
pai = 0;
rn  = 0;
r   = 0;
yn  = psiy;
y   = psiy;
n   = psiy/(1-alpha);
w   = (sigma+vphi/(1-alpha))*psiy;
p = 0;
m = psiy;
a = 0;
v = 0;
end;

steady;

check;

shocks;
var epsv; stderr 0.25;
end;

stoch_simul(order=1,irf=16,nograph);

T = 15;
xvec  = x_epsv;
paivec = pai_epsv;
yvec  = y_epsv;
nvec  = n_epsv;
wvec  = w_epsv;
pvec  = p_epsv;
rnvec = rn_epsv;
rvec  = r_epsv;
mvec  = m_epsv;
vvec  = v_epsv;

figure;
subplot(521);
plot([0:T],xvec,'bo-');
xlim([-1 T+2]);
ylim([-0.4 0]);
title('Output gap');
subplot(522);
plot([0:T],4*paivec,'bo-');
xlim([-1 T+2]);
ylim([-0.4 0]);
title('Inflation');
subplot(523);
plot([0:T],yvec,'bo-');
xlim([-1 T+2]);
ylim([-0.4 0]);
title('Output');
subplot(524);
plot([0:T],nvec,'bo-');
xlim([-1 T+2]);
ylim([-0.4 0]);
title('Employment');
subplot(525);
plot([0:T],wvec,'bo-');
xlim([-1 T+2]);
title('Real wage');
subplot(526);
plot([0:T],pvec,'bo-');
xlim([-1 T+2]);
ylim([-0.2 0]);
title('Price level');
subplot(527);
plot([0:T],4*rnvec,'bo-');
xlim([-1 T+2]);
ylim([0 0.4]);
title('Nominal rate');
subplot(528);
plot([0:T],4*rvec,'bo-');
xlim([-1 T+2]);
ylim([0 0.8]);
title('Real rate');
subplot(529);
plot([0:T],mvec,'bo-');
xlim([-1 T+2]);
ylim([-0.8 0]);
title('Money supply');

subplot(5,2,10);
plot([0:T],vvec,'bo-');
xlim([-1 T+2]);
ylim([0 0.4]);
title('v');