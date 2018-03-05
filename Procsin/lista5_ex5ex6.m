wp = 0.2; ws = 0.4;
A = 40; rp = -20*log10(1-0.005);

%Aproximação pelo metodo de Butterworth
[nb,wnb] = buttord(wp,ws,rp,A);
[b,a] =butter(nb,wnb);
[Hb,wb] = freqz(b,a);
figure(1);
freqz(b,a);

%Aproximação pelo metodo de Chebyshev

[nc, wnc]= cheb1ord(wp,ws,rp,A);
[b,a]= cheby1(nc,rp,wnc);
[Hc,wc] = freqz(b,a);
figure(2);
freqz(b,a);

%Aproximação pelo método Elíptico

[ne, wne]= ellipord(wp,ws,rp,A);
[b,a]= ellip(ne,rp,A,wne);
[He,we] = freqz(b,a);
figure(3);
freqz(b,a);

nb =  9
>> nc
nc =  6
>> ne
ne =  4