% Construction de la table d'allocations des bits
%
% Cette fonction prend une supertrame en entrée et renvoie la signal en
% temps à transmettre dans les canal.
%
% arguments :
% - trame est un supertrame sans la parie synchronisaton
% - generateur_crc est le générateur de codage crc
% - tab est le vecteur d'allocation de bits
% - prefixe_cyclique correspond au nombre de préfixe que l'on va ajouter au
%   début du signal à transmettre
%
% examples :
%
%     traitement_supertrame( [ 0 0 1 ], [ 1 ], [ 1, 5, 6 ], 2 );
%