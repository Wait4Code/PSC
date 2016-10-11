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
%    supertrame = traitement_supertrame( [ 1 0 1 0 0 0 1 1 0 ], [ 1 ], [ 1, 5, 6 ], 2 );
%

N = length( tab ); % nb de canaux
taille_trame_init = length( trame_init );
taille_sous_trame = sum( tab ); % taille de sous-trame
v = prefixe_cyclique; % taille de prefixe

fast_buffer_trame = trame_init( 1:( floor( taille_trame_init/2 ) ) );
interleaved_buffer_trame = trame_init( ( floor( taille_trame_init/2 )+1 ):taille_trame_init );

trame=[codage_canal(fast_buffer_trame,generateur_crc,0) codage_canal(interleaved_buffer_trame,generateur_crc,1)]

n=68;
supertrame = [];
for i = 1:n
  
  supertrame( i ) = bits2signal( trame( (i-1)*N+1:i*N ), tab, v );
end

