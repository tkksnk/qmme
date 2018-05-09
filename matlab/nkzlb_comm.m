clear all;

beta = 0.99;
sigma = 1.0;
vphi = 5;
eps = 9; % Markup = eps/(eps-1)
theta = 3/4;
alpha = 0;

lambda = (1-theta)*(1-beta*theta)/theta;
kappa = lambda*(sigma+vphi);

rho = -log(beta);
%mu = log(eps/(eps-1)); %// logged markup

vtheta = kappa/eps;
gamma = vtheta/(vtheta*(1+beta)+kappa^2);
delta = (1-sqrt(1-4*beta*gamma^2))/2/gamma/beta;

A = [1 1/sigma; 
    kappa beta+kappa/sigma];
B = [1/sigma; 
    kappa/sigma];
M1 = [-kappa 1+beta*(1-delta); 
    beta*(1-delta)+kappa^2/vtheta -kappa/vtheta];
M2 = [beta*(1-delta) (1-delta)/sigma; 
    0 (1-delta)/vtheta];
M = inv(M1)*M2;
H = [1 1/beta/sigma;
    kappa 1/beta*(1+kappa/sigma)];
J = [0 1; vtheta kappa];

T = 11;
Tz = 6;
Tc = 7; % >Tz, check if the nominal rate is above zero for all periods
xvec = zeros(T+1,1);
pvec = zeros(T+1,1);
rnvec = rho*ones(T+1,1);
xi1vec = zeros(T+1,1);
xi2vec = zeros(T+1,1);

rnvec(1:Tz+1) = -rho*ones(Tz+1,1);

nn = 4*(Tc+2);
AA = zeros(nn,nn);
bb = zeros(nn,1);

% t = 0
AA(1:2,1:2) = eye(2);
AA(1:2,5:6) = -A;
AA(3:4,1:2) = J;
AA(3:4,3:4) = eye(2);
bb(1:2,1) = B*rnvec(1);

% t = 1,...,tc
for t = 1:Tc 
     
    id = 4*t + 1;
    AA(id:id+1,id:id+1) = eye(2);
    AA(id:id+1,id+4:id+5) = -A;
    AA(id+2:id+3,id-2:id-1) = -H;
    AA(id+2:id+3,id:id+1) = J;
    AA(id+2:id+3,id+2:id+3) = eye(2);
    bb(id:id+1,1) = B*rnvec(t+1);    
    
end

% t = tc+1
id = 4*(Tc+1) + 1; 
AA(id:id+1,id-2:id-1) = -M;
AA(id:id+1,id:id+1) = eye(2);
AA(id+2:id+3,id-2:id-1) = -H;
AA(id+2:id+3,id:id+1) = J;
AA(id+2:id+3,id+2:id+3) = eye(2);

xx = inv(AA)*bb;
xvec = xx([1:4:4*(Tc+1)+1]);
pvec = xx([2:4:4*(Tc+1)+2]);

% for t = Tc+2:T+2
%     
%     k = t-(Tc+2);
%     xvec(t) = (kappa/vtheta)*(delta^(k+1))*xx(4*(Tc+1)+3);
%     pvec(t) = (1-delta)*(delta^k)*xx(4*(Tc+1)+3);
%     
% end
xvec(Tc+2+1:T+2) = (kappa/vtheta)*(delta.^[1:T-Tc])*xx(4*(Tc+1)+3);
pvec(Tc+2+1:T+2) = (1-delta)*delta.^[0:T-Tc-1]*xx(4*(Tc+1)+3);
ivec(1:T+1) = rnvec(1:T+1) + pvec(2:T+2) + sigma*(xvec(2:T+2)-xvec(1:T+1));

xvec_coth = xvec(1:T+1)*100;
paivec_coth = pvec(1:T+1)*400;
ivec_coth = ivec(1:T+1)*400;

% discretionary policy
xvec = zeros(T+1,1);
pvec = zeros(T+1,1);

for t = Tz+1:-1:1
    
    temp = A*[xvec(t+1); pvec(t+1)] - B*rho;
    xvec(t) = temp(1);
    pvec(t) = temp(2);
    
end

xvec_dith = xvec(1:T+1)*100;
paivec_dith = pvec(1:T+1)*400;
ivec_dith = max(0,rnvec(1:T+1))*400;

figure;
subplot(221);
plot([0:T],xvec_coth,'gx-');
hold on;
plot([0:T],xvec_dith,'ro-');
xlim([-1 T+1]);
title('Output gap');
subplot(222);
plot([0:T],paivec_coth,'gx-');
hold on;
plot([0:T],paivec_dith,'ro-');
xlim([-1 T+1]);
title('Inflation');
subplot(223);
plot([0:T],ivec_coth,'gx-');
hold on;
plot([0:T],ivec_dith,'ro-');
xlim([-1 T+1]);
title('Nominal rate');
subplot(224);
plot([0:T],rnvec*400,'k-');
xlim([-1 T+1]);
title('Natural rate');