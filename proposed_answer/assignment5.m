% successive approximation for neoclassical growth model
% October 2015, Takeki Sunakawa

clear all;

bet = 0.96;
the = 0.36;
del = 1.0;

kss = (the*bet/(1-bet*(1-del)))^(1/(1-the));
css = kss^the-del*kss;

nk = 1001;
kgrid = linspace(0.3*kss,2.0*kss,nk)';

% analytical solution with del = 1;
B = the/(1-the*bet);
A = (log(1/(1+bet*B))+bet*B*log(bet*B/(1+bet*B)))/(1-bet);
vvec = A + B*log(kgrid);
kvec = the*bet*kgrid.^the;

% numetical solution using the VFI
kind = ones(nk,1);

for ik = 1:nk

    know = kgrid(ik);
    yterm = know^the + (1-del)*know;

    % c+kp=know^the and c>0 implies kp<know^the         
    for kk = 1:nk

        kp = kgrid(kk);
        if (kp>=yterm); break; end;

    end
    
    kind(ik) = kk-1;
    
end

vvec0 = log(kgrid);
vvec1 = vvec0;
kvec1 = kgrid;

diff = 1e+4;
iter = 0;

while(diff>1e-4)

    for ik = 1:nk

        know = kgrid(ik);
        yterm = know^the + (1-del)*know;
                
        kp1 = kgrid(1:kind(ik));
        [vp jk] = max(log(yterm-kp1) + bet*vvec0(1:kind(ik))); 
        vvec1(ik) = vp;
        kvec1(ik) = kgrid(jk);

    end

    diff = max(abs(vvec1-vvec0));
    iter = iter + 1;
    disp([iter diff]);
    vvec0 = vvec1;

end


figure;
subplot(211);
plot(kgrid,vvec,kgrid,vvec1);
% ylim([-40 0]);
subplot(212);
plot(kgrid,kvec,kgrid,kvec1);