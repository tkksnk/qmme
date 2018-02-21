clear all;

% load data
usdata;

% calculate the Solow residual
THETA = 0.36; % capital share
time = [1959:2010]';
tfp = log(gdp) - THETA*log(capital) - (1-THETA)*log(hours);

T = size(time,1); % length of data
y = tfp;

% HP filter: F matrix
F = zeros(T,T);
F(1,1) = 1;
F(1,2) = -2;
F(1,3) = 1;

F(2,1) = -2;
F(2,2) = 5;
F(2,3) = -4;
F(2,4) = 1;

for i=3:T-2

F(i,1+(i-3)) = 1;
F(i,2+(i-3)) = -4;
F(i,3+(i-3)) = 6;
F(i,4+(i-3)) = -4;
F(i,5+(i-3)) = 1;
    
% F(3,1) = 1;
% F(3,2) = -4;
% F(3,3) = 6;
% F(3,4) = -4;
% F(3,5) = 1;

% F(4,2) = 1;
% F(4,3) = -4;
% F(4,4) = 6;
% F(4,5) = -4;
% F(4,6) = 1;

end

F(T-1,T-3) = 1;
F(T-1,T-2) = -4;
F(T-1,T-1) = 5;
F(T-1,T) = -2;

F(T,T-2) = 1;
F(T,T-1) = -2;
F(T,T) = 1;

lambda = 100; % smoothing parameter
trend = inv(eye(T)+lambda*F)*y; % 21 Feb 2018: I had a typo here
c = y-trend;

figure;
plot(time,y);
hold on;
plot(time,trend); % fitted trend

figure;
plot(time,c);
