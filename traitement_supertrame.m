function supertrame = traitement_supertrame( trame_init, generateur_crc, tab, prefixe_cyclique )
% Traitement de la supertrame
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

N = length( tab ) % nb de canaux
taille_sous_trame = sum( tab ); % taille de sous-trame
v = prefixe_cyclique; %taille de prefixe

trame = codage_crc( trame_init, generateur_crc );

% reed-solomon
trame = trame'; % transpose frame matrix

% interleaver
interleaved = interleaver( trame, 3, 2 );

% compute supertrame
n = floor( length( interleaved ) / taille_sous_trame ); % n est nb de sous-trame complet

supertrame = [];
for i = 1:n
   supertrame( i ) = bits2signal( interleaved( (i-1)*N+1:i*N ), tab, v );
end

