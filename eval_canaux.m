function [H_moy,H_moy_abs,bruit_moy_abs,SNR]=eval_canaux(nb_canaux,h_reel,pref_cycl)

% L'objectif est de calculer le SNR de chaque canal et de récupérer le
% H_moy (H estimé)

% Initialiser les variables
SNR=[];
H=zeros(1,nb_canaux);
H_moy=[];
bruit= zeros(1,nb_canaux); 
bruit_moy=[];

% Construction d'une trame de test 

vect_alloc=2*ones(1,nb_canaux); % Tableau d'allocation des bits avec 2 bits par canaux pour l'evaluation
suite_bits=gene_bits(2*nb_canaux,0.5); % Génération des bits
for i= 0:nb_canaux-1 
    suite_symb(i+1)=codage_symb(suite_bits(1+i*2:i*2+2),4); % Génération de la valeur décimale des symboles
    suite_symb_QAM(i+1)=modulationQAM(suite_symb(i+1),4); % Génération des coordonnées complexe des symboles 
end
    

%Calcul des coefficient Hk

for k=1:nb_canaux
    message= sprintf('canal %d \n',k);
    disp(message);
    for i=1:30 %On envoit 30 trames de test
        x_mod=modulationDMT(suite_symb_QAM,nb_canaux,pref_cycl);
        x_mod_trans=ligne(x_mod,h_reel);
        [suite_bits_recu,x_recu]=demodulationDMT(x_mod_trans,ones(1, nb_canaux), nb_canaux,pref_cycl,vect_alloc);
        x_recu_total(i)= x_recu(k);
        H(k)=H(k)+x_recu(k)/suite_symb_QAM(k);
    end
        
    H_moy(k)= H(k)/30;
    message= sprintf('H_moy du canal %d =',k);
    disp(message);
    disp(H_moy(k));
%Calcule du bruit

    for i=1:30
        bruit(k)=bruit(k) + (x_recu_total(i)-H_moy(k)*suite_symb(k));
    end 
   
    bruit_moy(k)=bruit(k)/30;
    message= sprintf('bruit_moy du canal %d =',k);
    disp(message);
    disp(bruit_moy(k));
end
suite_symb_abs(k)= abs(suite_symb(k)).^2
H_moy_abs(k)=abs(H_moy(k)).^2
bruit_moy_abs(k)=abs(bruit_moy(k)).^2

%Calcule du SNR
    
for k=1:nb_canaux
    SNR(k)=suite_symb_abs(k)*H_moy_abs(k)/bruit_moy_abs(k);
end
message= sprintf('SNR des canaux =');
disp(message);
disp(SNR);
        


