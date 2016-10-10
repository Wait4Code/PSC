function suite_bits_final= desassemblage_supertrame(suite_bits_supertrame, generateurCRC)

    trame_deinterleaved = deinterleaver(suite_bits_supertrame, 1 , 4);
    trame = rs_decoding( trame_deinterleaved', 5, 3 );
    suite_bits_final= decodage_crc(trame, generateurCRC);
       
end