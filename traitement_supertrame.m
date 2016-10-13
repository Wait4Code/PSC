function supertrame = traitement_supertrame( bits_generes, generateur_crc, tab_alloc, prefixe_cyclique )
    % Traitement de la supertrame
    %
    % Cette fonction prend une supertrame en entrée et renvoie la signal en
    % temps à transmettre dans les canal.
    %
    % arguments :
    % - trame est un supertrame sans la parie synchronisaton
    % - generateur_crc est le générateur de codage crc
    % - tab est le vecteur d'allocation de bits
    % - prefixe_cyclique correspond au nombre de préfixe que l'on va ajouter au
    %   début du signal à transmettre
    %
    % examples :
    %
    %    supertrame = traitement_supertrame( [ 1 0 1 0 0 0 1 1 0 ], [ 1 ], [ 1, 5, 6 ], 2 );
    %

    N = sum( tab_alloc ); % nb de canaux
    taille_trame_init = length( bits_generes );
    taille_sous_trame = sum( tab_alloc ); % taille de sous-trame = la somme des bits alloués par cannal


    fast_buffer_trame = bits_generes( 1:( floor( taille_trame_init/2 ) ) );
    interleaved_buffer_trame = bits_generes( ( floor( taille_trame_init/2 )+1 ):taille_trame_init );

    trame=[codage_canal(fast_buffer_trame,generateur_crc,0) codage_canal(interleaved_buffer_trame,generateur_crc,1)]; %contient codage crc, rs et interleaver pour la partie interleaved_buffer 

    n=68; % nombre de sous-trame dans la super-trame
    supertrame = [];
    for i = 1:n
      disp(sprintf('Longueur de la trame envoyee dans fonction : %d', length(trame( (i-1)*N+1:i*N ))));
      supertrame( i ) = bits2signal( trame( (i-1)*N+1:i*N ), tab_alloc, prefixe_cyclique ); %bit2signal crée une sous-trame et la stocke dans supertrame
    end
end

