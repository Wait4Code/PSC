l=500;
d=0.0005;
D=3*d/2;
ep=8.854187e-12*1.5;%permittivité vide * permittivé du relative
u0=4*pi*1e-7;
sigma=5.65e7;%en Ohm-1.m-1
f=0:100:1.1e6;

R=sqrt(u0/(pi*sigma))/(d*sqrt(1-(d/D)^2));
L=u0/pi*log(2*D/d);
C=pi*ep/log(2*D/d);

alphaN=R/2*sqrt(C/L);
betaN=2*pi*sqrt(L*C);


alpha=alphaN*sqrt(f);
beta=betaN*f;
gamma=(alpha + 1i*beta);
H=exp(-gamma*l);
plot(f,abs(H));
h=ifft(H);
