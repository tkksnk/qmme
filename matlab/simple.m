% simple rule
clear all;

bet = 0.9950;
kap = 0.024;
phi = 2.0;
pibar = 1.005;
rstar = log(pibar/bet)*100;

pH = 0.01;
pL = 0.75;
sH = rstar;
sL = rstar-2.5;

% (semi-)analytical
A = [-1+(1-pH) pH -(phi-1)*(1-pH) -(phi-1)*pH;
    kap 0 -1+bet*(1-pH) bet*pH;
    (1-pL) -1+pL (1-pL) pL;
    0 kap bet*(1-pL) -1+bet*pL];
b = [rstar-sH;0;-sL;0];
x = A\b;

yH  = x(1);
yL  = x(2);
piH = x(3);
piL = x(4);
% check>0
iH = rstar + phi*((1-pH)*piH + pH*piL);

% policy function iteration
Ns = 2;
yvec0 = [yH; yL];
pvec0 = [piH; piL];
ivec0 = [iH; 0];
% yvec0 = zeros(Ns,1);
% pvec0 = zeros(Ns,1);
% ivec0 = zeros(Ns,1);
yvec1 = zeros(Ns,1);
pvec1 = zeros(Ns,1);
ivec1 = zeros(Ns,1);

Gs = [sH; sL];
Ps = [1-pH pH; 1-pL pL]; 

crit = 1e-10;
diff = 1e+4;

while(diff>crit)

    for is = 1:Ns

        s0 = Gs(is);

        ey = Ps(is,:)*yvec0;
        epi = Ps(is,:)*pvec0;

        i0 = max(0, rstar + phi*epi);
        y0 = ey - (i0 - epi - s0);
        p0 = kap*y0 + bet*epi;

        yvec1(is,1) = y0;
        pvec1(is,1) = p0;
        ivec1(is,1) = i0;

    end
    
    ydiff = max(abs(yvec1-yvec0));
    pdiff = max(abs(pvec1-pvec0));
    idiff = max(abs(ivec1-ivec0));
    diff = max([ydiff pdiff idiff])

    yvec0 = yvec1;
    pvec0 = pvec1;
    ivec0 = ivec1;
    
end

ivec0

save pfmat_ph0.01sL2.5.mat yvec0 pvec0 ivec0;
