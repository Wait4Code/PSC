function symb_deci=codage_symb(suite_bits,M)
%function symb_deci=codage_symb(suite_bits,k)
% La fonction codage_symb permet de coder une suite binaire pour
% obtenir un symbole décimal associée.

% suite_symboles est la suite des symboles sous forme d�cimale.
% M est l'indice de modulation utilis� pour coder cette suite.


%%%%%%%%%%%%%%%%%%
% Initialisation %
%%%%%%%%%%%%%%%%%%

k=log2(M); % k est le nombre de bits par symbole (M=2^k)


%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Conversion des symboles %
%%%%%%%%%%%%%%%%%%%%%%%%%%%

str=num2str(suite_bits);
symb_deci=bin2dec(str);