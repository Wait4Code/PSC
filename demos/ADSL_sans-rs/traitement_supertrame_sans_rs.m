function supertrame = traitement_supertrame_sans_rs( bits_generes, generateur_crc, tab_alloc, prefixe_cyclique, nombre_sous_trame )
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

% longueur d'une sous-trame
% taille de sous-trame = la somme des bits alloués par canal
N = sum( tab_alloc );
taille_trame_init = length( bits_generes );
%fprintf( 'taille trame init: %d\n', taille_trame_init );

fast_buffer_trame = bits_generes( 1:( floor( taille_trame_init/2 ) ) );
%fprintf( 'taille fast_buffer: %d\n', length( fast_buffer_trame ) );

interleaved_buffer_trame = bits_generes( ( floor( taille_trame_init/2 )+1 ):taille_trame_init );
%fprintf( 'taille interleaved_buffer: %d\n', length( interleaved_buffer_trame ) );

% contient codage crc, rs et interleaver pour la partie interleaved_buffer
% la première partie de la trame n'est pas entrelacée alors que l'autre oui
trame = [ codage_canal_sans_rs( fast_buffer_trame, generateur_crc, 0 ) codage_canal_sans_rs( interleaved_buffer_trame, generateur_crc, 1 ) ];
%fprintf( 'taille trame codée : %d\n', length( trame ) );

supertrame = [];

for i = 1:nombre_sous_trame
  sous_trame = trame( (i-1)*N+1:i*N );
  signal = bits2signal( sous_trame, tab_alloc, prefixe_cyclique );

  taille_signal = length( signal );
  %fprintf( 'Longueur de la trame envoyee dans fonction: %d\n', length( sous_trame ) );
  %fprintf( 'Longueur du signal sortie de la fonction: %d\n', taille_signal );

  % bit2signal crée une sous-trame et la stocke dans supertrame
  supertrame = [supertrame signal];
  
end

end
