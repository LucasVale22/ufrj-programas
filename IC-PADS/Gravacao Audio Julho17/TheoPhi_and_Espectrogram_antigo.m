function [ind2,phi2] = TheoPhi_and_Espectrogram_antigo(v,sentido,qtdeCarros,x1,Fs,mic_ver)

%****************************
%*****Alterações-2017********
%****************************
%03/08-20:32h: Parâmetros de distâncias alterados
%05/08-11:32h: Curva teórica para dois carros: apenas para o teste1
%05/08-16:15h: Adicionado o cálculo de t90 pelo máximo do espectrograma
%10/08-11:04h: Alterado o noverlap, aumentando a resolução do espectrograma
%10/08-21:43h: Cálculo de energia por janela para determinar os intervalos
                %de passagem do veículos
%*****************************
%transicao = [6.9 12 6.2 12.2 7.2 13 8.5 0 0 0];
fs = 32000;

x1aux=x1/max(x1);
x1_resample=resample(x1aux,fs,Fs);
[s_spec,f_spec,t_spec] = spectrogram(x1_resample,hamming(1024),512,1024,fs,'yaxis');
for i = 1:length(t_spec)
    max_s_spec(i) = max(s_spec(:,i));
end


N_ov = 4;                       %overlap
N_win = 40000;                  %tamanho da janela
N_hop = round(N_win/N_ov);      %salto da janela
N_sampx = length(x1_resample);  %numero total de amostras do sinal reamostrado
tempoTotal = N_sampx/fs;

m=1;
for n = 1:N_hop:N_sampx-N_win+1                         %calcula energia em cada janela e salva num vetor 
    win_p(m) = sqrt(sumsqr(x1_resample(n:n+N_win-1)));  
    Nsamp(1,m) = n;                                     %amostras que delimitam os intervalos
    Nsamp(2,m) = n+N_win-1;                             %de cada janela no sinal reamostrado   
    m=m+1;
end


[pks,locs] = findpeaks(win_p);  %obtem os picos do vetor de energia
qtdePicos = length(locs);
limiar = 10;                    %limiar para eliminar ou repor picos 
win_p_aux = win_p;

%ajusta um limiar para deixar passar apenas os picos importantes
while qtdePicos ~= qtdeCarros 
    win_p_aux = win_p;
    if qtdePicos < qtdeCarros
        limiar = limiar - 1;
        win_p_aux(win_p_aux<limiar)=0;
    elseif qtdePicos > qtdeCarros 
        limiar = limiar + 1;
        win_p_aux(win_p_aux<limiar)=0;
    end
    [pks,locs] = findpeaks(win_p_aux);
    qtdePicos = length(locs);
end


% tp=0:0.5:(m-2)*0.5;
% plot(tp,db(win_p_aux));
% xlabel('Time t in sec.'), ylabel('Power in DB.');
% title(['Signal Power:']);
% grid on, axis tight;
% pause;


for i=1:qtdeCarros
    %calcula as amostras do espectrograma que correspondem
    %ao do sinal reamostrado para cada carro a cada iteracao
    Nispec = round(Nsamp(1,locs(i))*length(max_s_spec)/N_sampx);
    Nfspec = round(Nsamp(2,locs(i))*length(max_s_spec)/N_sampx);
    Nspec90_ref = (Nispec+Nfspec)/2;    %referencial para amostra em 90 graus
    Nspec90(i) = Nfspec;                %condicao inicial para amostra em 90 graus

    %tentativa de aproximar o pico do valor esperado
    erro_spec = 4;
    while abs(Nspec90-Nspec90_ref) > erro_spec

        [max_s_specmax,it90max] = max(max_s_spec(Nispec:Nfspec));
        Nspec90(i) = Nispec + it90max;
        Nispec = Nispec+1;
        Nfspec = Nfspec-1;

    end
    t90(i) = (Nspec90(i)*tempoTotal)/length(max_s_spec);
end

transicao(1)=0;
transicao(qtdeCarros+1)=tempoTotal;
if qtdeCarros > 1
    for i = 2:qtdeCarros
        transicao(i) = (t90(i-1)+t90(i))/2;
    end
end

ind=0;
ind2=transicao(1):0.01:transicao(qtdeCarros+1);
phi2=zeros(length(ind2),1);

for i=1:qtdeCarros     
    
    for t2=transicao(i):0.01:transicao(i+1)
        ind=ind+1;
        l(ind)=((t2-t90(i))*v*10/36);
        d=0.2;
        d1=sqrt(l(ind)^2+(1.26)^2+(4.3)^2);
        d2=sqrt((l(ind))^2+(1.26+d)^2+(4.3)^2);
        delta(ind)=d2-d1;
        if sentido == '0° -> 180°' & mic_ver ~= 4
           delta(ind) = -delta(ind); 
        end
        dt=delta(ind)/343;
        
        phi2(ind)=acos(delta(ind)/0.2)/pi*180;
    end
    
    transicao(i+1)=transicao(i+1)+0.01;
    
end


N_spec_win = (N_win*length(max_s_spec))/N_sampx;

for i=1:qtdeCarros
    subplot(qtdeCarros+1,1,i);
    Nspec90(i) = round(Nspec90(i));
    
    for j=1:length(s_spec(:,Nspec90(i)))
        media_s_spec(j) = mean(s_spec(j,(Nspec90(i)-N_spec_win/2):(Nspec90(i)+N_spec_win/2)));
    end
    f_spec2 = f_spec/1000;
    plot(f_spec2,db(s_spec(:,Nspec90(i))));
    xlabel('Frequency in KHz.'), ylabel('Power in DB.');
    title(['Signal spectrum in 90 degrees: Car ',num2str(i)]);
    grid on, axis tight;
end


tpasso = tempoTotal/length(win_p);

subplot(qtdeCarros+1,1,qtdeCarros+1);
tp=0:tpasso:(m-2)*tpasso;
plot(tp,db(win_p));
xlabel('Time t in sec.'), ylabel('Power in DB.');
title('Signal Power:');
grid on, axis tight;
pause;

subplot(2,1,2);
spectrogram(x1_resample,hamming(1024),840,1024*2,fs,'yaxis');


fprintf('\n');
for i=1:qtdeCarros
    tempo(i) = (Nspec90(i)*tempoTotal)/length(max_s_spec);
    fprintf('Carro %d: t90 = %0.2f s\n', i, tempo(i));
end
for i=2:qtdeCarros
    deltaT90 = tempo(i)-tempo(i-1);
    distCar = (v*deltaT90)/3.6;
    fprintf('Intervalo entre os carros %d e %d: %0.2f s\n',i-1,i, deltaT90);
    fprintf('Distância entre os carros %d e %d: %0.2f m\n',i-1,i, distCar);
end
%spectrogram(x1,kaiser(1024,5),256,2048,Fs,'yaxis');
%axis([0 15 0 16]);
grid on
subplot(2,1,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
