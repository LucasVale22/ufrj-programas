function [ind2,phi2] = TheoPhi_and_Espectrogram(v,t90,x1,Fs)

T=13;
ind=0;
ind2=0:0.1:T;
for t2=0:0.1:T
    ind=ind+1;
    l(ind)=((t2-t90)*v*10/36);
    d=0.2;
    d1=sqrt(l(ind)^2+(1.5)^2+(3)^2);
    d2=sqrt((l(ind)+d)^2+(1.5)^2+(3)^2);
    delta(ind)=d2-d1;
    dt=delta(ind)/343;
    % ns=dt*44100
    % np=dt*600
    phi2(ind)=acos(delta(ind)/0.2)/pi*180;
end
%figure
%plot(ind2,phi2);
%figure
%plot(ind2,l)
%figure
%plot(ind2,delta)
subplot(2,1,2);
x1aux=x1/max(x1);
x1_resample=resample(x1aux,32000,Fs);
spectrogram(x1_resample,hamming(1024),512,1024,32000,'yaxis')
%spectrogram(x1,kaiser(1024,5),256,2048,Fs,'yaxis');
%axis([0 15 0 16]);
grid on
subplot(2,1,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
