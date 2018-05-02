clear all;

load nk_coth;
irfmat_coth = irfmat;
load nk_dith;
irfmat_dith = irfmat;

% plot graphs
T = 11;

for i = 1:2
% cost-push shock
xvec_coth  = irfmat_coth(1:T+1,1,i);
paivec_coth = irfmat_coth(1:T+1,2,i);
pvec_coth  = irfmat_coth(1:T+1,3,i);
uvec_coth  = irfmat_coth(1:T+1,4,i);
xvec_dith  = irfmat_dith(1:T+1,1,i);
paivec_dith = irfmat_dith(1:T+1,2,i);
pvec_dith  = irfmat_dith(1:T+1,3,i);
uvec_dith  = irfmat_dith(1:T+1,4,i);

figure;
subplot(221);
plot([0:T],xvec_coth,'gx-');
hold on;
plot([0:T],xvec_dith,'ro-');
xlim([-1 T+1]);
title('Output gap');
subplot(222);
plot([0:T],paivec_coth,'gx-');
hold on;
plot([0:T],paivec_dith,'ro-');
xlim([-1 T+1]);
title('Inflation');
subplot(223);
plot([0:T],pvec_coth,'gx-');
hold on;
plot([0:T],pvec_dith,'ro-');
xlim([-1 T+1]);
title('Price level');
subplot(224);
plot([0:T],uvec_coth,'k-');
xlim([-1 T+1]);
title('u');

end
