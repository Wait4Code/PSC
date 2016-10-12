enc = comm.RSEncoder( 240, 224, 'BitInput', true );
for i = 1:224*20
  msg = randi( [0, 1], 1, i );
  try
    result = step( enc, msg' );
    disp( sprintf( 'input=%d output=%d', i, length( result ) ) );
  catch
    
    continue;
  end
end
