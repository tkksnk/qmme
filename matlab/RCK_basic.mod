// The RCK model
var k c y;
varexo A;
parameters BETA ALPHA DELTA;

BETA = 0.96;
ALPHA = 0.36;
DELTA = 0.10;
A_ss = 1.0;

k_ss = (ALPHA*BETA*A_ss/(1-BETA*(1-DELTA)))^(1/(1-ALPHA));
y_ss = A_ss*k_ss^ALPHA;
c_ss = y_ss-DELTA*k_ss;
k_ini = 0.1;

model;

1 = BETA*c/c(+1)*(1+(ALPHA*y(+1)/k-DELTA));

c + k - (1-DELTA)*k(-1) = y;

y = A*k(-1)^ALPHA;

end;

initval;

k = k_ss;
c = c_ss;
y = y_ss;
A = A_ss;

end;

steady;

initval;
k = k_ini;
end;

simul(periods=100);

figure;
plot([0:100],k(1:101));