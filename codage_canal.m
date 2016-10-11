function suite_bits_codee = codage_canal( suite_bits, generateur_crc, type_buffer )

% suite_bits_codee=codage_canal( [ 0 1 0 1 1 0 1 1 ], [ 1 ], 1)

trame = codage_crc( suite_bits, generateur_crc );
taille_trame = length( trame );

% reed-solomon
N_rs = floor( taille_trame / ( 8 * 224 ) );

trame_rs = [];

if N_rs > 0
  for i = 1:N_rs
    encoded = rs_encoding( trame((i-1)*8*224+1:i*8*224), 240, 224 );
    trame_rs = [ trame_rs encoded' ];
  end
else
    trame_rs = trame;
end
trame_final = trame_rs;

if type_buffer == 1
  interleaved = interleaver( trame_rs, 3, 2 );
end

trame_final = interleaved;

suite_bits_codee = trame_final;
