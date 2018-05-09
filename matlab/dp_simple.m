% successive approximation for cake-eating problem
% October 2015, Takeki Sunakawa

clear all;

bet = 0.9;

nw = 1001;
wgrid = linspace(0.0,1.0,nw)';
wgrid(1) = wgrid(2)/10; % avoid w=c=0

% analytical solution
B = 1/(1-bet);
A = (bet*B*log(bet*B)-(1+bet*B)*log(1+bet*B))/(1-bet);
vvec = A + B*log(wgrid); % value function
wvec = bet*wgrid; % policy function

% numetical solution using the VFI
vvec0 = zeros(nw,1); %log(wgrid);
vvec1 = vvec0;
wvec1 = wgrid;

diff = 1e+4;
iter = 0;

while(diff>1e-4)

    % iw = 1
    vvec1(1) = log(wgrid(1)) + bet*vvec0(1);

    for iw = 2:nw

        wnow = wgrid(iw); % scalar
        wp1 = wgrid(1:iw-1); % jwx1 vector: jw = iw-1
        cc = wnow-wp1; % jwx1 vector
        % pick kw
        [vp kw] = max(log(cc) + bet*vvec0(1:iw-1));
        %if (iw==10); pause; end;
        vvec1(iw) = vp; % V(W)
        wvec1(iw) = wgrid(kw); % W'

    end

    diff = max(abs(vvec1-vvec0));
    iter = iter + 1;
    disp([iter diff]);
    vvec0 = vvec1; % update

end


figure;
subplot(211);
plot(wgrid,vvec); % analytical
hold on;
plot(wgrid,vvec1,'r--'); % numerical
%ylim([-40 0]);
subplot(212);
plot(wgrid,wvec,wgrid,wvec1);