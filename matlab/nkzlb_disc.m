clear all;

beta = 0.99;
sigma = 1.0;
vphi = 5;
eps = 9;
theta = 3/4;
phip = 1.5;
phiy = 0.5/4;
rhov = 0.5;
rhoa = 0.9;
eta = 4;
alpha = 0;

lambda = (1-theta)*(1-beta*theta)/theta;
kappa = lambda*(sigma+vphi);

rho = -log(beta);

A = [1 1/sigma; 
    kappa beta+kappa/sigma];
B = [1/sigma; 
    kappa/sigma];

T = 11;
xvec = zeros(T+1,1);
pvec = zeros(T+1,1);
ivec = zeros(T+1,1);

Tz = 5;

for t = Tz+1:-1:1
    
    temp = A*[xvec(t+1); pvec(t+1)] - B*rho;
    xvec(t) = temp(1);
    pvec(t) = temp(2);
    
end
