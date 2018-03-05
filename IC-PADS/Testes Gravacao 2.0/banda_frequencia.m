clear all;clc;
close all;

d = 0.2;
Fs = 44100;
Nf = 256;
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

f_s=32000*[2^(-(Nn)) 2.^(-(Nn:-1:1))];
for j = 1:3
    clear Ct;
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
        Yx=Yx/max(Yx);
        Yx=resample(Yx,32000,Fs);
        [C,L] = wavedec(Yx,Nn,'db8');
        Ct(:,i)=C;
    end
    
    i1=1; i2=2;
        
    ind1=1;
    
    for n = 1:Nn+1
        clear Yxt;
        ind2=ind1+L(n)-1;
        Yxt(:,i1)=Ct(ind1:ind2,i1);
        Yxt(:,i2)=Ct(ind1:ind2,i2);
        figure
                fator=f_s(n)/32000*2
%         fator=1;
        phi = doa_gcc1603BandaFreq(2,Yxt(:,i1),Yxt(:,i2),0.2,N*fator,f_s(n),v,t90);
        ind1=ind2+1;
        soundsc(Yxt(:,i1),f_s(n))
        %wavwrite(Yxt(:,i1),f_s(n),strcat('sampling rate',num2str(n)))
%        pmusic(Yxt(:,i1),4);
        pause
        
    end
end
