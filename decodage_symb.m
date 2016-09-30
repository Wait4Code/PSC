function suite_bits=decodage_symb(symb_deci,M)

% Dans la version de prof, on travaille sur un tableau de symbole décimale,
% vue que pour chaque canal on transmettre qu'un seul symbole, du coup on
% peut simplifier la fonction en prenant un symbole décimal comme la 
% premiere parametre.

% La fonction decodage_symboles permet de d�coder un symbole pour
% obtenir la suite binaire associ�e.

% symb_deci est un symbole sous forme d�cimale.
% M est l'indice de modulation utilis� pour coder cette suite.


%%%%%%%%%%%%%%%%%%
% Initialisation %
%%%%%%%%%%%%%%%%%%

k=log2(M); % k est le nombre de bits par symbole (M=2^k)
string_bits=[]; % Initialisation de la 'string' qui contiendra la suite de bits 


%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Conversion de symbole %
%%%%%%%%%%%%%%%%%%%%%%%%%%%


b=dec2bin(symb_deci,k); % Conversion des symboles en binaire
string_bits=[string_bits b];


% Comme la fonction 'dec2bin' renvoie une structure de type 'string' on va
% transformer le r�sultat en vecteur num�rique.
suite_bits=[]; % Initialisation du vecteur qui contiendra la suite de bits 
for j=1:length(string_bits)
    suite_bits(j)=str2num(string_bits(j)); % La fonction dec2bin renvoie une 'string' qu'on transforme en vecteur
end