msg = [ 0 1 0 1 1 0 1 0 1 ]';

encoded = rs_encoding( msg, 5, 3 );
disp( 'encoded frame :' );
disp( reshape( encoded, [length( encoded ), 1]) );

decoded = rs_decoding( encoded, 5, 3 );
disp( 'decoded frame:' );
disp( decoded );


