k = 3;
m = 7;
msg = [ '0101110'; '1110101'; '1101111' ];

encoded = rs_encoding( msg, k, m );
disp( 'encoded frame :' );
disp( encoded );

decoded = rs_decoding( encoded, k, m );
disp( 'decoded frame:' );
disp( decoded );
