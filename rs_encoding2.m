function rs_encoded = rs_encoding2( msg, m )
% RS - reed-solomon encoder
%
%   this matlab script encodes the message in msg using an [ n, k ]
%   reed-solomon code with the narrow-sense generator polynomial
%
%   input is binary data flow
%   output is rs-encoded decimal numbers
%

%m = 3; % Number of bits per symbol
n = 5; % Codeword length
%k = 3; % Message length

msg = gf( msg, m )

rs_encoded = rsenc( msg, n, length( msg ) )