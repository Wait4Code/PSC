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
snr_reel=60;
nombre_sous_trame=2;
bruit_selectif=false;
%%%%%%%%%
% Cycle %
%%%%%%%%%

% Evaluation de la ligne et allocation des bits
[H_moy,H_moy_abs,SNR]=eval_canaux(nb_canaux,h_canal,pref_cyclique,snr_reel,bruit_selectif); 
table_alloc= allocation_bits(SNR);

taille_max_sous_trame=sum(table_alloc);
message= sprintf('taille maximale de la sous-trame:%d\n',taille_max_sous_trame);
disp(message);
message= sprintf('taille maximale de la supertrame:%d\n',taille_max_sous_trame*nombre_sous_trame);
disp(message);

% calcule nb de bits initial à generer %

nb_bit_init = taille_max_sous_trame*nombre_sous_trame;% taille de deux sous trames

taille_fast_buffer=floor(nb_bit_init/2);
taille_interleaver_buffer=nb_bit_init-taille_fast_buffer;
taille_interleaver_buffer = taille_interleaver_buffer -12; %interlever bits
taille_fast_buffer = taille_fast_buffer - (8*(240-224))*(floor(taille_fast_buffer/(8*240)))-(length(generateur_crc)-1);% enlever les bits de rs et crc
taille_interleaver_buffer = taille_interleaver_buffer - (8*(240-224))*(floor(taille_interleaver_buffer/(8*240)))-(length(generateur_crc)-1);% enlever les bits de rs et crc
nb_bit_init = taille_fast_buffer + taille_interleaver_buffer;



 % --Création de la suite de bits à transmettre
 bits_generes=gene_bits(nb_bit_init,0.5); % suite de bits à transmettre

% modulation/transmission/démodulation
supertrame = traitement_supertrame( bits_generes, generateur_crc, table_alloc, pref_cyclique,nombre_sous_trame);
supertrame_recue=ligne(supertrame,h_canal,snr_reel, bruit_selectif); % Transmission sur le canal ATTENTION: supertrame est un tableau de 68 sous-trames (signal en temps)
save('adsl_simulator');
%fprintf('Taille supertrame : %d\n', length(supertrame));
%fprintf('Taille supertram recue : %d\n', length(supertrame_recue));
suite_bits_supertrame_recue=[];
for i= 1:nombre_sous_trame %68 sous-trame dans 1 supertrame
    %id1=(i-1)*(length(supertrame_recue)/nombre_sous_trame)+1;
    %id2=i*(length(supertrame_recue)/nombre_sous_trame);
    %fprintf('Indice 1 : %d\nIndice 2 : %d', id1, id2);
    [suite_bits_recu,symbole_recu]=demodulationDMT(supertrame_recue((i-1)*length(supertrame_recue)/nombre_sous_trame+1:i*length(supertrame_recue)/nombre_sous_trame),H_moy,nb_canaux,pref_cyclique,table_alloc); % Démodulation DMT (suppression du PC, parallélisation, FFT, égalisation et sérialisation)
    suite_bits_supertrame_recue= [suite_bits_supertrame_recue suite_bits_recu]; %suite de bit reçue correspondant à la supertrame
end

suite_bits_final=desassemblage_supertrame(suite_bits_supertrame_recue, generateur_crc); % deinterleaver / decodage rs / décodage crc
plot(suite_bits_final); %bits reçu
plot(bits_generes); %bits envoyés
    


