% // Cooley and Hansen's model with indivisible labor
% // Solving for steady state values (analytically)
clear all;

beta = .99;
delta = .025;
theta = .36;
A = 1.72;
h0 = .583;
B = A*log(1-h0)/h0;
pi4ss = 0.0; %// annual inflation
gss = (1+pi4ss)^(1/4); %// quarterly inflation / money growth

pi4vec = [-0.04 0.0 0.1 1.0 4.0]';
ssvec = zeros(6,5);

for i = 1:5

%     // quarterly inflation / money growth
    gss = (1+pi4vec(i))^0.25;

%    steady;

    rss = 1/beta-1+delta;
    wss = (1-theta)*(rss/theta)^(theta/(theta-1));
    Css = -beta*wss/B/gss; %exp(oo_.steady_state(7));
    KHss = (rss/theta)^(1/(theta-1));
    CKss = wss/KHss + rss - delta;
    Kss = Css/CKss; %exp(oo_.steady_state(1));
    Hss = Kss/KHss; %exp(oo_.steady_state(2));
    Xss = delta*Kss;
    Yss = Css + Xss;
    Welfss = (log(Css)+B*Hss)/(1-beta);
    ssvec(:,i) = [Yss Css Xss Kss Hss Welfss]';

end

% // Welfare loss (%) from the benchmark case of the Friedman rule
ssvec(6,:) = (ssvec(6,:)/ssvec(6,1)-1)*100;
