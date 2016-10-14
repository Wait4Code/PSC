function [ suite_bits_decodee, err ] = decodage_canal( trame, generateur_crc )
% Réalise le décodage de canal pour une suite de bits donné
%
% Cette suite de bits sera décodé RS puis CRC
% selon les paramètres spécifiés en entrée
%
% inputs :
% - suite_bits correspond à une suite de bits
% - generateur_crc correspond à la matrice génératrice du codeur CRC
%
% output : suite de bits codée de taille ??
%
% example :
% decodage_canal( [ 1 1 1 1 1 1 0 0 0 ], [ 1 0 1 1 1 0 0 0 1 ] )
%

taille_trame = length( trame );

% reed-solomon
N_check = floor( taille_trame / ( 8 * 224 ) );
N_rs = floor( taille_trame / ( 8 * 240 ) );
trame_rs_end = trame( ( N_rs*8*240+1 ):taille_trame );


trame_rs = [];
trame=trame';

if N_check > 0
  for i = 1:N_rs
    encoded = rs_decoding( trame((i-1)*8*240+1:i*8*240), 240, 224 );
    trame_rs = [ trame_rs encoded' ];
  end
  trame_rs=[trame_rs trame_rs_end];
else
  trame_rs = trame';
end

[ trame_decode, err ] = decodage_crc( trame_rs, generateur_crc );

suite_bits_decodee=trame_decode;

