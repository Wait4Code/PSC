% Exemple de cycle émission/réception.

%% Initialisation
B=4.3125*10^3; %largeur de bande d'un canal
longueur_ligne = 3000;
diametre_ligne=0.0005;
snr_reel=20;
bruit_selectif=false;
disp('Début de la simulation');
settings = inputdlg({'Longueur de ligne (m) [3000] :','Diamètre de la ligne (m) [0.0005] :','SNR (dB): [20]', 'Bruit sélectif aléatoire (oui ou non) [non]'},'Choix paramètres : ');

if isempty( settings ) == 0
  if isempty( settings{1} ) == 0
    longueur_ligne = str2double( settings{1} );
  end
  if isempty( settings{2} ) == 0
    diametre_ligne = str2double( settings{2} );
  end
  if isempty( settings{3} ) == 0
    snr_reel = str2double( settings{3} );
  end
  if isempty( settings{4} ) == 0
    if settings{4} == 'oui'
      bruit_selectif=filtre_bruit_ponc(2200,125,275);
    end
  end
end

% préciser nombre de canaux
nb_canaux= 256;
% récupération de la réponse impulsionnelle du canal
disp('Calcule de la réponse impulsionnelle du canal...');
h_canal=f_transfert(longueur_ligne, diametre_ligne);
% taille préfixe cyclique
pref_cyclique=length(h_canal)+1;
% generateur crc
generateur_crc=[1 0 1 1 1 0 0 0 1];
% préciser nombre de sous trame
nombre_sous_trame=68;


%% Transmission du signal

disp('Evaluation de la ligne en cours...');
% Evaluation de la ligne et allocation des bits
[H_moy,H_moy_abs,SNR]=eval_canaux(nb_canaux,h_canal,pref_cyclique,snr_reel,bruit_selectif);
table_alloc= allocation_bits(SNR);

taille_max_sous_trame=sum(table_alloc);
%fprintf('taille maximale de la sous-trame:%d\n',taille_max_sous_trame);
%fprintf('taille maximale de la supertrame:%d\n',taille_max_sous_trame*nombre_sous_trame);

% calcule nb de bits initial à generer %

nb_bit_init = taille_max_sous_trame*nombre_sous_trame;% taille de deux sous trames

taille_fast_buffer=floor(nb_bit_init/2);
taille_interleaver_buffer=nb_bit_init-taille_fast_buffer;
taille_interleaver_buffer = taille_interleaver_buffer -12; %interlever bits
taille_fast_buffer = taille_fast_buffer -(length(generateur_crc)-1);% enlever les bits et crc
taille_interleaver_buffer = taille_interleaver_buffer - (length(generateur_crc)-1);% enlever les bits  et crc
nb_bit_init = taille_fast_buffer + taille_interleaver_buffer;



 % --Création de la suite de bits à transmettre
 % KO à transposer de base en colonne pour éviter l'overprocessing de
 % transposition dans codage_canal
 bits_generes=gene_bits(nb_bit_init,0.5); % suite de bits à transmettre

% modulation/transmission/démodulation
disp('Construction de la supertrame...');
disp('Codage CRC...');
disp('Entrelassement...');
disp('Modulation DMT...');
supertrame = traitement_supertrame_sans_rs( bits_generes, generateur_crc, table_alloc, pref_cyclique,nombre_sous_trame);
disp('Envoi de la supertrame');
supertrame_recue=ligne(supertrame,h_canal,snr_reel, bruit_selectif); % Transmission sur le canal ATTENTION: supertrame est un tableau de 68 sous-trames (signal en temps)
disp('Réception de la supertrame');
supertrame_recue=supertrame_recue(1:length(supertrame_recue)-(length(h_canal)-1));
%fprintf('Taille supertrame recue apres canal %d\n', length(supertrame_recue));
%fprintf('Taille supertrame : %d\n', length(supertrame));
%fprintf('Taille supertram recue : %d\n', length(supertrame_recue));
suite_bits_supertrame_recue=[];
disp('Déassemblage de la supertrame...');
disp('Démodulation DMT...');
disp('Désentrelassement...');
disp('Décodage CRC...');
for i= 1:nombre_sous_trame %68 sous-trame dans 1 supertrame
  id1=(i-1)*(length(supertrame_recue)/nombre_sous_trame)+1;
  id2=i*(length(supertrame_recue)/nombre_sous_trame);
  %fprintf('Indice 1 : %d\nIndice 2 : %d', id1, id2);
  x = supertrame_recue(id1:id2);
  [ suite_bits_recu, symbole_recu ] = demodulationDMT(x,H_moy,nb_canaux,pref_cyclique,table_alloc); % Démodulation DMT (suppression du PC, parallélisation, FFT, égalisation et sérialisation)
  suite_bits_supertrame_recue = [ suite_bits_supertrame_recue suite_bits_recu ]; %suite de bit reçue correspondant à la supertrame
end

suite_bits_final = desassemblage_supertrame_sans_RS(suite_bits_supertrame_recue, generateur_crc); % deinterleaver / décodage crc
%plot(suite_bits_final); %bits reçu
%plot(bits_generes); %bits envoyés

fprintf('On genere %d bits et on en recoit %d\n', length(bits_generes), length(suite_bits_final));
fprintf('Taux erreur final : %d\n', (sum(xor(bits_generes, suite_bits_final))/length(suite_bits_final)));
fprintf('Débit brut par sous-trame: %d\n', 68*sum(table_alloc)/(17*10^-3)); %débit brut d'une supertrame (une supertrame dure 17^-3 s)
fprintf('Débit utile par sous-trame: %d\n', nb_bit_init/(17*10^-3)); %débit utile d'une supertrame (une supertrame dure 17^-3 s)
% Répartition des bits
% figure,bar(table_alloc,'w');
% title('Allocation des bits');
% xlabel('Numéro canal');
% ylabel('Bits/canal');

% signal modulé et démodulé
figure,subplot(2,1,1),stem(bits_generes(1:floor(nb_bit_init/20)));
title('Comparaison signal entrant/signal démodulé');
ylabel('valeur');
xlabel('Canaux');
subplot(2,1,2),stem(suite_bits_final(1:floor(nb_bit_init/20)));
ylabel('valeur');
xlabel('Canaux');

disp('Merci d avoir utilisé adsl_simulator');

