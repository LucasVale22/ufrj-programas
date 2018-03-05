% Sinal de voz amostrado em 8Khz
[y, fs] = wavread('C:\Users\Lucas\Documents\teste');
sinal = resample(y,8000,44100);
%Filtro utilizando Parks-McClellan
f= [10^-10, 0.2, 0.4, 1];
peso=[1, 1, 0, 0];
parks = firpm(29,f,peso);
%Convolução
saida=conv(parks,sinal(:,1));
%Plot do Sinal
subplot(1,2,1);
plot(sinal(:,1));
title('Entrada');
subplot(1,2,2);
plot(saida);
title('Saida');
%Reprodução dos sinais de entrada e saída
sound(sinal(:,1),44100)
hold on;
sound(saida,8000)