function suite_bits=gene_bits(N,p0)

% La fonction gene_bits g�n�re une suite binaire al�atoire de longueur N.

% N est la longueur de la suite.
% p0 est la probabilit� d'avoir un 0 (p0 = 1/2 <=> cas �quiprobable).


suite_ini=sign(rand(1,N)-p0*ones(1,N)); % On obtient une suite de -1,0,1

% On va transformer les '0' en '1'
for i=1:N
    if suite_ini(i)==0 suite_ini(i)=1;
    end
end

% Et on transpose finalement la suite de -1,1 en une suite de 0,1
suite_bits=0.5*(suite_ini+1); 