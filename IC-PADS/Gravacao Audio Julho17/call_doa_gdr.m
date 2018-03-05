
clear all;
clc;
close all;

d = 0.2;
Fs = 44100;
N = 256;
Nitd = 2048;


for j = 1:10
    Yxt = [];
    for i=1:4
        path = strcat('Teste', num2str(j), '\');    % Caminho para o teste de áudio atual
       
        % Lendo arquivo de audio
        fileName = strcat(path,'FaixadeAudio',num2str(i),'.wav');
        [Yx,FS]=audioread(fileName);
        Yxt(1:length(Yx),i)=Yx/max(Yx);
    end

    % Lendo arquivo de texto
    fileName = strcat(path, 'Teste', num2str(j), '.txt'); % Nome do arquivo txt
    fileID = fopen(fileName,'r');
        
    fgetl(fileID); % Pula as duas
    fgetl(fileID); % primeiras linhas
        
    velocidade = fgetl(fileID); % Extrai linha que contem velocidade
    sentido = fgetl(fileID);    % Extrai linha que contem sentido
    qtdeCarros = fgetl(fileID); % Extrai linha que contem qtde de carros
    
    fgetl(fileID);
    fgetl(fileID);
    fgetl(fileID);
    fgetl(fileID);
    
    instantes = fgetl(fileID);
    
    fclose(fileID);
    
    % Extraindo dados das linhas
    
    velocidade = regexp(velocidade, '\d*', 'match');
    velocidade = str2num(char(velocidade));
    sentido = sentido(10:19);
    qtdeCarros = regexp(qtdeCarros, '\d*', 'match');
    qtdeCarros = str2num(char(qtdeCarros));
    
    mic1=2;   % mic1 e mic2 são os microfones 
    mic2=4;   % usados nos algorítimos de estimação do DOA
    
    mic_ver = max(mic1,mic2);

%     phi = doa_gccfullBand(2,Yxt(:,mic1),Yxt(:,mic2),0.2,N,Fs,velocidade,sentido,qtdeCarros,mic_ver);
%     
%     pause

    phi = doa_aevdfullBand(Yxt(:,mic1),Yxt(:,mic2),d,512,2048,0.3,Fs,velocidade,sentido,qtdeCarros);
    pause

%     phi=doa_itdfullBand(Yxt(:,mic1),Yxt(:,mic2),d,Nitd,Fs,0.9,velocidade,t90,sentido);
%     pause
% 
%     phi = doa_fastlmsfullBand(Yxt(:,mic1),Yxt(:,mic2),d,512,2048,0.25,Fs,v,t90,sentido);
%     pause

end

close all;
