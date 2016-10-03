function msg = deinterleaver( interleaved, nrows, slope )

delay = nrows * ( nrows - 1 ) * slope;

% convolutional deinterleaver
deintrlved = convdeintrlv( interleaved, nrows, slope );

% omit the first d symbols of recovered data
msg = deintrlved( ( delay + 1 ):end );
