enc = comm.RSEncoder(240,224,'BitInput', true);
sizemsg=224*8;
msg = zeros(1, sizemsg);
for i = 1:sizemsg
    msg(i) = mod(i,2);
end
%disp(enc);
%msg = [0; 0; 1; 1; 0; 0; 1; 1; 0; 0; 1; 1; 0; 0; 1; 0; 0; 1; 1; 0; 0; 1; 1; 0; 0; 1; 1; 0; 0; 1; 0; 0; 1; 1; 0; 0; 1; 1; 0; 0; 1; 1; 0; 0; 1];
cod = step( enc, msg' );
txt1= sprintf('Longueur du mot initial : %d !\nLongeur du mot codé en RS : %d', sizemsg, length(cod));
disp(txt1);

cod(20:1920)=bitxor(cod(20:1920),1);

enco = comm.RSDecoder(240,224,'BitInput', true);
deco = step( enco, cod );
txt2=sprintf('Longueur du mot décodé : %d', length(deco));
disp(txt2);
disp(sum(deco - msg'));