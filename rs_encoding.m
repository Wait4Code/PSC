function rs_encoded = rs_encoding( msg, k, m )
% RS - reed-solomon encoder
%
%   this matlab script encodes the message in msg using an [ n, k ]
%   reed-solomon code with the narrow-sense generator polynomial
%
%   input is binary data flow
%   output is rs-encoded decimal numbers
%
n = 2^m - 1; % codeword length

decimal = bin2dec( fliplr( msg ) );

enc = comm.RSEncoder( n, k );

encodedData = step( enc, decimal );

rs_encoded = dec2bin( encodedData );
