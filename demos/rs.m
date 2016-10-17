addpath( '..' );

n = 5;
k = 3;
msg = [ 0 1 0 1 1 1 0 0 1 ];

y = rs_encoding( msg, n, k );
init = rs_decoding( y, n, k );

fprintf( 'RS_Codeur( n=%d, k=%d )\n', n, k );
fprintf( 'taille en entrée du codeur : %d\n', length( msg ) );
fprintf( 'taille en sortie du codeur : %d\n', length( y ) );
fprintf( 'nombre de bits de codage ajoutés: %d\n', length( y ) - length( msg ) );

fprintf( 'RS_Decodeur( n=%d, k=%d )\n', n, k );
fprintf( 'taille en entrée du decodeur : %d\n', length( y ) );
fprintf( 'taille en sortie du decodeur : %d\n', length( init ) );
fprintf( 'nombre de bits de codage ajoutés: %d\n', length( y ) - length( init ) );

figure;
subplot( 2, 1, 1 );
stairs( msg );
axis( [ 1 inf -0.5 1.5 ] );
title( 'Signal en entrée du codeur RS' );

subplot( 2, 1, 2 );
stairs( y );
axis( [ 1 inf -0.5 1.5 ] );
title( 'Signal en sortie du codeur RS' );

figure;
subplot( 2, 1, 1 );
stairs( y );
axis( [ 1 inf -0.5 1.5 ] );
title( 'Signal en entrée du decodeur RS' );

subplot( 2, 1, 2 );
stairs( init );
axis( [ 1 inf -0.5 1.5 ] );
title( 'Signal en sortie du decodeur RS' );

