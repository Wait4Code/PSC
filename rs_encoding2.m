function rs_encoded = rs_encoding2( msg, k, m )
% RS - reed-solomon encoder
%
%   this matlab script encodes the message in msg using an [ n, k ]
%   reed-solomon code with the narrow-sense generator polynomial
%
%   input is binary data flow
%   output is rs-encoded decimal numbers
%

n = 2^m - 1; % codeword length

decimal = bin2dec( num2str( msg ) );

enc = comm.RSEncoder( n, k );

encodedData = step( enc, decimal );

tmp = ( str2num(  dec2bin( encodedData ) ) );

rs_encoded = de2bi( tmp( 1 ) )';

    %Contact GitHub API Training Shop Blog About 

