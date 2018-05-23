clear all;

bet = 0.9950;
kap = 0.024;
phi = 2.0;
pibar = 1.005;
rstar = log(pibar/bet)*100;

Ns = 2;
pH = 0.01;
pL = 0.75;
sH = rstar;
sL = rstar-2.5;

% transition matrix and grid points
Ps = [1-pH pH;
    1-pL pL];
Gs = [sH; sL];

% analytical solution
% x = [yH piH rnH yL piL rnL]
A = [1-pH 1-pH -1 pH pH 0;
    kap bet*(1-pH) 0 0 bet*pH 0;
    0 phi*(1-pH) 0 0 phi*pH 0;
    1-pL 1-pL 0 pL pL 0;
    0 bet*(1-pL) 0 kap bet*pL 0;
    0 0 0 0 0 0];
b = [sH 0 rstar sL 0 0]';

x = inv(eye(6)-A)*b;

% numerical solution
% initial guess of the policy function
yvec0 = zeros(Ns,1);
pivec0 = zeros(Ns,1);
rnvec0 = zeros(Ns,1);
yvec1 = yvec0;
pivec1 = pivec0;
rnvec1 = rnvec0;

for iter = 1:1000

    for is = 1:Ns

        % conditional expectation
        ey = Ps(is,:)*yvec0;
        epi = Ps(is,:)*pivec0;

        % solve for rn, y, pi
        rn = max(0,rstar+phi*epi); % ZLB
        y = ey - (rn-epi-Gs(is));
        pi = kap*y + bet*epi;

        % update the policy function
        yvec1(is) = y;
        pivec1(is) = pi;
        rnvec1(is) = rn;

    end

    % check the convergence
    diffy = max(abs(yvec1-yvec0));
    diffpi = max(abs(pivec1-pivec0));
    diff = max(diffy,diffpi)

    % update yvec0 by yvec1
    yvec0 = yvec1
    pivec0 = pivec1
    rnvec0 = rnvec1
    
%     iter
%     pause;

end    
    
figure;
subplot(231);
plot(rnvec0*4); % annual value
subplot(232);
plot(yvec0);
subplot(233);
plot(pivec0*4); % annual value

    
    
    
    