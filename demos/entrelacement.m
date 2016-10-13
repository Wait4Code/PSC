addpath( '..' );

nrows = 3;
slope = 2;
fprintf( 'nombre de ligne à retard: %d\n', nrows );
fprintf( 'retard appliqué par chaque registre à décalage: %d\n', slope );
fprintf( 'retard total = nrows * ( nrows - 1 ) * slope = %d\n\n', nrows * ( nrows - 1 ) * slope );

% courbe du nombre de bits en sortie de l''entrelaceur en fonction du nombre de bits en entrée
max = 200;
y = zeros( 1, max );

for i = 1:max
  u = randi( [ 0 1 ], 1, i );
  y(i) = length( interleaver( u, nrows, slope ) );
end

hold on
axis manual
subplot( 3, 1, 1 );
plot( 1:max, y );
xlabel( 'bits en entrée' );
ylabel( 'bits en sortie' );
title( 'Taille en entrée et de sortie de l''entrelaceur' );

% test d'un signal en entrée et en sortie de l'entrelaceur
x = [ 1 0 0 0 0 0 1 1 1 1 1 1 0 1 0 1 1 1 1 0 0 0 ];
y = interleaver( x, nrows, slope );

subplot( 3, 1, 2 );
stairs( x );
axis( [ 1 inf -0.5 1.5 ] );
title( 'Signal en entrée de l''entrelaceur' );

subplot( 3, 1, 3 );
stairs( y );
axis( [ 1 inf -0.5 1.5 ] );
title( 'Signal en sortie de l''entrelaceur' );

fprintf( 'taille en entrée: %d\n', length( x ) );
fprintf( 'taille en sortie: %d\n', length( y ) );

