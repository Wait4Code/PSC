% Exemple de cycle émission/réception.


%%%%%%%%%%%%%%%%%%
% Initialisation %
%%%%%%%%%%%%%%%%%%
longueur_ligne=3000;
diametre_ligne=0.0005;
% préciser nombre de canaux
nb_canaux= 256; %nombre de canaux
% récupération de la réponse impulsionnelle du canal
h_canal=f_transfert(longueur_ligne, diametre_ligne);
% taille préfixe cyclique
pref_cyclique=length(h_canal)+1;
% generateur crc
generateur_crc=[1 0 1 1 1 0 0 0 1];
snr_reel=20;
nombre_sous_trame=68;
bruit_selectif=false;   %filtre_bruit_ponc(2200,125,275);

% Cycle %
%%%%%%%%%

% Evaluation de la ligne et allocation des bits
[H_moy,H_moy_abs,SNR]=eval_canaux(nb_canaux,h_canal,pref_cyclique,snr_reel,bruit_selectif); 
table_alloc= allocation_bits(SNR);

taille_max_sous_trame=sum(table_alloc);
fprintf('taille maximale de la sous-trame:%d\n',taille_max_sous_trame);
fprintf('taille maximale de la supertrame:%d\n',taille_max_sous_trame*nombre_sous_trame);

% calcule nb de bits initial à generer %

nb_bit_init = taille_max_sous_trame*nombre_sous_trame;% taille de deux sous trames

taille_fast_buffer=floor(nb_bit_init/2);
taille_interleaver_buffer=nb_bit_init-taille_fast_buffer;
taille_interleaver_buffer = taille_interleaver_buffer -12; %interlever bits
taille_fast_buffer = taille_fast_buffer - (8*(240-224))*(floor(taille_fast_buffer/(8*240)))-(length(generateur_crc)-1);% enlever les bits de rs et crc
taille_interleaver_buffer = taille_interleaver_buffer - (8*(240-224))*(floor(taille_interleaver_buffer/(8*240)))-(length(generateur_crc)-1);% enlever les bits de rs et crc
nb_bit_init = taille_fast_buffer + taille_interleaver_buffer;



 % --Création de la suite de bits à transmettre
 % KO à transposer de base en colonne pour éviter l'overprocessing de
 % transposition dans codage_canal
 bits_generes=gene_bits(nb_bit_init,0.5); % suite de bits à transmettre

% modulation/transmission/démodulation
supertrame = traitement_supertrame( bits_generes, generateur_crc, table_alloc, pref_cyclique,nombre_sous_trame);
supertrame_recue=ligne(supertrame,h_canal,snr_reel, bruit_selectif); % Transmission sur le canal ATTENTION: supertrame est un tableau de 68 sous-trames (signal en temps)
supertrame_recue=supertrame_recue(1:length(supertrame_recue)-(length(h_canal)-1));
fprintf('Taille supertrame recue apres canal %d\n', length(supertrame_recue));
%fprintf('Taille supertrame : %d\n', length(supertrame));
%fprintf('Taille supertram recue : %d\n', length(supertrame_recue));
suite_bits_supertrame_recue=[];
for i= 1:nombre_sous_trame %68 sous-trame dans 1 supertrame
  id1=(i-1)*(length(supertrame_recue)/nombre_sous_trame)+1;
  id2=i*(length(supertrame_recue)/nombre_sous_trame);
  fprintf('Indice 1 : %d\nIndice 2 : %d', id1, id2);
  x = supertrame_recue(id1:id2);
  [ suite_bits_recu, symbole_recu ] = demodulationDMT(x,H_moy,nb_canaux,pref_cyclique,table_alloc); % Démodulation DMT (suppression du PC, parallélisation, FFT, égalisation et sérialisation)
  suite_bits_supertrame_recue = [ suite_bits_supertrame_recue suite_bits_recu ]; %suite de bit reçue correspondant à la supertrame
end

suite_bits_final = desassemblage_supertrame(suite_bits_supertrame_recue, generateur_crc); % deinterleaver / decodage rs / décodage crc
%plot(suite_bits_final); %bits reçu
%plot(bits_generes); %bits envoyés

fprintf('On genere %d bits et on en recoit %d\n', length(bits_generes), length(suite_bits_final));
fprintf('Taux erreur final : %d\n', sum(xor(bits_generes, suite_bits_final)));

% Réponse impulsionnelle
figure,freqz(h_canal)
title('Réponse impulsionnelle du canal');

% Répartition des bits
figure,bar(table_alloc,'w');
title('Allocation des bits');
xlabel('Numéro canal');
ylabel('Bits/canal');

% signal modulé et démodulé
figure,subplot(2,1,1),stem(bits_generes(1:500));
title('Comparaison signal entrant/signal démodulé');
ylabel('valeur');
xlabel('Canaux');
subplot(2,1,2),stem(suite_bits_final(1:500));
ylabel('valeur');
xlabel('Canaux');

