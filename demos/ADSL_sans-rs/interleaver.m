function interleaved = interleaver( msg, nrows, slope )
% Entrelaceur convolutionnel
%
% Cette fonction prend un message binaire et permute ses symboles
% à l'aide de registres à décalage
%
% arguments :
% - msg is the data to interleave
% - nrows is the number of shift registers
% - slope is the delay applied to each bit of the signal by shift registers
%
% examples :
%
%     interleaver( [ 0 0 1 0 1 1 0 0 ], 3, 2 )
%

delay = nrows * ( nrows - 1 ) * slope;

% append d symbols of delay to end of message
msg = [ msg zeros( 1, delay ) ];

% convolutional interleaver
interleaved = convintrlv( msg, nrows, slope );
