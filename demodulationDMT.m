function [suite_bits,x]=demodulationDMT(signal_recu,h_eval_mod,nombre_canaux,prefixe_cyclique,tab)
 
% signal_recu signal reçu après passage dans le canal
% h_eval_mod module de la réponse impulsionnelle du canal, identifi�e
% nombre_canaux nombre de canaux utilis�s
% prefixe_cyclique longueur du CP
% tab vecteur table allocation des bits
 
 
%%%%%%%%%%%%%%%%%%
% Initialisation %
%%%%%%%%%%%%%%%%%%
 
N=nombre_canaux; % Nombre de canaux utilis�s
v=prefixe_cyclique; % Longueur du CP
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Suppression du CP               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
signal_recu=signal_recu(v+1:2*N+v); 
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FFT et �galisation du signal % 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
x_fft=fft(signal_recu); 
x=x_fft(1:N); % suppression des coordonn�es conjugu�es introduites avant IFFT 
x=x./h_eval_mod; % égalisation
 
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reconstruction des symboles et d�modulation %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
symb=[]; % Contiendra les symboles sous forme décimale
for i=1:N
    symb(i)=demodulationQAM(real(x(i)),imag(x(i)),2^(tab(i)));
end
 
% suite de bits
suite_bits=[]; 
for j=1:N
    suite_bits=[suite_bits decodage_symb(symb(j),2^(tab(j)))];
    % suite_bits=[suite_bits decodage_symboles(symb(j),2^(tab(j)))];% prof
end

