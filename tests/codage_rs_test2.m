enc = comm.RSEncoder( 30, 28 ); %RSEncoder( 5, sqrt( length( msg ) ) )
enc.BitInput=true;
msg = randi( [0 1], 1, 224);
cod = step( enc, msg' );