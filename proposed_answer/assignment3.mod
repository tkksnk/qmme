// Hansen's RBC model with indivisible labor
// Log-linearized
parameters beta alpha delta rho sigma B;
var c k a y h R x;
varexo e;

beta = 0.99;
alpha = 0.36;
delta = 0.10/4;
rho = 0.95;
sigma = 0.00712;
A = 2;
h0 = 0.53;
B = -A*log(1-h0)/h0;


model(linear);

#ykss = (alpha*beta/(1-beta*(1-delta)))^(-1);
#khss = (alpha*beta/(1-beta*(1-delta)))^(1/(1-alpha));
#ckss = ykss-delta;
#hss = (1-alpha)/B*(1-beta*(1-delta))/(1-beta*(1-(1-alpha)*delta));
#kss = khss*hss;
#yss = ykss*kss;
#css = ckss*kss;

#dcc = 1 + beta*(1-alpha)*ykss;
#cck = 0;
#cca = beta*ykss;
#ckc = ckss + (1-alpha)/alpha*ykss;
#ckk = 1/beta + (1-alpha)*ykss;
#cka = ykss + (1-alpha)/alpha*ykss;

//c - c(+1) + (1-beta*(1-delta))*(a(+1) + (alpha-1)*k) 
//+ (1-beta*(1-delta))*(1-alpha)*h(+1);
//c - c(+1) + R(+1) = 0;
c - dcc*c(+1) + cck*k + cca*a(+1) = 0;

//ckss*c + k = ykss*a + alpha*ykss*k(-1) + (1-delta)*k(-1) 
//+ (1-alpha)/alpha*ykss*(a + alpha*k(-1) - c);
//ckss*c + k - (1-delta)*k(-1) = ykss*y;
ckc*c + k = ckk*k(-1) + cka*a;

a = rho*a(-1) + e;

y = a + alpha*k(-1) + (1-alpha)*h;

h = y - c;

R = (1-beta*(1-delta))*(a+(alpha-1)*(k(-1)-h));

delta*x = k - (1-delta)*k(-1); 

end;

steady;

check;

shocks;
var e; stderr sigma;
end;


n = 100;
stdmat = zeros(n,6);
corrmat = zeros(n,6);

for i = 1:n

    stoch_simul(order=1,periods=115,nograph,noprint);

    xx = [y c x k h y-h];
    xf = hpfilter(xx,1600);
    stdmat(i,:) = std(xf);
    temp = corr(xf);
    corrmat(i,:) = temp(1,:);

end

disp([mean(stdmat);std(stdmat)]);
disp([mean(corrmat);std(corrmat)]);