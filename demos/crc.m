addpath( '..' );

generator = [ 1 0 1 1 1 0 0 0 1 ];
msg = [ 0 1 0 1 1 0 1 0 1 ];


y = codage_crc( msg, generator );

fprintf( 'nombre de bits de codage ajoutés = length( generator ) - 1 = %d\n', length( generator ) - 1 );
fprintf( 'taille en entrée: %d\n', length( msg ) );
fprintf( 'taille en sortie: %d\n', length( y ) );

figure;
subplot( 2, 1, 1 );
stairs( msg );
axis( [ 1 inf -0.5 1.5 ] );
title( 'Signal en entrée du codeur CRC' );

subplot( 2, 1, 2 );
stairs( y );
axis( [ 1 inf -0.5 1.5 ] );
title( 'Signal en sortie du codeur CRC' );
