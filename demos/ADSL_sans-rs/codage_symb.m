function symb_deci = codage_symb( suite_bits )
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

% Conversion des symboles
str = num2str( suite_bits );
symb_deci = bin2dec( str );
