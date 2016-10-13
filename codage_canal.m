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

% suite_bits_codee = codage_canal( [ 0 1 0 1 1 0 1 1 ], [ 1 ], 1)

%Ajout du codage CRC
trame_crc = codage_crc( suite_bits, generateur_crc );
taille_trame = length( trame_crc );
disp('after crc:');
disp(taille_trame);
% reed-solomon
N_rs = floor( taille_trame / ( 8 * 224 ) );
trame_rs_end=trame_crc(N_rs*8*224+1:taille_trame);
trame_rs = [];

if N_rs > 0 %Si la trame est assez grande pour réaliser un codage RS
  for i = 1:N_rs
    encoded_trame = rs_encoding( trame_crc((i-1)*8*224+1:i*8*224), 240, 224 );
    trame_rs = [ trame_rs encoded_trame' ];
  end
  trame_rs_total= [ trame_rs trame_rs_end' ];
  
else
    trame_rs_total = trame_crc; % Si la trame n'est pas assez grande pour un codage RS
end
trame_finale = trame_rs_total;

disp('after rs:');
disp(length(trame_finale));


if type_buffer == 1    %Si il s'agit du buffer_interleaved
  trame_finale = interleaver( trame_finale, 3, 2 );
  disp('after interleaver:');
  disp(length(trame_finale));
end

suite_bits_codee = trame_finale;
end
