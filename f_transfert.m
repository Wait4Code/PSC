%{
    Calcul de la fonction de transfert de la ligne
%}
l=3000; %longueur de la ligne
d=0.0005; %diametre du cable
D=3*d/2; %epaisseur de l'isolant
ep=8.854187e-12*1.5;%permittivité vide * permittivé du relative
u0=4*pi*1e-7;
sigma=5.65e7;%en Ohm-1.m-1
f=0:4312.5:1.104e6; %freqences de l'ADSL1

R=sqrt(u0/(pi*sigma))/(d*sqrt(1-(d/D)^2));
L=u0/pi*log(2*D/d);
C=pi*ep/log(2*D/d);

alphaN=R/2*sqrt(C/L);
betaN=2*pi*sqrt(L*C);


alpha=alphaN*sqrt(f);
beta=betaN*f;
gamma=(alpha + 1i*beta);
H=exp(-gamma*l);

%ajout du symetrique de la réponse en frequence pour avoir un h(t)
%périodique
symetrique=fliplr(conj(H));
H=[H symetrique];

%figure(1);
%plot(abs(H));
h=abs(ifft(H));
%figure(2);
%plot(h);

