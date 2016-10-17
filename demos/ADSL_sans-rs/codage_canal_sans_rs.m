function suite_bits_codee = codage_canal_sans_rs( suite_bits, generateur_crc, type_buffer )
% Réalise le codage de canal pour une suite de bits donné
%
% Cette suite de bits sera codé CRC, RS puis entrelacé
% selon les paramètres spécifiés en entrée
%
% inputs :
% - suite_bits correspond à une suite de bits
% - generateur_crc correspond à la matrice génératrice du codeur CRC
% - type_buffer doit valoir 1 si on veut réaliser l'entralacement
%
% output : suite de bits codée de taille ??
%
% example :
% codage_canal( [ 0 1 0 1 1 1 0 0 0 ], [ 1 0 1 1 1 0 0 0 1 ], 1 )
%

% ajout du codage CRC
trame_crc = codage_crc( suite_bits', generateur_crc );
trame_crc = trame_crc';

taille_trame = length( trame_crc );
%fprintf( 'after crc: %d\n', length( trame_crc ) );

trame_finale = trame_crc;

%fprintf( 'after rs: %d\n', length( trame_finale ));

% Si il s'agit du buffer_interleaved
if type_buffer == 1
  trame_finale = interleaver( trame_finale, 3, 2 );
  %fprintf( 'after interleaver: %d\n', length( trame_finale ) );
end

suite_bits_codee = trame_finale;

end
