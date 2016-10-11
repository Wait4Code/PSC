%fonction de transfert du canal
h=f_transfert(3000,0.0005);
t=0:0.1:6*pi;
sig1=sin(t);
sig2=sin(1e5*t);
sig3=sin(1e10*t);



sig=sig1%+sig2+sig3;
SIG=fft(sig);
%SIG=SIG(1:95);




%Se : signal en sortie de ligne
Se=ligne(sig,h(1:60));
figure(1)
plot(sig)
title('Signal modulé');
figure(2)
plot(abs(SIG));
title('FFT signal modulé');
figure(3)
plot(Se);
title('Signal en sortie de ligne');
figure(4)
SE=fft(Se);
plot(abs(SE));
title('FFT en sortie de ligne');
figure(5)
plot(abs(h));