clear all;clc;
close all;

d = 0.2;
Fs = 44100;
%Nf = 256;
Nitd = 2048;
M = 60;
N = 256;

path1 = 'teste_20km\';
filename = '01 Faixa de Áudio';
str1 = strcat(path1,filename);

path2 = 'teste_18km\';
str2 = strcat(path2,filename);

path3 = 'teste1\';
str3 = strcat(path3,filename);

Nn=3; %No. de níveis de decomposição da wavelet

for j = 1:3
    clear Ct;
    for i=1:4
        if j == 1
            sensordatafilename = strcat(str1,num2str(i));
        elseif j == 2
            sensordatafilename = strcat(str2,num2str(i));
        else j == 3
            sensordatafilename = strcat(str3,num2str(i));
        end
        [Yx,FS]=wavread(sensordatafilename);
        Yx=Yx/max(Yx);
        Fs1=32000;
        Yx=resample(Yx,Fs1,Fs);
        C = swt(Yx,Nn,'db8');
        Ct(:,:,i)=C;
    end
    
    i1=1; i2=2;
    
    for n = 1:Nn+1
        clear Yxt;
        Yxt(:,i1)=Ct(n,:,i1);
        Yxt(:,i1)=Yxt(:,i1)/max(Yxt(:,i1));
        Yxt(:,i2)=Ct(n,:,i2);
        Yxt(:,i2)=Yxt(:,i2)/max(Yxt(:,i2));    
        
        figure
%         fator=1;
        phi = doa_gcc0603(2,Yxt(:,i1),Yxt(:,i2),0.2,N,Fs1);
        soundsc(Yxt(:,i1),Fs1)
        
%        pmusic(Yxt(:,i1),4);
        pause
        
    end
end
