function [suite_bits_decodee,err] = decodage_canal( trame, generateur_crc )
taille_trame=length(trame);

% reed-solomon
N_rs = floor( taille_trame / ( 8 * 240 ) );

trame_rs = [];

if N_rs > 0
  for i = 1:N_rs
    encoded = rs_encoding( trame((i-1)*8*240+1:i*8*240), 240, 224 );
    trame_rs = [ trame_rs encoded' ];
  end
else
    trame_rs = trame;
end

[trame_decode,err]=decodage_crc(trame_rs,generateur_crc);

suite_bits_decodee=trame_decode;
