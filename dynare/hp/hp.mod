// Replication of Figure 6-8 in:
// Hayashi and Prescott (2002) "The 1990s in Japan: A Lost Decade"
//
// Notes: Hours worked per worker is fixed at 40.
// October 2015 Takeki Sunakawa

var k c y e r w;
varexo gam ndot phi h;
parameters BETA THETA DELTA TAU ALPHA;

// calibrated parameters
THETA = 0.362;
DELTA = 0.089;
BETA  = 0.976;
TAU   = 0.480;
ALPHA = 1.373;

GAMMA = 1.0029; // average of A/A(-1) between 1990-2000
NDOT = 1.0;
gyss = 0.15; // average of G/Y between 1999-2000
hss = 40;

A1990 = 1.065030353; // A in 1990
y1990 = 53.13881308; // y in 1990 (incl. trend)
ky1990 = 1.856231415;

// steady state
rss  = (GAMMA/BETA-1)/(1-TAU)+DELTA;
ykss = rss/THETA;
ckss = (1-gyss)*ykss - (GAMMA*NDOT-1+DELTA);
ess = (1-THETA)/ALPHA*ykss/ckss;
kss = ykss^(1/(THETA-1))*hss*ess;
css = ckss*kss;
yss = ykss*kss;
rss = THETA*yss/kss;
wss = (1-THETA)*yss/hss/ess;

// initial k: detrended k in 1990
kst = ky1990*y1990/A1990^(1/(1-THETA));
ked = kss;


model;

ALPHA/40*c = (1-THETA)*y/(h*e);

gam = BETA*(c/c(+1))*(1+(1-TAU)*(r(+1)-DELTA));

c + gam*ndot*k - (1-DELTA)*k(-1) = (1-phi)*y;

y = k(-1)^THETA*(h*e)^(1-THETA);

r = THETA*y/k(-1);

w = (1-THETA)*y/(h*e);

end;

initval;

k = kss;
c = css;
y = yss;
e = ess;
r = rss;
w = wss;

gam = GAMMA;
ndot = NDOT;
phi = gyss;
h = hss;

end;

steady;

check;

initval;
k = kst;
end;

shocks;
var gam;  // A/A(-1)^(1/(1-THETA)
periods 1	2	3	4	5	6	7	8	9	10;
values 1.022943282	0.997995409	1.005410175	0.993062802	1.002088377	1.054384806	1.010066265	0.955406169	1.018129544	0.997920714;
var ndot; // N/N(-1)
periods 1	2	3	4	5	6	7	8	9	10;
values 1.013419587	1.010415651	1.009729573	1.007689552	1.007192454	1.00556464	1.003217353	1.002588951	1.000965442	1.000650754;
var phi;  // G/Y
periods 1	2	3	4	5	6	7	8	9	10;
values 0.135216358	0.141987	0.152582923	0.154330287	0.155302256	0.15583332	0.146668456	0.150725874	0.155155993	0.146232038;
end;

simul(periods=400);


SimT = 17; // 1990-2006

// TFP Trend
TFP = zeros(SimT,1);
TFP(1) = A1990;
TFP(2:11) = TFP(1)*cumprod(oo_.exo_simul(2:11,1)).^(1-THETA);
TFP(12:SimT) = TFP(11).*(GAMMA^(1-THETA)).^[1:1:SimT-11]';

// Construct linearly detrended y
y_trend = y(2:SimT+1).*TFP.^(1/(1-THETA));
// normalize by y in 1990 and remove 2% linear trend (as HP do)
y_detrend = 100*y_trend./(y1990*(1.02.^[0:1:SimT-1]'));

// (17x3) matrix with linearly detrended y, k/y and r (after tax and dereciation)
mysim = [y_detrend(1:SimT) k(1:SimT)./y(2:SimT+1) (1-TAU)*(r(2:SimT+1)-DELTA)];

// Compare the results
hpchecksim; 