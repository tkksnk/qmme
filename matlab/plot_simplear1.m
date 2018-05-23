clear all;

load pfmatZLB yvec0 pivec0 rnvec0;
yvec0ZLB = yvec0;
pivec0ZLB = pivec0;
rnvec0ZLB = rnvec0;
load pfmatNOZLB yvec0 pivec0 rnvec0;
yvec0NOZLB = yvec0;
pivec0NOZLB = pivec0;
rnvec0NOZLB = rnvec0;

figure;
subplot(231);
plot(rnvec0ZLB*4); % annual value
hold on;
plot(rnvec0NOZLB*4); % annual value
subplot(232);
plot(yvec0ZLB);
hold on;
plot(yvec0NOZLB);
subplot(233);
plot(pivec0ZLB*4); % annual value
hold on;
plot(pivec0NOZLB*4); % annual value