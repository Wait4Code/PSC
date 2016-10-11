enc = comm.RSEncoder(5,3); %RSEncoder( 5, sqrt( length( msg ) ) )
enc.BitInput=true;
msg = [0; 0; 1; 1; 0; 0; 1; 1; 0; 0; 1; 1; 0; 0; 1; 0; 0; 1; 1; 0; 0; 1; 1; 0; 0; 1; 1; 0; 0; 1; 0; 0; 1; 1; 0; 0; 1; 1; 0; 0; 1; 1; 0; 0; 1];
cod = step( enc, msg );

%disp(cod);
disp(length(cod));
%disp(enc);

enco = comm.RSDecoder(5,3);
enco.BitInput=true;
deco = step( enco, cod );
disp(deco);
disp (deco == msg);
