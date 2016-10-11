function x=modulationDMT(suite_symboles_in,nombre_canaux,prefixe_cyclique)

% La fonction modulationDMT réalise le traitement par paraléllisation de
% la suite de symboles reçus, éffectuer IFFT et ajouter le préfixe.
% Elle renvoie un trame temporelle à transmettre.
% suite_symboles_in suite des symboles complexes à transmettre
% nombre_canaux nombre de canaux utilisés
% prefixe_cyclique la longueur du CP


N=nombre_canaux; % Nombre de canaux
v=prefixe_cyclique; % Longueur du préfixe cyclique


%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parallélisation et IFFT %
%%%%%%%%%%%%%%%%%%%%%%%%%%%

% A partir de la suite de symboles en entrée, on va former un symbole DMT
% par parallélisation sur les N canaux. On appliquera ensuite une IFFT.

suite_symboles_in=[suite_symboles_in 0 conj(fliplr(suite_symboles_in(2:N)))]; % On concatène la suite de symboles avec son symétrique
                                                  % hermitien en miroir. les valeur conjuguéez permetent
                                                  % d'éliminer la partie
                                                  % imaginaire pendant IFFT
x_ifft=ifft(suite_symboles_in,2*N); % On applique l'IFFT


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ajout du préfixe cyclique %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Le préfixe permet de éviter l'interférence inter-trame et faire le trame
% avoir un effet périodique
% Pour le former, on répète la fin du trame au début du même
% trame.

x=[x_ifft(2*N+1-v:2*N) x_ifft]; % v >= L-1 avec L traille de réponse impultionnel h
