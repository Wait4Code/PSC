function interleaved = interleaver( msg, nrows, slope )

delay = nrows * ( nrows - 1 ) * slope;

% append d symbols of delay to end of message
msg = [ msg zeros( 1, delay ) ];

% convolutional interleaver
interleaved = convintrlv( msg, nrows, slope );
