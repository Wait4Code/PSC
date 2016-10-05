function sig_bruite=ligne(sig_mod,h)
%{
    Operation : signal * h + AWGN + bruit colore


---PARAMS---
sig_mod     [vecteur]   signal modulé issu du modulateur
h           [vecteur]   fonction de transfert de la ligne

---RETURN---
sig_bruite  [vecteur] signal en sortie de ligne

%}


snr=40; %SNR voulu pour le bruit blanc sur la ligne

sig_att = conv2(sig_mod,h); %atténuation du signal par la ligne
t=0:1:247;
sig_bruite_ponc = sig_att-sin(t); %bruit ponctuel à une fréquence donnée
sig_bruite = awgn(sig_bruite_ponc,snr); %bruitage blanc
sig_bruite = sig_bruite_ponc