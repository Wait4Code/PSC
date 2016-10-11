function suite_bits_codee=codage_canal(suite_bits,generateur_crc,type_buffer)

trame= codage_crc(suite_bits,generateur_crc);
taille_trame=length(trame);

% reed-solomon
N_rs=floor(taille_trame/(8*224);

trame_rs=[];

if(N_rs>0)
    for i=1:N_rs
        encoded = rs_encoding( trame_init', 240, 224 );
        trame_rs=[trame_rs encoded'];
    end
else
    trame_rs=trame;
end
trame_final=trame_rs;

if(type_buffer=1)
% interleaver
interleaved = interleaver(trame_rs, 3, 2 );
end

trame_final=interleaved

suite_bits_codee = trame_final;
