k = 1;
m = 7;
msg = [ 0 1 0 1 1 0 1 ];

encoded = rs_encoding( msg, k, m );
disp( 'encoded frame :' );
disp( reshape( encoded, [length( encoded ), 1]) );

decoded = rs_decoding( encoded, k, m );
disp( 'decoded frame:' );
disp( decoded );

