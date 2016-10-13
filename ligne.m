function sig_fin_de_ligne=ligne(sig_mod,h,snr,filtre_ponc)
%{
    Operation : signal * h + AWGN + bruit ponctuel
    ce dernier �tant repr�sent� par un filtre bande stop pass�
    en argument


---PARAMS---
sig_mod             [vecteur]   signal modulé issu du modulateur
h                   [vecteur]   fonction de transfert de la ligne
snr                 [entier]    SNR du le bruit blanc sur la ligne dB
filtre_ponc         [objet]     objet filtre bande stop mettre false pour 
                                annuler son effet.

---RETURN---
sig_bruite  [vecteur] signal en sortie de ligne

%}

sig_att = conv2(sig_mod,h); %att�nuation du signal par la ligne
sig_bruite_blanc = awgn(sig_att, snr, 'measured'); %bruitage blanc

if filtre_ponc == false
    sig_fin_de_ligne = sig_bruite_blanc;
else
    sig_fin_de_ligne = filter(filtre_ponc,sig_bruite_blanc);
end

