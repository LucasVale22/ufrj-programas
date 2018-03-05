clear all;
clc;
close all;


for indiceTeste = 1:10
    pathAudio = strcat('BancoAudios/'); % Caminho para a pasta com os áudios
    
    % Lendo arquivo de texto
    fileName = strcat(pathAudio, 'Teste', num2str(indiceTeste), '.txt'); % Nome do arquivo txt
    fileID = fopen(fileName,'r');
        
    fgetl(fileID); % Pula as duas
    fgetl(fileID); % primeiras linhas
        
    velocidade = fgetl(fileID); % Extrai linha que contem velocidade
    sentido = fgetl(fileID);    % Extrai linha que contem sentido
    qtdeCarros = fgetl(fileID); % Extrai linha que contem qtde de carros
    
    % Ignorando as próximas linhas 
    fgetl(fileID); fgetl(fileID); fgetl(fileID); fgetl(fileID);
    
    instantes = fgetl(fileID);
    
    fclose(fileID);
    
    % Extraindo dados das linhas do arquivo de texto
    velocidade = regexp(velocidade, '\d*', 'match');
    velocidade = str2num(char(velocidade));
    sentido = sentido(10:19);
    qtdeCarros = regexp(qtdeCarros, '\d*', 'match');
    qtdeCarros = str2num(char(qtdeCarros));
    
    
    % Lendo arquivo de audio
    for indiceCarro = 1:qtdeCarros
        Yxt = [];
        for indiceMic = 1:4
            fileName = strcat(pathAudio,'teste', num2str(indiceTeste),'_carro', num2str(indiceCarro) ,'_v', num2str(velocidade),'_mic',num2str(indiceMic),'.wav');
            [Yx,Fs] = audioread(fileName);
            Yxt(1:length(Yx),indiceMic)=Yx/max(Yx);
        end
        
    % Definição dos parâmetros
    algorithm_code = 2;
    d= 0.2;
    v = velocidade;
    sound_speed = 343;
    dist_source_mic = 3.6;
    dist_source_source = 2.5;
    dist_mic_mic = 0.2;
    heigth_mic = 1.26;
    T = round(length(Yxt(:,1))/Fs); % Period of time over which DOA will be avaluated    
    mic1=2;   % mic1 e mic2 são os microfones
    mic2=4;   % usados nos algorítimos de estimação do DOA
    mic_ver = max(mic1,mic2);
    % Fs = 44100;
    % N = 256;
    Nitd = 2048;
    Fresample = 44100;
    N = 512;

    
    % Calculando DOA
    yx_resample = resample(Yxt, Fresample, Fs);
    [t90, Nspec90, N_spec_win, f_spec, media_s_spec] = calc_t90(yx_resample(:,1), Fresample);
    [phi, tdd, t, tau, Cmat] = doa_gccfullBand(2, yx_resample(:,mic1), yx_resample(:,mic2),0.2,N,Fresample,velocidade,sentido,qtdeCarros);
    [phi_theo_1, phi_theo_2, tdd_theo, tdd_theo_2] = phi_theo_multisource (velocidade, t90, sentido, dist_source_mic, dist_source_source, heigth_mic, T, mic_ver);
        
    %%%%%%%%%%% PLOT
    pathImg = 'imagens\';
    close all
    figurebackcolor = 'black';
    
%    Plotar TDD e DOA estimados e teórico
    pos = [0.01 0.52 0.49 0.40];
    fp1 = figure('numbertitle','off','name','GCC e TDD',...
             'Units','normal','Position', pos);
    colordef(fp1,figurebackcolor);
    
    imagesc(t,tau,Cmat); 
    colormap(cool), colorbar; 
    set(gca,'YDir','normal'); hold on
    %p = plot(t, tdd, 'Color','b');
    ylabel('Delay \tau in secs)');
    xlabel('Time t (s)');
    title('GCC-PHAT R_{x_1x_2}(\tau,t) Function');
    grid on;
    %legend('show'); legend(p,   'TDD GCC', ...
    %                            'Location', 'southeast');
    
    fig = gcf;
    fig.InvertHardcopy = 'off';
    filename = strcat(pathImg, 'teste', num2str(indiceTeste),'_carro', num2str(indiceCarro) ,'_v', num2str(velocidade), '_f', num2str(Fresample),'_N', num2str(N),'_GCCPHAT_DOA.png');
    print(gcf, filename,'-dpng','-r300'); % Salvando imagem em arquivo png

    filename = strcat(pathImg, 'teste', num2str(indiceTeste),'_carro', num2str(indiceCarro) ,'_v', num2str(velocidade), '_f', num2str(Fresample),'_N', num2str(N),'_GCCPHAT_TDD.png');
    print(gcf, filename,'-dpng','-r300'); % Salvando imagem em arquivo png
    
    
    pos = [0.51 0.52 0.49 0.40];
    fp1 = figure('numbertitle','off','name','GCC e TDD',...
             'Units','normal','Position', pos);
    colordef(fp1,figurebackcolor);
    t_theo = 0:0.1:T;
    t = linspace(0, T, length(phi));
    p1 = plot(t, phi, 'Color', 'c', 'Linewidth', 2); hold on;
    p2 = plot(t_theo, phi_theo_1, 'y', 'Linewidth', 2);
    p2.LineStyle = '--';
    ylabel('Azimut \phi in degrees');
    xlabel('Time t in secs');
    xlim([t(1) t(end)]);
    h = [p1; p2];
    legend('show'); legend(h,   'DOA GCC PHAT',...
                                'DOA Theoretical',...
                                'Location', 'southwest');
    title('GCC PHAT DOA Estimation');
    grid on;
    
    fig = gcf;
    fig.InvertHardcopy = 'off';
    filename = strcat(pathImg, 'teste', num2str(indiceTeste),'_carro', num2str(indiceCarro) ,'_v', num2str(velocidade), '_f', num2str(Fresample),'_N', num2str(N),'_GCCPHAT_DOA.png');
    print(gcf, filename,'-dpng','-r300'); % Salvando imagem em arquivo png

    
    % Plotar espectrograma e espectro para o ângulo 90°
    pos = [0.01 0.03 0.49 0.40];
    fp1 = figure('numbertitle','off','name','DOA',...
         'Units','normal','Position', pos);
    colordef(fp1,figurebackcolor);
    hold on
    
    %subplot(2,1,1)
    spectrogram(yx_resample(:,1), hamming(N), N/2, N, Fresample, 'yaxis');
    title(['Spectrogram, Fs = ', num2str(Fresample), ', Window = ', num2str(N)]);
    
    fig = gcf;
    fig.InvertHardcopy = 'off';
    filename = strcat(pathImg, 'teste', num2str(indiceTeste),'_carro', num2str(indiceCarro) ,'_v', num2str(velocidade), '_f', num2str(Fresample),'_N', num2str(N),'_SPECTROGRAM.png');
    print(gcf, filename,'-dpng','-r300'); % Salvando imagem em arquivo png
    
    %subplot(2,1,2)
    pos = [0.51 0.03 0.49 0.40];
    fp1 = figure('numbertitle','off','name','DOA',...
         'Units','normal','Position', pos);
    colordef(fp1,figurebackcolor);
    [s_spec,f_spec,t_spec] = spectrogram(yx_resample(:,1), hamming(N), N/2, N*2, Fresample);
    plot(f_spec, db(media_s_spec));% f_spec, db(s_spec(:,Nspec90)));
    xlabel('Frequency in KHz.'), ylabel('Power in DB.');
    title(['Signal spectrum in 90 degrees']);
    grid on; axis tight;
    
    fig = gcf;
    fig.InvertHardcopy = 'off';
    filename = strcat(pathImg, 'teste', num2str(indiceTeste),'_carro', num2str(indiceCarro) ,'_v', num2str(velocidade), '_f', num2str(Fresample),'_N', num2str(N),'_SPECTRO_90.png');
    print(gcf, filename,'-dpng','-r300'); % Salvando imagem em arquivo png



%     phi = doa_aevdfullBand(Yxt(:,mic1),Yxt(:,mic2),d,512,2048,0.3,Fs,velocidade,sentido,qtdeCarros);
%     pause
% 
%     phi=doa_itdfullBand(Yxt(:,mic1),Yxt(:,mic2),d,Nitd,Fs,0.9,velocidade,t90,sentido);
%     pause
% 
%     phi = doa_fastlmsfullBand(Yxt(:,mic1),Yxt(:,mic2),d,512,2048,0.25,Fs,v,t90,sentido);
%     pause
    end
end

close all;
