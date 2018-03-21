// Stochastic neoclassical growth model (with fixed labor)
// Log-linearized
parameters beta alpha delta rho sigma;
var c k a y R x;
varexo e;

beta = 0.99;
alpha = 0.36;
delta = 0.10/4;
rho = 0.95;
sigma = 0.00712;

model(linear);

#kss = (alpha*beta/(1-beta*(1-delta)))^(1/(1-alpha));
#css = kss^alpha-delta*kss;
#yss = kss^alpha;

#cck = (alpha-1)*(1-beta*(1-delta));
#cca = (1-beta*(1-delta));
#ckc = css/kss;
#ckk = 1/beta;
#cka = (1-beta*(1-delta))/(alpha*beta);

c - c(+1) + cck*k + cca*a(+1) = 0;

ckc*c + k = ckk*k(-1) + cka*a;

a = rho*a(-1) + e;

y = a + alpha*k(-1);

R = (1-beta*(1-delta))*(a+(alpha-1)*k(-1));

delta*x = k - (1-delta)*k(-1); 

end;

steady;

check;

shocks;
var e; stderr sigma;
end;

stoch_simul(order=1,nograph,noprint);
//pause;


// calculating the business cycle statistics
n = 100;
stdmat = zeros(n,4);
corrmat = zeros(n,4);

for i = 1:n

    stoch_simul(order=1,periods=115,nograph,noprint);

    xx = [y c x k];
    xf = hpfilter(xx,1600);
    stdmat(i,:) = std(xf);
    temp = corr(xf);
    corrmat(i,:) = temp(1,:);

end

disp([mean(stdmat);std(stdmat)]);
disp([mean(corrmat);std(corrmat)]);