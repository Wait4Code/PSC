function rs_decoded = rs_decoding( msg, n, k )
% RS - reed-solomon decoder
%
% this matlab script decodes the binary message in msg using an [ n, k ]
% reed-solomon code with the narrow-sense polynomial
%
% input is binary message
% output is rs decoded reed integer values
%
% example :
% rs_decoded = rs_decoding( [ 0 1 0 1 1 1 0 0 1 1 0 0 0 1 0 ]', 5, 3 );
%

deco = comm.RSDecoder( n, k );
deco.BitInput = true;

rs_decoded = step( deco, msg );
