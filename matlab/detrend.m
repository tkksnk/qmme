clear all;

% load data
usdata;

% calculate the Solow residual
THETA = 0.36; % capital share
time = [1959:2010]';
tfp = log(gdp) - THETA*log(capital) - (1-THETA)*log(hours);

T = size(time,1); % length of data
y = tfp;

% linear trend
X = zeros(T,2);
X(:,1) = ones(T,1);
X(:,2) = time;

% OLS estimate
beta = inv(X'*X)*X'*y
ahat = y - X*beta;

figure;
plot(time,tfp);
hold on;
plot(time,X*beta); % fitted trend

figure;
plot(time,ahat);