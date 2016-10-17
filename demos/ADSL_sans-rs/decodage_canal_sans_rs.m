function [ suite_bits_decodee, err ] = decodage_canal_sans_rs( trame, generateur_crc )
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



[ trame_decode, err ] = decodage_crc( trame, generateur_crc );

suite_bits_decodee=trame_decode;

