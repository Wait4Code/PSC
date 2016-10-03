%% water filling story
% this function depends on channel assessment block ( see eval_canaux.m )

% config
snr_gap = 10^( 9.5 / 10 ); % autour de 9.5 db pour Pe=10e-7 sur une QAM
gamma = 10^( 6 / 10 ); % autour de 6 db
nb_canaux = 4;

% channel assessment
% [ H_moy, H_moy_abs, bruit_moy_abs, SNR ] = eval_canaux( nb_canaux, h_reel, pref_cycl );

% sample snr
snr = [];

for i = 1:nb_canaux
  snr( i ) = randi( 10000 );
end
disp( snr );

% number of bits per channel
b = [];

for i = 1:nb_canaux
  b( i ) = floor( log2( 1 + ( snr( i ) / ( snr_gap * gamma ) ) ) );

  if b( i ) < 0
    b( i ) = 0;
  elseif b( i ) > 15
    b( i ) = 15;
  end
end
disp( b );

