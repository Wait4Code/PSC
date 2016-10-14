function suite_bits_codee = codage_canal( suite_bits, generateur_crc, type_buffer )
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

% wtf is that?!
% suite_bits_codee = codage_canal( [ 0 1 0 1 1 0 1 1 ], [ 1 ], 1)

% ajout du codage CRC
% warning matrix transposition MAYBE causes performance issues
% the same for the following lines...
trame_crc = codage_crc( suite_bits', generateur_crc );
trame_crc = trame_crc';

taille_trame = length( trame_crc );
%fprintf( 'after crc: %d\n', length( trame_crc ) );

% reed-solomon
N_rs = floor( taille_trame / ( 8 * 224 ) );
trame_rs_end = trame_crc( ( N_rs*8*224+1 ):taille_trame );
trame_rs = [];

% si la trame est assez grande pour réaliser un codage RS
if N_rs > 0
  for i = 1:N_rs
    encoded_trame = rs_encoding( trame_crc((i-1)*8*224+1:i*8*224), 240, 224 );
    trame_rs = [ trame_rs encoded_trame' ];
  end
  trame_rs_total = [ trame_rs trame_rs_end ];
else
  % sinon on met juste le codage CRC et on continue
  trame_rs_total = trame_crc;
end
trame_finale = trame_rs_total;

%fprintf( 'after rs: %d\n', length( trame_finale ));

% Si il s'agit du buffer_interleaved
if type_buffer == 1
  trame_finale = interleaver( trame_finale, 3, 2 );
  %fprintf( 'after interleaver: %d\n', length( trame_finale ) );
end

suite_bits_codee = trame_finale;

end
