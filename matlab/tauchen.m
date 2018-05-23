function [Z,Zprob] = tauchen(N,mu,rho,sigma,m)


Z     = zeros(N,1);
Zprob = zeros(N,N);
c     = (1-rho)*mu;

zmax  = m*sqrt(sigma^2/(1-rho^2));
zmin  = -zmax;
w = (zmax-zmin)/(N-1);

Z = linspace(zmin,zmax,N)';
Z = Z + mu;

for j = 1:N
    for k = 1:N
        if k == 1
            Zprob(j,k) = cdf_normal((Z(1)-c-rho*Z(j)+w/2)/sigma);
        elseif k == N
            Zprob(j,k) = 1 - cdf_normal((Z(N)-c-rho*Z(j)-w/2)/sigma);
        else
            Zprob(j,k) = cdf_normal((Z(k)-c-rho*Z(j)+w/2)/sigma) - ...
                         cdf_normal((Z(k)-c-rho*Z(j)-w/2)/sigma);
        end
    end
end


function c = cdf_normal(x)
    c = 0.5*erfc(-x/sqrt(2));

