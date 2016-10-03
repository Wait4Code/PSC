function sig_bruite=ligne(sig_mod,h,snr)
%{
    Operation : signal * h + AWGN + bruit colore


---PARAMS---
sig_mod     [vecteur]   signal modulé issu du modulateur
h           [vecteur]   fonction de transfert de la ligne
snr         [entier]    valeur du SNR souhaité par canal en dB

---RETURN---
sig_bruite  [vecteur] signal en sortie de ligne
%}




sig_att = conv2(sig_mod,h);
sig_bruite = awgn(sig_att,snr); 
sig_bruite=sig_att;
%{
t=0:0.1:6*pi;
sig=sin(t);
sig2=sin(2*t);

plot(t,sig);
sig_f=abs(fft(sig));
sig_f2=abs(fft(sig2));

sig_f=sig_f+sig_f2;
l=length(t);
f=100*(0:l/2-1)/l;
sig_f=sig_f(1:l/2);
figure(2);
plot(f,sig_f);

sig_i=abs(ifft(sig_f));
figure(3);
plot(f,sig_i);

snr=1;
for i = 1:length(sig_i) 
    sig_i(i)=awgn(sig_i(i),snr);
    snr=snr+i*2*snr*10;
end

figure(5);
plot(f,abs(ifft(sig_f)));
%}
