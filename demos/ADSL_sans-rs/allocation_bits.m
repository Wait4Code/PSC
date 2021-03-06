function b = allocation_bits( snr )
% fonction d'allocation de bits en fonction du SNR
%
% inputs :
% - snr est un tableau ligne de snr pour les n canaux
%
% output is a table of number of bits allocated for each sub-channel
%
% example :
%
%     b = allocation_bits( [ 5 10 12 ] )

% configuration
snr_gap = 10^( 9.5 / 10 ); % autour de 9.5 db pour Pe=10e-7 sur une QAM
gamma = 10^( 6 / 10 ); % autour de 6 db environ : La marge du rapport signal sur bruit
nb_canaux = length( snr );

% nombre de bits par cannal
b = zeros( 1, nb_canaux );

for i = 7:nb_canaux
  b(i) = round( log2( 1 + snr(i) / ( snr_gap * gamma ) ) );

  if b(i) < 0
    b(i) = 0;
  elseif b(i) > 15
    b(i) = 15;
  end
end

%bits reservés
b(32)=0;        % Réservé pour la séparation des flux montant et descendant
b(16)=0;        % Signal pilote
b(64)=0;        % Signal pilote


figure();
stem(b);
title('Répartition bits par canal');

end
