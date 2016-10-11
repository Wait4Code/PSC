% Exemple de cycle émission/réception.


%%%%%%%%%%%%%%%%%%
% Initialisation %
%%%%%%%%%%%%%%%%%%
longueur_ligne=3000;
diametre_ligne=0.0005;
% préciser nombre de canaux
nb_canaux= 225; %nombre de canaux en downstream
% récupération de la réponse impulsionnelle du canal
h_canal=f_transfert(longueur_ligne, diametre_ligne);
% taille préfixe cyclique
pref_cyclique=length(h_canal);


%%%%%%%%%
% Cycle %
%%%%%%%%%

% Evaluation de la ligne et allocation des bits
[H_moy,H_moy_abs,bruit_moy_abs,SNR]=eval_canaux(nb_canaux,h_canal,pref_cyclique); % A voir les variables récupérées
bits_canal= allocation_bits(SNR);

% Création de la suite de symboles à transmettre

 % --Création de la suite de bits à transmettre : somme du tableau
 % d'allocation des bits * 68  (plot la suite de bits)
 %!!!!!!!!!!!!nb de bits tres grand, faut tenir compte du nb de bit que le les crc et rs va ajouter!!!!!!!!!!!!!!%
 bits_envoyes=gene_bits(sum(bits_canal)*68,0.5) % suite de bits à transmettre

% Exécution du cycle modulation/transmission/démodulation
%!!!!!!!!!!! generateur crc non initialisé!!!!!!!!!!!!!%
supertrame = traitement_supertrame( bits_envoyes, generateur_crc, bits_canal, prefixe_cyclique);%generateur crc??
supertrame_trans=simu_canal(supertrame,h); % Transmission sur le canal ATTENTION: supertrame est un tableau de 68 sous-trames (signal en temps)
suite_bits_supertrame=[];
for i= 1:68 %68 sous-trame dans 1 supertrame
    [suite_bits_out,x_demod]=demodulationDMT(supertrame_trans(i),H_moy,nb_canaux,pref_cyclique,bits_canal); % Démodulation DMT (suppression du PC, parallélisation, FFT, égalisation et sérialisation)
    suite_bits_supertrame= [suite_bits_supertrame suite_bits_out];
end
    suite_bits_final=desassemblage_supertrame(suite_bits_supertrame);
    disp(suite_bits_out); %bits reçu
    plot(suite_bits_out);
    erreurs=sum(xor(suite_bits_in,suite_bits_out)) %nombre d'erreurs dans la sous-trame i

%
