function [H_moy,H_moy_abs,bruit_moy_abs,SNR]=eval_canaux2(nb_canaux,h_reel,pref_cycl)
%UNTITLED Summary of this function goes here
%   L'objectif est de calculer le SNR de chaque canal
% Initialiser les variables
SNR=[];
H=zeros(1,nb_canaux);
H_moy=[];
bruit= zeros(1,nb_canaux);
bruit_moy[];

% Construction d'une trame de test

vect_alloc=2*ones(1,nb_canaux); %2 bits par symbole
suite_bits=gene_bits(2*nb_canaux,0.5); %génération des bits
suite_symb=gene_symb(suite_bits,vect_alloc);

%Calcul des coefficient Hk

for k=1:nb_canaux
    for i=1:30 %On envoit 30 trames de test
        x_mod=modulationDMT(suite_symb,nb_canaux,pref_cycl);
        x_mod_trans=canal(c_mod,h_reel);
        [suite_bits_recu,x_recu]=demodulationDMT(x_mod_trans, nb_canaux,pref_cycl,vect_alloc);
        x_recu_total(i)= x_recu(k);
        H(k)=H(k)+x_recu(k)/suite_symb;

    end

    H_moy(k)= H(k)/30;

%Calcule du bruit

    for i=1:30
        bruit(k)=bruit(k) + (x_recu_total(i)-H_moy(k)*x_mod_trans)
    end

    bruit_moy(k)=bruit(k)/30;
end
suite_symb_abs(k)= abs(suite_symb(k)).^2
H_moy_abs(k)=abs(H_moy(k)).^2
bruit_moy_abs(k)=abs(bruit_moy(k)).^2

%Calcule du SNR

for k=1:nb_canaux
    SNR[k]=suite_symb_abs(k)*H_moy_abs(k)/noise_moy_abs(k);
end
