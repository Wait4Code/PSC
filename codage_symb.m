function symb_deci = codage_symb( suite_bits, M )
% Codage symbole d'une suite binaire
%
% La fonction codage_symb permet de coder une suite binaire pour
% obtenir un symbole décimal associé
% 
% arguments :
% - suite_bits est un vecteur contenant une suite de bits
% - M est l'indice de modulation utilisé pour le codage symbole
%
% retour :
% - symb_deci est la suite des symboles sous forme décimale
%

% Initialisation 
k = log2( M ); % k est le nombre de bits par symbole (M=2^k)

% Conversion des symboles
str = num2str( suite_bits );
symb_deci = bin2dec( str );
