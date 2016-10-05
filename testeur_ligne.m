%fonction de transfert du canal
h=f_transfert(3000,0.0005);

t=0:0.1:6*pi;
sig1=sin(1e10*t);
sig2=sin(t);
sig3=sin(1e5*t);

sig=sig1+sig2+sig3;
SIG=fft(sig);
SIG=SIG(1:95);

%Se : signal en sortie de ligne
Se=ligne(SIG,h);
figure(1)
plot(abs(SIG))
figure(3)
plot(abs(fft(abs(SIG))));
figure(2)
plot(abs(Se));