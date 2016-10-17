addpath( '..' );

generator = [ 1 0 1 1 1 0 0 0 1 ];
msg = [ 0; 1; 0; 1; 1; 0; 1; 0; 1 ];

y = codage_crc( msg, generator );
init = decodage_crc( y', generator);

fprintf( 'nombre de bits de codage ajoutés =\n   length( generator ) - 1 =\n      %d\n', length( generator ) - 1 );
fprintf( 'taille en entrée du codeur crc : %d\n', length( msg ) );
fprintf( 'taille en sortie du codeur crc : %d\n', length( y ) );

fprintf( 'taille en entrée du decodeur crc : %d\n', length( y ) );
fprintf( 'taille en sortie du decodeur crc : %d\n', length( init ) );

figure;
subplot( 2, 1, 1 );
stairs( msg );
axis( [ 1 inf -0.5 1.5 ] );
title( 'Signal en entrée du codeur CRC' );

subplot( 2, 1, 2 );
stairs( y );
axis( [ 1 inf -0.5 1.5 ] );
title( 'Signal en sortie du codeur CRC' );

figure;
subplot( 2, 1, 1 );
stairs( y );
axis( [ 1 inf -0.5 1.5 ] );
title( 'Signal en entrée du decodeur CRC' );

subplot( 2, 1, 2 );
stairs( init );
axis( [ 1 inf -0.5 1.5 ] );
title( 'Signal en sortie du decodeur CRC' );
