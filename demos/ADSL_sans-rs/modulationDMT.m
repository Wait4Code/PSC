function x = modulationDMT( suite_symboles_in, nb_canaux, lgre_pref_cyclique )
% La fonction modulationDMT réalise le traitement par paraléllisation de
% la suite de symboles reçus, éffectuer IFFT et ajouter le préfixe.
%
% Elle renvoie un trame temporelle à transmettre.
%
% inputs :
% - suite_symboles_in suite des symboles complexes à transmettre
% - nb_canaux nombre de canaux utilisés
% - lgre_pref_cyclique la longueur du CP
%

%% Parallélisation et IFFT
% A partir de la suite de symboles en entrée, on va former un symbole DMT
% par parallélisation sur les N canaux. On appliquera ensuite une IFFT.

% On concatène la suite de symboles avec son symétrique hermitien en miroir
% Les valeurs conjuguées permettent d'éliminer la partie imaginaire
% pendant l'IFFT
suite_symboles_in=[suite_symboles_in 0 conj(fliplr(suite_symboles_in(2:nb_canaux)))];

% On applique l'IFFT
x_ifft=ifft(suite_symboles_in,2*nb_canaux);


%% Ajout du préfixe cyclique
% Le préfixe permet de éviter l'interférence inter-trame et faire le trame
% avoir un effet périodique. Pour le former, on répète la fin du trame au
% début du même trame.

% v >= L-1 avec L traille de réponse impultionnel h
x=[x_ifft(2*nb_canaux+1-lgre_pref_cyclique:2*nb_canaux) x_ifft];
