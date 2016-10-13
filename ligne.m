function sig_fin_de_ligne=ligne(sig_mod,h,snr)
%{
    Operation : signal * h + AWGN + bruit colore


---PARAMS---
sig_mod     [vecteur]   signal modulé issu du modulateur
h           [vecteur]   fonction de transfert de la ligne
snr         [entier]    SNR voulu pour le bruit blanc sur la ligne dB
---RETURN---
sig_bruite  [vecteur] signal en sortie de ligne

%}


sig_att = conv2(sig_mod,h); %att�nuation du signal par la ligne
sig_bruite_blanc = awgn(sig_att,snr); %bruitage blanc
sig_fin_de_ligne = filter(filtre_bruit_ponc,sig_bruite_blanc);
