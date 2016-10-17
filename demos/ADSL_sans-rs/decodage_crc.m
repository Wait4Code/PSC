function [ trame_decode, err ] = decodage_crc( trame, generateur )
% Décodage CRC
%
% inputs :
% - trame correspondant à une suite de bits à décoder CRC
% - generateur est la matrice du polynome générateur du CRC
%
% output sort la trame décodée CRC en sortie tranposée
%
% example :
% decodage_crc( [ 0 1 0 1 1 0 1 0 1 ], [ 1 0 1 1 1 0 0 0 1 ] )
%

% n=taille(trame); m=taille(generateur-1);
% reste= reste de division euclidienne de trame par generateur
% if reste=suite de 0 pas de erreur else avec erreur

d = comm.CRCDetector( generateur );
[ trame_decode, err ] = step( d, trame' );
