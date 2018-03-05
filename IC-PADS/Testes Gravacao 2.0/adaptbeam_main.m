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
for j = 1:3
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
    %y = adaptive_beam_modificado(Xt,mics,90,0.01,4,1000,Fs);
    %y = adaptive_beam_modificadoPhiEstimado(Xt,mics,90,0.01,4,1000,Fs);
    y = adaptive_beam_calc_potencia(Xt,mics,10,0.01,4,1000,Fs);
    pause
end
