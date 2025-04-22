clearvars
close all
clc
w = -15*pi:0.01:15*pi;
RC = 0.1;
G = (1i*w*RC)./(1+1i*w*RC);
figure
subplot(4,1,1)
plot(w,abs(G))
ylim([0 1.5])
xlim([-15*pi 15*pi])
xticks([-1/RC 0 1/RC])
xticklabels({'-1/RC','0','1/RC'})
title('|G(jw)|')
subplot(4,1,2)
plot(w,angle(G))
xlim([-15*pi 15*pi])
xticks([-1/RC 0 1/RC])
xticklabels({'-1/RC','0','1/RC'})
title('∠G(jw)')
subplot(4,1,3)
plot(w,real(G))
ylim([0 1.5])
xlim([-15*pi 15*pi])
xticks([-1/RC 0 1/RC])
xticklabels({'-1/RC','0','1/RC'})
title('Re[G(jw)]')
subplot(4,1,4)
plot(w,imag(G))
xlim([-15*pi 15*pi])
xticks([-1/RC 0 1/RC])
xticklabels({'-1/RC','0','1/RC'})
title('Im[G(jw)]')
