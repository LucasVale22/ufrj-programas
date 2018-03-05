echo on

% ADAPTIVE MICROPHONE ARRAY WITH SPEAKER TRACKING
%
% speaker moves from 90° (broadside) to 0° (endfire), back to 90°, and
% finally to 180°
%
% show usage of program adaptive_beam.m
%
% (c) G. Doblinger, Vienna University of Technology, 2006
% g.doblinger@tuwien.ac.at
% http://www.nt.tuwien.ac.at/about-us/staff/gerhard-doblinger/
%
clear all, close all, clc;

d = 0.2;
Fs = 44100;
N = 256;

path1 = 'teste_20km\';
filename = '01 Faixa de Áudio';
str1 = strcat(path1,filename);

path2 = 'teste_18km\';
str2 = strcat(path2,filename);

path3 = 'teste1\';
str3 = strcat(path3,filename);

% load mics_harmon_original.mat            % load microphone array geometry
mics=[-0.3 0; -0.1 0; 0.1 0; 0.3 0];
Lov = 4;
M = round(N/Lov);
%B=M;
B = 2048*2
for j = 1:1
    for i=1:4
        if j == 1
            sensordatafilename = strcat(str1,num2str(i));
        elseif j == 2
            sensordatafilename = strcat(str2,num2str(i));
        else j == 3
            sensordatafilename = strcat(str3,num2str(i));
        end
        [X,FS]=wavread(sensordatafilename);
        
        %     Yx=Yx(5e4:3e5);
        Xt(1:length(X),i)=X/max(X);
    end
    
    Nx =length(X);
    %NB=floor((Nx-N+1)/M);
    NB=floor((Nx-N+1)/B);    
    %B=tamanho do bloco (janela)
    %NB=número de blocos
    %i1=1; i2=2;
    %figure
    %phi = doa_gcc0603(2,Xt(:,i1),Xt(:,i2),0.2,N,Fs);

%     T=14;
%     ind=0;
%     ind2=0:0.1:T;
%     for t2=0:0.1:T
%         ind=ind+1;
%         l(ind)=((t2-10.5)*20*10/36);
%         d=0.2;
%         d1=sqrt(l(ind)^2+(1.5)^2+(3)^2);
%         d2=sqrt((l(ind)+d)^2+(1.5)^2+(3)^2);
%         delta(ind)=d2-d1;
%         dt=delta(ind)/343;
%         phi2(ind)=acos(delta(ind)/0.2)/pi*180;
%     end
%         
    %phi2 = [phi2 0 0 0 0 0 0 0 0 0 0];
    %ind2 = [ind2 13.1 13.2 13.3 13.4 13.5 13.6 13.7 13.8 13.9 14]
    %plot(ind2,phi2);
    %pause   

    %phi = int16(phi);
    yt=[];
%     for i=1:NB
%         Xb=Xt((i-1)*B+1:i*B,:);
%         %b = quant(phi(i))
%         %a = int16(phi(i))
%         %a = phi(i)
%         phi2(i)
%         if (phi2(i)> 14 && phi2(i)< 16)
%             y = adaptive_beam_modificado(Xb,mics,phi2(i),0.01,4,4000,Fs);% adaptive array with beamformer look direction = 90°% 
%             pause
%         elseif (phi2(i)> 44 && phi2(i)< 46)
%             y = adaptive_beam_modificado(Xb,mics,phi2(i),0.01,4,4000,Fs);
%             pause
%         elseif (phi2(i)> 89 && phi2(i)< 91)
%             y = adaptive_beam_modificado(Xb,mics,phi2(i),0.01,4,4000,Fs);
%             pause
%         elseif (phi2(i)> 134 && phi2(i)< 136)
%             y = adaptive_beam_modificado(Xb,mics,phi2(i),0.01,4,4000,Fs);
%             pause
%         elseif (phi2(i)> 164 && phi2(i)< 166)
%             y = adaptive_beam_modificado(Xb,mics,phi2(i),0.01,4,4000,Fs);
%             pause
%         end    
%         %yt=[yt y];
%     end
    %plot(yt);
    y = adaptive_beam_modificado(Xt,mics,90,0.01,4,1000,Fs);
    pause
    
end
