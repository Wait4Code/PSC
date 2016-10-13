%fonction de transfert du canal
h=f_transfert(3000,0.0005);
f1=1;
f2=100;
f3=200;
t=0:0.001:10*pi*2;

sig1=sin(f1*2*pi*t);
sig2=sin(f2*2*pi*t);
sig3=sin(f3*2*pi*t);

sig=sig1+sig2+sig3;

SIG=fft(sig);
%SIG=SIG(1:95);



%Se : signal en sortie de ligne
Se=ligne(sig,h(1:60),10);
%{
figure(1)
plot(sig)
title('Signal modulé');

figure(2)
plot(Se);
title('Signal en sortie de ligne');
%}
figure(3)
plot(abs(SIG));
title('FFT signal modulé');

figure(4)
SE=fft(Se);
plot(abs(SE));
title('FFT en sortie de ligne');

%{
figure(5)
plot(abs(h));
title('R�ponse impulsionnelle du canal');
%}