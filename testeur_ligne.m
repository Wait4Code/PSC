f_transfert

%Au démodulatateur, on a Se (Signal d'entrée)


t=0:0.1:6*pi;
sig1=sin(1e9*t);
sig2=sin(t);

sig=sig1+sig2;
SIG=fft(sig);
SIG=SIG(1:95);

Se=ligne(SIG,h,6);
figure(1)
plot(abs(SIG))
figure(2)
plot(abs(Se));
