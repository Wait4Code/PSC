% Exemple de cycle émission/réception.


%%%%%%%%%%%%%%%%%%
% Initialisation %
%%%%%%%%%%%%%%%%%%

% préciser nombre de canaux
nb_canaux= 225; %nombre de canaux en downstream
% taille préfixe cyclique

%???????????????

% récupération de la réponse impulsionnelle du canal
h_canal=f_transfert();

%%%%%%%%%
% Cycle %
%%%%%%%%%

% Evaluation de la ligne et allocation des bits
[H_moy,H_moy_abs,bruit_moy_abs,SNR]=eval_canaux(nb_canaux,h_canal,pref_cyclique); % A voir les variables récupérées
bits_canal= allocation_bits(SNR);

% Création de la suite de symboles à transmettre

 % --Création de la suite de bits à transmettre : somme du tableau
 % d'allocation des bits * 68  (plot la suite de bits)
 bits_envoyes=gene_bits(sum(bits_canal)*68,0.5) % suite de bits à transmettre 

% Exécution du cycle modulation/transmission/démodulation
supertrame = traitement_supertrame( bits_envoyes, generateur_crc, bits_canal, prefixe_cyclique);%generateur crc??
supertrame_trans=simu_canal(supertrame,h); % Transmission sur le canal ATTENTION: supertrame est un tableau de 68 sous-trames (signal en temps)
for i= 1:68 %68 sous-trame dans 1 supertrame
    [suite_bits_out,x_demod]=demodDMT_egal(supertrame_trans(i),h_eval_mod,nb_canaux,pref_cycl,tab); % D�modulation DMT (suppression du PC, parall�lisation, FFT, �galisation et s�rialisation)
    disp(suite_bits_out); %bits reçu 
    plot(suite_bits_out);
    erreurs=sum(xor(suite_bits_in,suite_bits_out)) %nombre d'erreurs dans la sous-trame i
end
%