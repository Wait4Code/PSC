msg = randi( [0, 1], 1, 224 );

enc = comm.RSEncoder( 1, 1, 'BitInput', true );
for i = 1:100
  for j = 1:100
    enc.release();
    enc.CodewordLength = i;
    enc.MessageLength = j;
    try
      encoded = step( enc, msg' );
      disp( sprintf( 'ILLUMINATI CONFIRMED! ( %2d, %2d ) ==> %d', i, j, length( encoded ) ) );
    catch
      %disp( sprintf('%d %d', i, j));
      continue;
    end
  end
end
