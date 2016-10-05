function b= allocation_bits(SNR)

    % config
    snr_gap = 10^( 9.5 / 10 ); % autour de 9.5 db pour Pe=10e-7 sur une QAM
    gamma = 10^( 6 / 10 ); % autour de 6 db environ : La marge du rapport signal sur bruit
    nb_canaux = 4;

    % number of bits per channel
    b = [];

    for i = 1:nb_canaux
      b( i ) = round( log2( 1 + SNR( i ) / ( snr_gap * gamma ) ) );

      if b( i ) < 0
        b( i ) = 0;
        
      elseif b( i ) > 15
        b( i ) = 15;
        
      end
    end
    
    
    disp( b );
    
    plot( 1:nb_canaux, b );
    
end