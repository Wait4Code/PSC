function suite_bits = decodage_symboles( symb_deci, M )
% Décodage d'un symbole
%
% inputs :
% - symb_deci est un symbole au format décimal
% - M est le nombre de symboles possibles sachant que M=2^n
%
% output correspond à la suite de bits décodées à partir du symbole
%
% example :
% decodage_symboles( 5, 4 )
%
% Dans la version de prof, on travaille sur un tableau de symbole décimale,
% vue que pour chaque canal on transmettre qu'un seul symbole, du coup on
% peut simplifier la fonction en prenant un symbole décimal comme la
% premiere parametre.

% La fonction decodage_symboles permet de décoder un symbole pour
% obtenir la suite binaire associée.

% symb_deci est un symbole sous forme décimale.
% M est l'indice de modulation utilisé pour coder cette suite.

%% Initialisation
k = log2( M ); % k est le nombre de bits par symbole (M=2^k)
string_bits = []; % Initialisation de la 'string' qui contiendra la suite de bits

%% Conversion de symbole
b = dec2bin( symb_deci, k ); % Conversion des symboles en binaire
string_bits = [ string_bits b ];

% Comme la fonction 'dec2bin' renvoie une structure de type 'string' on va
% transformer le résultat en vecteur numérique.
suite_bits = []; % Initialisation du vecteur qui contiendra la suite de bits
for j = 1:length( string_bits )
  suite_bits(j) = str2num( string_bits(j) ); % La fonction dec2bin renvoie une 'string' qu'on transforme en vecteur
end

