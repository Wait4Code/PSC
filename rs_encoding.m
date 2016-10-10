function rs_encoded = rs_encoding( msg, n, k )
% RS - reed-solomon encoder
%
% this matlab script encodes the message in msg using an [ n, k ]
% reed-solomon code with the narrow-sense generator polynomial
%
% input is binary data flow
% output is rs-encoded decimal numbers
%
% input :
% - msg, the data to reed-solomon encode ( vector of bits )
% - m, the number of bits per symbol
% - k, the message length
%
% please note that n is the codeword length
%
% output :
% - rs_encoded, reed-solomon encoded data ( vector of bits )
%
% note that output length is length( msg ) * k
%
% examples :
%
%     rs_encoding( [ 0 1 0 1 1 1 0 0 1 ], 3, 3 );
%

% Each symbol that forms the input message and output codewords is an integer between 0 and 2M–1
% n = 2^(m)-1;

% input value must be a numeric, column vector of bits
enc = comm.RSEncoder( n, k, 'BitInput', true );

% Encode the data
rs_encoded = step( enc, msg' );
