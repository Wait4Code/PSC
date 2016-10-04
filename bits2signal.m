function x=bits2signal(sous_trame,tab,prefixe_cyclique)

%cette fonction prend un sous-trame en bits comme entrée et renvoie la sous_trame en
%temps à transmettre dans les canal.

% sous_trame est un supertrame sans la parie synchronisaton.
% tab est le vecteur d'allocation de bits
% préfixe cyclique correspond le nombre de préfixe qu'on va ajouter au
% début du signal à transmettre.

N=length(tab); % nb de canaux
v=prefixe_cyclique; %taille de prefixe

suite_symb=[];
k=1;
for i=1:N
    suite_symb(i) = codage_symb(sous_trame(k:k+tab(i)-1),2^(tab(i)));
    suite_symb(i) = modulationQAM(suite_symb(i),2^(tab(i)));
    k=k+tab(i);
end

x=modulationDMT(suite_symb,N,v);