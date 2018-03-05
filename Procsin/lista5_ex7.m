w1=1.5/5; w2=2.5/5;
wr1=0.5/5; wr2=3.5/5;
A=60; rp= -20*log10(1-0.01);
wp=[w1 w2]; ws=[wr1 wr2];
[n,wn] = cheb1ord(wp,ws,rp,A);
[b,a]= cheby1(n,rp,wn);
freqz(b,a);