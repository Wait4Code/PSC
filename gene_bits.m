function suite_bits = gene_bits( N, p0 )
% Génération d'une suite de bits aléatoire
%
% La fonction gene_bits génère une suite binaire aléatoire de longueur N.
%
% arguments :
% - N est la longueur de la suite
% - p0 est la probabilité d'avoir un 0 (p0 = 1/2 <=> cas équiprobable)
%

suite_ini = sign( rand( 1, N ) - p0 * ones( 1, N ) ); % On obtient une suite de -1,0,1

% On va transformer les '0' en '1'
for i = 1:N
  if suite_ini(i) == 0
    suite_ini(i) = 1;
  end
end

% Et on transpose finalement la suite de -1,1 en une suite de 0,1
suite_bits = 0.5 * ( suite_ini + 1 );
