% Blanchard and Khan's method 
% with stochastic neoclassical growth model (with fixed labor)
clear all;

beta = 0.99;
alpha = 0.36;
delta = 0.10/4;
rho = 0.95;
sigma = 0.00712;

ykss = (alpha*beta/(1-beta*(1-delta)))^(-1);
khss = (alpha*beta/(1-beta*(1-delta)))^(1/(1-alpha));
ckss = ykss-delta;
hss = 1;
kss = khss*hss;
yss = ykss*kss;
css = ckss*kss;

cck = -beta*alpha*(1-alpha)*ykss;
cca = beta*alpha*ykss;
ckc = ckss;
ckk = 1/beta;
cka = ykss;

% Blanchard-Khan
m = 2;
n = 1;

B = zeros(3,3);
A = zeros(3,3);
G = zeros(3,1);

B(1,1) = 1;
B(2,1) = -cca*rho;
B(2,2) = -cck;
B(2,3) = 1;
B(3,1) = -cka;
B(3,2) = 1;

A(1,1) = rho;
A(2,3) = 1;
A(3,2) = ckk;
A(3,3) = -ckc;

G(1,1) = 1;

% algorithm part
Z = inv(B)*A;
[M Lambda] = eig(Z);

% reorder
Lambda = diag(Lambda);
[Lam_sorted index] = sort(Lambda);
M = M(:,index);

Mhat = inv(M);
M11 = Mhat(1:m,1:m);
M12 = Mhat(1:m,m+1:m+n);
M21 = Mhat(m+1:m+n,1:m);
M22 = Mhat(m+1:m+n,m+1:m+n);
Lam11 = diag(Lam_sorted(1:m));
Lam22 = diag(Lam_sorted(m+1:m+n));
G = Mhat*inv(B)*G;
G1 = G(1:m);
G2 = G(m+1:m+n);
N = M11-M12*inv(M22)*M21;

% answer
% y_t = g(x_t,eps_t)
-inv(M22)*M21
-inv(M22)*inv(Lam22)*G2

% x_t+1 = h(x_t,eps_t)
inv(N)*Lam11*N
-inv(N)*(Lam11*M12*inv(M22)*inv(Lam22)*G2-G1)