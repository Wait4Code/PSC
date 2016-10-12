function x = bits2signal( sous_trame, tab_alloc, prefixe_cyclique )
% Transforme la sous-trame numérique en les signaux analogiques modulé QAM
%
% Cette fonction prend un sous-trame en bits comme entrée et renvoie la
% sous_trame en temps à transmettre dans les canaux
%
% arguments :
% - sous_trame est un supertrame sans la partie synchronisation
% - tab est le vecteur d'allocation de bits
% - préfixe cyclique correspond le nombre de préfixe qu'on va ajouter au
%   début du signal à transmettre
%

N = length( tab_alloc ); % nb de canaux
message= sprintf('taille dune sous-trame:%d\n',length(sous_trame));
disp(message);

suite_symb = [];
suite_symb_QAM = [];

k = 1;

for i = 1:N    
  suite_symb(i) = codage_symb( sous_trame( k:k+tab_alloc(i)-1 ), 2^( tab_alloc(i) ) );
  suite_symb_QAM(i) = modulationQAM( suite_symb(i), 2^( tab_alloc(i) ) ); % contient tout les symboles complexes d'une sous-trame sans le préfixe cyclique
  k = k + tab_alloc(i);
end

x = modulationDMT( suite_symb_QAM, N, prefixe_cyclique ); % modulation dmt d'une sous-trame

end
