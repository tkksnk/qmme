% cagan's model

clear all;

alpha = 0.25
mu = 0.02

per = 10; % length of simulation
pai = zeros(per,1); % inflation
eps = zeros(per,1); % shock to ms

eps(1) = 0.01;

for t = 1:per
    
    pai(t+1) = -alpha/(1-alpha)*pai(t) + 1/(1-alpha)*(mu+eps(t))
    
end

figure;
plot([1:per],pai(2:per+1));
hold on;
plot([1:per],[mu+eps(1); mu*ones(per-1,1)],'r--');
legend('Adaptive','Rational');