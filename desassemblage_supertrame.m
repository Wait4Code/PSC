function suite_bits_final = desassemblage_supertrame( suite_bits_supertrame, generateurCRC)

taille_trame=length(suite_bits_supertrame);
fast_buffer_trame = suite_bits_supertrame( 1:( floor( (taille_trame-12)/2 ) ) );
interleaved_buffer_trame = suite_bits_supertrame( ( floor( (taille_trame-12)/2 )+1 ):taille_trame );

trame_deinterleaved = deinterleaver( interleaved_buffer_trame, 3, 2 );

suite_bits_final=[decodage(fast_buffer_trame,generateurCRC) decodage(trame_deinterleaved,generateurCRC)];

