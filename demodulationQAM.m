function symb_deci=demodulationQAM(Xi,Xq,M)

% Associe aux symboles complexes, leur ecriture decimale en fonction
% de symbole complexe de partie reelle Xi et imaginaire Xq
% dans la cas d'une demodulation M-QAM.

% Xi est la partie reelle du symbole complexe.
% Xq est la partie imaginaire du symbole complexe.
% M est le nombre de points de la constellation.

Xi=Xi/50;
Xq=Xq/50;
symb_deci=qamdemod(complex(Xi,Xq),M); % D�module les symboles sur une constellation de M points
