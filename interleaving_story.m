%% configuration
nrows = 3; % use 3 delay lines
slope = 2; % delay are 0, 4, 8, 12
delay = nrows * ( nrows - 1 ) * slope;

%% interleaving
% msg = randi( [0 1], 1, 6 ); % original data
msg = [ 0 1 0 1 1 0 1 1 1 1 1 1 0 1 0 1 0 1  ];

disp( 'msg=' );
disp( msg );

% append d symbols of delay to end of message
msg = [ msg zeros( 1, delay ) ];

% convolutional interleaver
intrvled = convintrlv( msg, nrows, slope );

disp( 'intrvled=' );
disp( intrvled );

%% deinterleaving
% convolutional deinterleaver
deintrlved = convdeintrlv( intrvled, nrows, slope );

% omit the first d symbols of recovered data
deintrlved = deintrlved( (delay+1):end );

disp( 'deintrlved=' );
disp( deintrlved );
