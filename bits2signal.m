function x = bits2signal( sous_trame, tab_alloc, prefixe_cyclique )
% Transforme la sous-trame numérique en les signaux analogiques modulé QAM
%
% Cette fonction prend un sous-trame en bits comme entrée et renvoie la
% sous_trame en temps à transmettre dans les canaux
%
% arguments :
% - sous_trame est un supertrame sans la partie synchronisation
% - tab est le vecteur d'allocation de bits
% - préfixe cyclique correspond au nombre de préfixe qu'on va ajouter au
%   début du signal à transmettre
%
% example :
% bits2signal( [ 0 1 0 1 1 0 1 0 1 0 ], [ 1 3 1 ], 4 )
%

N = length( tab_alloc ); % nb de canaux
fprintf( 'taille sous-trame: %d\n', length( sous_trame ) );

suite_symb = zeros( 1, N );
suite_symb_QAM = zeros( 1, N );

% wtf is that?!
k = 1;

% metrics on info-e workstations
% qammod and modulationQAM are almost the same ( elapsed time is 11.794157 seconds )
for i = 1:N
  if tab_alloc(i) ~= 0
    sousTrame = sous_trame( k:k+tab_alloc(i)-1 );
    
    suite_symb(i) = codage_symb(sousTrame);

    % contient tout les symboles complexes d'une sous-trame sans le préfixe cyclique
    suite_symb_QAM(i) = qammod( suite_symb(i), 2^( tab_alloc(i) ) );
    k = k + tab_alloc(i);
  end
end

% modulation dmt d'une sous-trame
x = modulationDMT( suite_symb_QAM, N, prefixe_cyclique );
