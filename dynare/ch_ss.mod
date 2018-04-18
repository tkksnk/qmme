// Cooley and Hansen's model with indivisible labor
// Solving for steady state values (numerically with Dynare)
parameters beta delta theta B gss; // rhoa rhog siga sigg rss wss pss kss hss;
var lk lh lp lw lr lg lc;

beta = .99;
delta = .025;
theta = .36;
A = 1.72;
h0 = .583;
B = A*log(1-h0)/h0;
pi4ss = 0.0; // annual inflation
gss = (1+pi4ss)^(1/4); // quarterly inflation / money growth

// steady state version of the model
model;

1 = beta*exp(lw-lw(+1))*(1+exp(lr)-delta);

B/exp(lw+lp) = -beta*1/exp(lp(+1)+lc(+1)+lg(+1));

exp(lp+lc+lg) = exp(lg);

exp(lk) + exp(-lp) = exp(lw+lh) + exp(lr)*exp(lk(-1)) + (1-delta)*exp(lk);

exp(lw) = (1-theta)*exp(theta*(lk-lh));

exp(lr) = theta*exp((theta-1)*(lk-lh));

lg = (1-rhog)*log(gss) + rhog*lg(-1) + ;

end;

steady;

// annual inflation / money growth
pi4vec = [-0.04 0.0 0.1 1.0 4.0]';
ssvec = zeros(6,5);

for i = 1:5

    // quarterly inflation / money growth
    gss = (1+pi4vec(i))^0.25;

    steady;

    Css = exp(oo_.steady_state(7));
    Kss = exp(oo_.steady_state(1));
    Hss = exp(oo_.steady_state(2));
    Xss = delta*Kss;
    Yss = Css + Xss;
    Welfss = (log(Css)+B*Hss)/(1-beta);
    ssvec(:,i) = [Yss Css Xss Kss Hss Welfss]';

end

// Welfare loss (%) from the benchmark case of the Friedman rule
ssvec(6,:) = (ssvec(6,:)/ssvec(6,1)-1)*100;

