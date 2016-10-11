% Exemple de cycle émission/réception.


%%%%%%%%%%%%%%%%%%
% Initialisation %
%%%%%%%%%%%%%%%%%%
longueur_ligne=3000;
diametre_ligne=0.0005;
% préciser nombre de canaux
nb_canaux= 256; %nombre de canaux en downstream
% récupération de la réponse impulsionnelle du canal
h_canal=f_transfert(longueur_ligne, diametre_ligne);
% taille préfixe cyclique
pref_cyclique=length(h_canal)+1;
% generateur crc
generateur_crc=[1 0 1 1 1 0 0 0 1];



%%%%%%%%%
% Cycle %
%%%%%%%%%

% Evaluation de la ligne et allocation des bits
[H_moy,H_moy_abs,SNR]=eval_canaux(nb_canaux,h_canal,pref_cyclique); 
bits_canal= allocation_bits(SNR);

taille_sous_trame=sum(bits_canal);

% calcule nb de bits initiale à generer %
nb_bit_init = taille_sous_trame*68 - (8*(240-224))*(floor(taille_sous_trame/(8*240)));% enlever les bits de rs
nb_bit_init = nb_bit_init - (length(generateur_crc)-1); % enlever les bits de crc.
nb_bit_init = nb_bit_init -12 %interlever bits

 % --Création de la suite de bits à transmettre
 bits_envoyes=gene_bits(nb_bit_init,0.5) % suite de bits à transmettre

% modulation/transmission/démodulation
supertrame = traitement_supertrame( bits_envoyes, generateur_crc, bits_canal, pref_cyclique);%generateur crc??
supertrame_recue=simu_canal(supertrame,h); % Transmission sur le canal ATTENTION: supertrame est un tableau de 68 sous-trames (signal en temps)

suite_bits_supertrame=[];
for i= 1:68 %68 sous-trame dans 1 supertrame
    [suite_bits_out,x_demod]=demodulationDMT(supertrame_recue(i),H_moy,nb_canaux,pref_cyclique,bits_canal); % Démodulation DMT (suppression du PC, parallélisation, FFT, égalisation et sérialisation)
    suite_bits_supertrame= [suite_bits_supertrame suite_bits_out];
end
    suite_bits_final=desassemblage_supertrame(suite_bits_supertrame);
    plot(suite_bits_final); %bits reçu
    plot(bits_envoyers);
    


