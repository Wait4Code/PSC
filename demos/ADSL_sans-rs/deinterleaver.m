function msg = deinterleaver( interleaved, nrows, slope )
% Désentrelaceur convolutionnel
%
% Cette fonction prend un message binaire entrelacé et restaure l'ordre de
% ses symboles à l'aide de registres à décalage
%
% arguments :
% - msg is the interleaved data
% - nrows is the number of shift registers
% - slope is the delay applied to each bit of the signal by shift registers
%
% examples :
%
%     deinterleaver( [ 0 0 1 0 0 0 0 0 0 0 ], 3, 2 )
%

delay = nrows * ( nrows - 1 ) * slope;

% convolutional deinterleaver
deintrlved = convdeintrlv( interleaved, nrows, slope );

% omit the first d symbols of recovered data
msg = deintrlved( ( delay + 1 ):end );
