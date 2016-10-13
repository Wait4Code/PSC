function symb_complexe = modulationQAM( symb_deci, M )

% Associe à un symboles écrit en décimale, un symboles complexe
% correspondant

% symb_deci est le symbole décimal à moduler.
% M est le nombre de points de la constellation.

symb_complexe = qammod( symb_deci, M ); % Cela donne un nombre complexe
