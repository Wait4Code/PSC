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
interleaved_buffer_trame = trame_init( ( floor( taille_trame_init/2 ) ):taille_trame_init );

trame= codage_crc(trame_init,generateur_crc);
%%trame1 = codage_crc( fast_buffer_trame, generateur_crc );
%%trame2 = codage_crc( interleaved_buffer_trame, generateur_crc );

% reed-solomon

encoded = rs_encoding( trame_init', 5, 3 );


% interleaver
interleaved = interleaver( encoded', 3, 2 );

% compute supertrame
%trame_codee= [trame1 trame2];
trame_codee = interleaved';
n = floor( length( trame_codee ) / taille_sous_trame ); % n est nb de sous-trame complet

supertrame = zeros( 1, n );
for i = 1:n
  % FIXME pb tableau de signal temporel ???
  % Index exceeds matrix dimensions.
  %
  % Error in bits2signal (line 22)
  %   suite_symb(i) = codage_symb( sous_trame( k:k+tab(i)-1 ), 2^( tab(i) ) );

  % Error in traitement_supertrame (line 44)
  %   supertrame( i ) = bits2signal( trame_codee( (i-1)*N+1:i*N ), tab, v );
  %
  supertrame( i ) = bits2signal( trame_codee( (i-1)*N+1:i*N ), tab, v );
end

