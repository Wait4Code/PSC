addpath( '..' );

M = 16;

y = zeros( 1, M );
for i = 0:( M-1 )
  y( i+1 ) = modulationQAM( i, M );
end

figure;
plot( y, 'x' );
axis( [ -5 5 -5 5 ] );
title( 'Constellation de la 16-QAM' );