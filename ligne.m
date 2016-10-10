function sig_bruite=ligne(sig_mod,h)
%{
    Operation : signal * h + AWGN + bruit colore


---PARAMS---
sig_mod     [vecteur]   signal modul� issu du modulateur
h           [vecteur]   fonction de transfert de la ligne

---RETURN---
sig_bruite  [vecteur] signal en sortie de ligne

%}


snr=50; %SNR voulu pour le bruit blanc sur la ligne dB

sig_att = conv2(sig_mod,h); %att�nuation du signal par la ligne

sig_bruite = awgn(sig_att,snr); %bruitage blanc
%sig_bruite = sig_att;