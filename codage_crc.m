function trame_code=codage_crc(trame,generateur)
% k=taille(trame); m=taille(generateur-1);
% trame=trame ajout m 0 � la fin
% reste= reste de division euclidienne de trame par generateur
% derniere m valeur de trame = valeur dans reste
% return trame_code= trame

g = comm.CRCGenerator(generateur);
% g = crc.generator( generateur ); %générer le générateur
% trame_code = generate( g, trame );
% trame_code = g;
trame_code = step(g,trame');

