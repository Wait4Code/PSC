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
%     rs_encoding( [ 0 1 0 1 1 1 0 0 1 ]', 5, 3 );
%

enc = comm.RSEncoder( n, k );
enc.BitInput = true;

rs_encoded = step( enc, msg' );
