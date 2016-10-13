% Script de test du canal modélisé du projet ADSL
%
%% Initialisation
longueur_ligne = 3000;
diametre_ligne = 0.0005;
nb_canaux = 64; % nombre de canaux en downstream
snr_reel = 60;
bruit_selectif = false;

% récupération de la réponse impulsionnelle du canal
h_canal = f_transfert( longueur_ligne, diametre_ligne );

%h_canal=[1 1 1 1 1]
%taille préfixe cyclique
pref_cyclique = length( h_canal ) + 1;

%% Cycle
% Evaluation de la ligne et allocation des bits
[ H_moy, H_moy_abs, SNR ] = eval_canaux( nb_canaux, h_canal, pref_cyclique, snr_reel, bruit_selectif );
bits_canal = allocation_bits( SNR );

stairs( bits_canal );