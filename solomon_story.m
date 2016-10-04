n=7; k=3; % Codeword and message word lengths
m=3; % Number of bits per symbol
msg = gf([5 2 3; 0 1 7;3 6 1],m) % Two k-symbol message words
% message vector is defined over a Galois field where the number must
%range from 0 to 2^m-1

codedMessage = rsenc(msg,n,k) % Two n-symbol codewords

dmin=n-k+1 % display dmin
t=(dmin-1)/2 % diplay error correcting capability of the code

% Generate noise – Add 2 contiguous symbol errors with first word;
% 2 discontiguous symbol errors with second word and 3 distributed symbol
% errors to last word
noise=gf([0 0 0 2 3 0 0 ;6 0 1 0 0 0 0 ;5 0 6 0 0 4 0],m)

received = noise+codedMessage

%dec contains the decoded message and cnumerr contains the number of
%symbols errors corrected for each row. Also if cnumerr(i) = -1 it indicates
%that the ith row contains unrecoverable error
[dec,cnumerr] = rsdec(received,n,k)
% print the original message for comparison
msg

% Given below is the output of the program. Only decoded message, cnumerr and original
% message are given here (with comments inline)

% The default primitive polynomial over which the GF is defined is D^3+D+1 ( which is 1011 -> 11 in decimal).   