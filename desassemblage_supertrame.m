function suite_bits_final = desassemblage_supertrame( suite_bits_supertrame, generateurCRC)

taille_trame=length(suite_bits_supertrame);
%récupération des deux buffers
fast_buffer_trame = suite_bits_supertrame( 1:( floor( (taille_trame-12)/2 ) ) );
interleaved_buffer_trame = suite_bits_supertrame( ( floor( (taille_trame-12)/2 )+1 ):taille_trame );

trame_deinterleaved = deinterleaver( interleaved_buffer_trame, 3, 2 );

[suite_bits_fast, erreur_fast]=decodage_canal(fast_buffer_trame,generateurCRC);
[suite_bits_deinterleaved, erreur_deinterleaved] =decodage_canal(trame_deinterleaved,generateurCRC)

suite_bits_final=[suite_bits_fast suite_bits_deinterleaved];

end
