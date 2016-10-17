function [ suite_bits, x ] = demodulationDMT( signal_recu, h_eval_mod, nb_canaux, lgre_pref_cyclique, tab )
% inputs :
% - signal_recu : signal reçu après passage dans le canal
% - h_eval_mod : module de la réponse impulsionnelle du canal, identifiée
% - nb_canaux : nombre de canaux utilisés
% - lgre_pref_cyclique : longueur du CP
% - tab : vecteur table allocation des bits
%
% outputs : suite_bits et x
%

%% Suppression du préfixe cyclique

signal_recu = signal_recu( ( lgre_pref_cyclique + 1 ):( 2*nb_canaux + lgre_pref_cyclique ) );

%% FFT et égalisation du signal

x_fft = fft( signal_recu );
x = x_fft( 1:nb_canaux ); % suppression des coordonnées conjuguées introduites avant IFFT
x = x./h_eval_mod; % égalisation

%% Reconstruction des symboles et démodulation

suite_bits = [];
for i = 1:nb_canaux
  M = 2^( tab(i) );
  symb = qamdemod( x(i), M );
  suite_bits = [ suite_bits decodage_symboles( symb, M ) ];
end
