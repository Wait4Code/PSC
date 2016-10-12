function trame_code = codage_crc( trame, generateur )
% Codage CRC
%
% inputs :
% - trame correspondant à une suite de bits à coder CRC
% - generateur est la matrice du polynome générateur du CRC
%
% output sort la trame codée CRC en sortie tranposée
%
% example :
% codage_crc( [ 0 1 0 1 1 0 1 0 1 ], [ 1 0 1 1 1 0 0 0 1 ] )
%

% k=taille(trame); m=taille(generateur-1);
% trame=trame ajout m 0 à la fin
% reste= reste de division euclidienne de trame par generateur
% derniere m valeur de trame = valeur dans reste
% return trame_code= trame

g = comm.CRCGenerator( generateur );

trame_code = step( g, trame' );
