function suite_bits_codee = codage_canal( suite_bits, generateur_crc, type_buffer )

% suite_bits_codee=codage_canal( [ 0 1 0 1 1 0 1 1 ], [ 1 ], 1)

%Ajout du codage CRC
trame_crc = codage_crc( suite_bits, generateur_crc );
taille_trame = length( trame_crc );

% reed-solomon
N_rs = floor( taille_trame / ( 8 * 224 ) );
trame_rs = [];

if N_rs > 0 %Si la trame est assez grande pour réaliser un codage RS
  for i = 1:N_rs
    encoded_trame = rs_encoding( trame_crc((i-1)*8*224+1:i*8*224), 240, 224 );
    trame_rs = [ trame_rs encoded_trame' ];
  end
else
    trame_rs = trame_crc; % Si la trame n'est pas assez grande pour un codage RS
end
trame_finale = trame_rs;

if type_buffer == 1    %Si il s'agit du buffer_interleaved
  trame_finale = interleaver( trame_rs, 3, 2 );
end

suite_bits_codee = trame_finale;
end
