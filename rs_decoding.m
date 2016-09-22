function rs_decoded = rs_decoding( msg, k, m )
% RS - reed-solomon decoder
%
%   this matlab script decodes the binary message in msg using an [ n, k ]
%   reed-solomon code with the narrow-sense polynomial
%
%   input is binary message
%   output is rs decoded reed integer values
%

n = 2^m - 1; % codeword length

decimal = bin2dec( msg );

dec = comm.RSDecoder( n, k );

decodedData = step( dec, decimal );

rs_decoded = dec2bin( decodedData );
