clear all;clc;
close all;

d = 0.2;
Fs = 44100;
N = 256;
Nitd = 2048;

path = 'Teste1\';
filename = 'FaixadeAudio';
str = strcat(path,filename);


for i=1:4
    
    %Lembrando que o microfone ID=5 é o quarto(4) microfone utilizado no
    %programa para facilitar, já o de ID=4 estava defeituoso!
    
    sensordatafilename = strcat(str,num2str(i));
    if path(6) == '1' 
        if path(7) == '0'%teste10
            v = 70;
            t90 = 6.5;
        else %teste1
            v = 30;
            t90 = 5.687;
        end
    elseif path(6) == '2' 
        v = 30;
        t90 = 10.5;
    elseif path(6) == '3' 
        v = 40;
        t90 = 10.5;
    elseif path(6) == '4' 
        v = 40;
        t90 = 10.5;
    elseif path(6) == '5' 
        v = 50;
        t90 = 10.5;
    elseif path(6) == '6' 
        v = 50;
        t90 = 10.5;
    elseif path(6) == '7' 
        v = 60;
        t90 = 10.5;
    elseif path(6) == '8' 
        v = 60;
        t90 = 10.5;
    elseif path(6) == '9' 
        v = 60;
        t90 = 10.5;
    end
    [Yx,FS]=wavread(sensordatafilename);
    %Yx=Yx(5e4:3e5);
    Yxt(1:length(Yx),i)=Yx/max(Yx);
end

    i1=1;
    i2=2;
    %figure,plot(Yxt);
    %
    %pause

    figure
    phi = doa_gccfullBand(2,Yxt(:,i1),Yxt(:,i2),0.2,N,Fs,v,t90);
    pause
    
    %pmusic(Yxt(:,i1),4);
    %pause

    phi = doa_aevdfullBand(Yxt(:,i1),Yxt(:,i2),d,512,2048,0.3,Fs,v,t90);
    pause

    phi=doa_itdfullBand(Yxt(:,i1),Yxt(:,i2),d,Nitd,Fs,0.9,v,t90);
    pause

    phi = doa_fastlmsfullBand(Yxt(:,i1),Yxt(:,i2),d,512,2048,0.25,Fs,v,t90);
    pause


close all;
