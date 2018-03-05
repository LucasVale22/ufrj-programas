clear all;clc;
close all;

d = 0.2;
Fs = 44100;
N = 256;
Nitd = 2048;

path1 = 'teste_20km\';
filename = '01 Faixa de Áudio';
str1 = strcat(path1,filename);

path2 = 'teste_18km\';
str2 = strcat(path2,filename);

path3 = 'teste1\';
str3 = strcat(path3,filename);

Nn=3;

for j = 1:1
    for i=1:4
        if j == 1
            sensordatafilename = strcat(str1,num2str(i));
            v = 20;
            t90 = 10.5;
        elseif j == 2
            sensordatafilename = strcat(str2,num2str(i));
            v = 18;
            t90 = 10.7;
        else j == 3
            sensordatafilename = strcat(str3,num2str(i));
            v = 15;
            t90 = 11;
        end
        [Yx,FS]=wavread(sensordatafilename);
    %     Yx=Yx(5e4:3e5);
        %Yxt(1:length(Yx),i)=Yx/max(Yx);
        Yx=Yx/max(Yx);
        Fs1=32000;
        Yx=resample(Yx,Fs1,Fs);
        C = swt(Yx,Nn,'db8');
        Ct(:,:,i)=C;
    end

    i1=1;
    i2=2;
    %figure,plot(Yxt);
    %pause
    
    for n = 1:Nn+1
        clear Yxt;
        Yxt(:,i1)=Ct(n,:,i1);
        Yxt(:,i1)=Yxt(:,i1)/max(Yxt(:,i1));
        Yxt(:,i2)=Ct(n,:,i2);
        Yxt(:,i2)=Yxt(:,i2)/max(Yxt(:,i2));
    
        %figure
        phi = doa_gcc2003fullBand(2,Yxt(:,i1),Yxt(:,i2),0.2,N,Fs,v,t90);
        %pmusic(Yxt(:,i1),4);
        pause

        phi = doa_aevd0204fullBand(Yxt(:,i1),Yxt(:,i2),d,512,2048,0.3,Fs,v,t90);
        pause

        phi=doa_itd0204fullBand(Yxt(:,i1),Yxt(:,i2),d,Nitd,Fs,0.9,v,t90);
        pause

        phi = doa_fastlms0204fullBand(Yxt(:,i1),Yxt(:,i2),d,512,2048,0.25,Fs,v,t90);
        pause
    
    end

end

close all;
