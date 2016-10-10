function [H_moy,H_moy_abs,bruit_moy,SNR]=eval_canaux(nb_canaux,h_reel,pref_cycl)

% L'objectif est de calculer le SNR de chaque canal et de récupérer le
% H_moy (H estimé)

% Initialiser les variables
SNR=[];
H=zeros(1,nb_canaux);
H_moy=[];
bruit= zeros(1,nb_canaux); 
bruit_moy=[];
nb_trame_test=1;

% Construction d'une trame de test 

vect_alloc=2*ones(1,nb_canaux); % Tableau d'allocation des bits avec 2 bits par canaux pour l'evaluation
suite_bits=gene_bits(2*nb_canaux,0.5); % Génération des bits
disp(suite_bits);
for i= 0:nb_canaux-1 
    suite_symb(i+1)=codage_symb(suite_bits(1+i*2:i*2+2),4); % Génération de la valeur décimale des symboles
    suite_symb_QAM(i+1)=modulationQAM(suite_symb(i+1),4); % Génération des coordonnées complexe des symboles 
end
    

%Calcul des coefficient Hk

for k=1:nb_canaux
    message= sprintf('canal %d \n',k);
    disp(message);
    for i=1:nb_trame_test %On envoit 30 trames de test
        %disp('symboles envoyes');
        %disp(suite_symb_QAM);
        x_mod=modulationDMT(suite_symb_QAM,nb_canaux,pref_cycl);
        if (k==100)
            figure;
            plot(real(x_mod));
            title( sprintf('x_mod channel %d',  k ) );
            disp(mean(imag((x_mod)).^2)/mean(real((x_mod)).^2));
        end
        x_mod_trans=ligne(x_mod,h_reel);
        if (k==100)
            figure;
            plot(real(x_mod_trans));
            title( sprintf('x_mod_trans channel %d', k ) );
        end
        %disp(real(x_mod_trans));
        [suite_bits_recu,X_recu]=demodulationDMT(x_mod_trans,ones(1, nb_canaux), nb_canaux,pref_cycl,vect_alloc);
        %disp('symboles recus');
        %disp(x_recu);
        %disp(suite_bits_recu);
        x_recu_total(i)= X_recu(k);
        H(k)=H(k)+X_recu(k)/suite_symb_QAM(k);
    end
        
    H_moy(k)= H(k)/nb_trame_test;
    %message= sprintf('H_moy du canal %d =',k);
    %disp(message);
    %disp(H_moy(k));
%Calcule du bruit

    for i=1:nb_trame_test
        bruit(k)=bruit(k) + (abs(x_recu_total(i))^2-abs(H_moy(k))^2*abs(suite_symb_QAM(k))^2);
        
         
        %disp('toto=');
        %disp( bruit );
    end 
   
    bruit_moy_carre(k) = bruit(k)/nb_trame_test;
    %message= sprintf('bruit_moy du canal %d =',k);
    %disp(message);
    %disp(bruit_moy(k));
end


suite_symb_abs= abs(suite_symb_QAM).^2;
H_moy_abs=abs(H_moy).^2;
figure();
plot(H_moy_abs);
bruit_moy=sqrt(bruit_moy_carre).^2

%Calcule du SNR
    
for k=1:nb_canaux
    SNR(k)=suite_symb_abs(k)*H_moy_abs(k)/bruit_moy(k);
    %SNR=[ 10 5 0 500 1000000000 ];
end
%message= sprintf('SNR des canaux =');
%disp(message);
%disp(SNR);
