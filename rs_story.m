msg = [ 0 1 0 1 1 0 1 0 1 ]';

encoded = rs_encoding( msg );
disp( 'encoded frame :' );
disp( reshape( encoded, [length( encoded ), 1]) );

decoded = rs_decoding( encoded );
disp( 'decoded frame:' );
disp( decoded );


