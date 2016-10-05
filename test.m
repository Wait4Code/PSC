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
