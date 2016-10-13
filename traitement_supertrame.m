function supertrame = traitement_supertrame( bits_generes, generateur_crc, tab_alloc, prefixe_cyclique,nombre_sous_trame )
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

    N = sum( tab_alloc ); % longueur d'une sous-trame / % taille de sous-trame = la somme des bits alloués par cannal
    taille_trame_init = length( bits_generes );
    disp('taille trame init');
    disp(taille_trame_init);    

    fast_buffer_trame = bits_generes( 1:( floor( taille_trame_init/2 ) ) );
    disp('taille fast_buffer');
    taille_fast_buffer=length(fast_buffer_trame);
    disp(taille_fast_buffer);
    interleaved_buffer_trame = bits_generes( ( floor( taille_trame_init/2 )+1 ):taille_trame_init );
    disp('taille interleaved_buffer');
    disp(length(interleaved_buffer_trame));
    trame=[codage_canal(fast_buffer_trame,generateur_crc,0) codage_canal(interleaved_buffer_trame,generateur_crc,1)]; %contient codage crc, rs et interleaver pour la partie interleaved_buffer 

    supertrame = [];
    taille_trame_codee=length(trame);
    fprintf('taille trame codée : %d\n', taille_trame_codee);
    for i = 1:nombre_sous_trame
      fprintf('Longueur de la trame envoyee dans fonction : %d\n', length(trame( (i-1)*N+1:i*N )));
      signal=bits2signal( trame( (i-1)*N+1:i*N ), tab_alloc, prefixe_cyclique );
      disp(length(signal));
      supertrame( (i-1)*length(signal)+1:i*length(signal)) = signal; %bit2signal crée une sous-trame et la stocke dans supertrame
      disp('JE SUIS BIEN PASSE');
    end
end

