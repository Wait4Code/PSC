function supertrame=traitement_supertrame(trame_init,generateur_crc,tab,prefixe_cyclique)

%cette fonction prend un supertrame comme entrée et renvoie la signal en
%temps à transmettre dans les canal.

% trame est un supertrame sans la parie synchronisaton.
% generateur_crc est le générateur de codage crc
% tab est le vecteur d'allocation de bits
% préfixe cyclique correspond le nombre de préfixe qu'on va ajouter au
% début du signal à transmettre.

N = length( tab ) % nb de canaux
taille_sous_trame = sum( tab ); %taille de sous-trame
v = prefixe_cyclique; %taille de prefixe

trame = codage_crc( trame_init, generateur_crc );

% reed-solomon

% interleaver
interleaved = interleaver( trame, 3, 2 );

n = floor( length( interleaved ) / taille_sous_trame ); % n est nb de sous-trame complet

supertrame = [];
for i = 1:n
   supertrame( i ) = bits2signal( interleaved( (i-1)*N+1:i*N ), tab, v );
end
        
        