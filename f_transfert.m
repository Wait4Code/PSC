function h=f_transfert(l,d)
%{
    Calcul de la fonction de transfert de la ligne
    l [entier]      longueur de la ligne
    d [flottant]    diametre du cable
%}
%definition des variables
D=3*d/2; %epaisseur de l'isolant
ep=8.854187e-12*1.5;%permittivité vide * permittivé du relative
u0=4*pi*1e-7;
sigma=5.65e7;%en Ohm-1.m-1
f=0:4312.5:1.104e6; %freqences de l'ADSL1

%La ligne est un flitre RLC (G est négligeable)
R=sqrt(u0/(pi*sigma))/(d*sqrt(1-(d/D)^2));
L=u0/pi*log(2*D/d);
C=pi*ep/log(2*D/d);

%calcul de alpha et de beta
alphaN=R/2*sqrt(C/L);
betaN=2*pi*sqrt(L*C);

%Calcul du vecteur H (frequentiel)
alpha=alphaN*sqrt(f);
beta=betaN*f;
gamma=(alpha + 1i*beta);
H=exp(-gamma*l);

%ajout du symetrique de la réponse en frequence pour avoir un h(t)
%périodique
H=[H 0 conj(fliplr(H(2:length(H)-1)))];
%Passage en temporel
h=abs(ifft(H));
h=h(1:100);
plot(h);