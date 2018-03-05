f = [0, 0.1, 0.3,  0.5, 0.7, 1]; % frequências
peso = [0, 0, 1, 1, 0, 0]; % "Janela" de pesos
parks = firpm (26, f, peso);
freqz(parks,1);