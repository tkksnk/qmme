% check simulated data

% from FRED_data.xls
hpsim = [96.71833 	1.91934 	0.05180 % 1990
98.73140 	1.92958 	0.05127 
97.73048 	2.01258 	0.04725 
97.24424 	2.06381 	0.04493 
94.55080 	2.14962 	0.04129 
92.60841 	2.19668 	0.03941 
97.82000 	2.07043 	0.04464 
98.30862 	2.10028 	0.04335 
91.28288 	2.31692 	0.03497 
92.01655 	2.28883 	0.03596 
89.35745 	2.35648 	0.03360 
88.24091 	2.37801 	0.03288 
86.99628 	2.39715 	0.03225 
85.74127 	2.41416 	0.03169 
84.48035 	2.42928 	0.03121 
83.21729 	2.44272 	0.03078 
81.95529 	2.45465 	0.03041]; % 2006

figure;
subplot(311);
plot([1984:2000],hpreal(:,1),'k-','LineWidth',2.0);
hold on;
%plot([1990:2006],hpsim(:,1),'k--','LineWidth',2.0);
plot([1990:2006],mysim(:,1),'b--','LineWidth',2.0);
xlim([1984 2006]);
ylim([70 120]);
title('Detrended y');

subplot(312);
plot([1984:2000],hpreal(:,2),'k-','LineWidth',2.0);
hold on;
%plot([1990:2006],hpsim(:,2),'k--','LineWidth',2.0);
plot([1990:2006],mysim(:,2),'b--','LineWidth',2.0);
xlim([1984 2006]);
ylim([1.50 2.75]);
title('Capital-output ratio');

subplot(313);
plot([1984:2000],hpreal(:,3),'k-','LineWidth',2.0);
hold on;
%plot([1990:2006],hpsim(:,3),'k--','LineWidth',2.0);
plot([1990:2006],mysim(:,3),'b--','LineWidth',2.0);
xlim([1984 2006]);
ylim([0.02 0.08]);
legend('actual','simulation');
title('After-tax rate of return');