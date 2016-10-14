% fonction de transfert du canal
h=f_transfert(3000,0.0005);
f1=1;
f2=100;
f3=200;
f4=300;
t=0:0.001:10*pi*2;
sig1=sin(pi*f1*t);
sig2=sin(pi*f2*t);
sig3=sin(pi*f3*t);
sig4=sin(2*pi*f4*t);
sig=sig1+sig2+sig3;
SIG=fft(sig);

% paramétres du filtre bande stop
Fs=400; % doit être égal à 2 fois la fréquence max
Fpass1=50;
Fstop1=75;
Fstop2=125;
Fpass2=150;

Hbp=filtre_bruit_ponc(Fs,Fpass1,Fstop1,Fstop2,Fpass2);

% Exemple en mettant false, pas de bruit ponctuel :
% Se=ligne(sig,h(1:60),10,false);
Se=ligne(sig,h(1:60),10,Hbp);

figure(1)
plot(sig)
title('Signal modulé');

figure(2)
plot(Se);
title('Signal en sortie de ligne');

figure(3)
plot(abs(SIG));
title('FFT signal modulé');

figure(4)
SE=fft(Se);
plot(abs(SE));
title('FFT en sortie de ligne');

figure(5)
plot(abs(h));
title('Réponse impulsionnelle du canal');
