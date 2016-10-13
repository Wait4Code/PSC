addpath( '..' );

nrows = 3;
slope = 2;
fprintf( 'nombre de ligne à retard: %d\n', nrows );
fprintf( 'retard appliqué par chaque registre à décalage: %d\n', slope );
disp( 'retard total=nrows * ( nrows - 1 ) * slope' );

% courbe du nombre de bits en sortie de l''entrelaceur en fonction du nombre de bits en entrée
max = 200;
y = zeros( 1, max );

for i = 1:max
  u = randi( [ 0 1 ], 1, i );
  y(i) = length( interleaver( u, nrows, slope ) );
end

figure;
subplot( 3, 1, 1 );
plot( 1:max, y );
title( 'nombre de bits en sortie de l''entrelaceur en fonction du nombre de bits en entrée' );

% test d'un signal en entrée et en sortie de l'entrelaceur
x = [ 0 0 0 0 0 0 1 1 1 1 1 1 0 1 0 1 1 1 1 0 0 0 ];
y = interleaver( x, nrows, slope );

subplot( 3, 1, 2 );
plot( x );
title( 'signal en entrée' );

subplot( 3, 1, 3 );
plot( y );
title( 'signal en sortie' );

