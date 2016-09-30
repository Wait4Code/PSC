function [trame_decode,err]=decodage_crc(trame,generateur)
% n=taille(trame); m=taille(generateur-1);
% reste= reste de division euclidienne de trame par generateur
% if reste=suite de 0 pas de erreur else avec erreur

d = comm.CRCDetector(generateur);%générer le detecteur
[trame_decode,err] = step(d,trame');


