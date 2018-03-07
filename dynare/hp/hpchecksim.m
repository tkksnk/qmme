% check simulated data

% from FRED_data.xls
hpreal = [90.0 	1.78 	0.0528 % 1984
91.4 	1.78 	0.0552
91.7 	1.80 	0.0612
92.9 	1.80 	0.0597
95.8 	1.80 	0.0625
97.5 	1.80 	0.0601
100.0 	1.86 	0.0599
100.5 	1.90 	0.0582
98.7 	1.99 	0.0512
96.1 	2.07 	0.0504
94.0 	2.13 	0.0442
92.8 	2.16 	0.0390
95.3 	2.12 	0.0519
94.7 	2.15 	0.0513
90.4 	2.30 	0.0435
88.4 	2.34 	0.0429
87.6 	2.36 	0.0397]; %2000

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