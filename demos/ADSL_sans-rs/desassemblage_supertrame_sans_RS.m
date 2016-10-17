function suite_bits_final = desassemblage_supertrame_sans_RS( suite_bits_supertrame, generateurCRC)
    
taille_trame=length(suite_bits_supertrame);
%fprintf('Taille supertrame recue avant decodage_canal : %d\n', taille_trame);

%récupération des deux buffers
fast_buffer_trame = suite_bits_supertrame( 1:( floor( (taille_trame-12)/2 ) ) );
interleaved_buffer_trame = suite_bits_supertrame( ( floor( (taille_trame-12)/2 )+1 ):taille_trame );

%fprintf('Taille fast buffer %d\n', length(fast_buffer_trame));
%fprintf('Taille interleaved buffer %d\n', length(interleaved_buffer_trame));

trame_deinterleaved = deinterleaver( interleaved_buffer_trame, 3, 2 );
%fprintf('Taille trame deinterleaved : %d\n', length(trame_deinterleaved));

[suite_bits_fast, ~]=decodage_canal_sans_rs(fast_buffer_trame,generateurCRC);
[suite_bits_deinterleaved, ~] =decodage_canal_sans_rs(trame_deinterleaved,generateurCRC);

%disp('Après decodage:');
%fprintf('Taille suite de bit fast : %d\n', length(suite_bits_fast) );
%fprintf('Taille suite de bits deinterleaved : %d\n', length(suite_bits_deinterleaved));

suite_bits_final=[suite_bits_fast' suite_bits_deinterleaved'];

%fprintf('Taille suite_bits_final : %d\n', length(suite_bits_final));

end
