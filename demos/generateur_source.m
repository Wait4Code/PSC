% Demo du générateur de source
addpath( '..' );

x = gene_bits( 250, 0.5 );

figure;
subplot( 2, 1, 1 );
plot( x );
title( 'Signal aléatoire binaire' );

subplot( 2, 1, 2 );
histogram( x );
title( 'Histogramme' );
