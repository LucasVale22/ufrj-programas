# -*- coding: utf-8 -*-
"""
Created on Mon Feb 23 14:19:05 2015

@author: Guilherme
"""

"""
@author: Victor Martins Diniz
"""
from numpy import cos, sin, pi, absolute, arange, array, append, abs, angle,\
                  fft, linspace, zeros, log10, unwrap
from scipy.signal  import kaiserord, lfilter, firwin, freqz
from pylab import figure, clf, plot, xlabel, ylabel, xlim, ylim, title, grid, \
                  axes, show, subplot, axis, plot

def load(nome):
  arq = open(nome, 'r')  # We need to re-open the file
  # data = f.read()   # leitura de todo o arquivo em uma única var. string
  x = array([])
  for linha in arq:     # leitura linha a linha de todo o arquivo
      x = append(x,float(linha))
  arq.close()
  return x

x  = load('ecgdata_noise.txt')

fs = 550   # frequencia de amostragem do sinal ECG (Hz)
Ts = 1./fs
n = arange(0,x.size*Ts,Ts)
subplot(3,1,1),

plot(n,x); xlabel('tempo'); ylabel('amplitude')

X = fft.fft(x)
f = linspace(0,fs,465)
subplot(3,1,2),plot(f,abs(X)); xlabel('freq. (Hz)');ylabel('amplitude');
subplot(3,1,3),plot(f,angle(X)); xlabel('fase')

#---- Filtro---#

def firfs(C,Hk):
# FIR filter design using the frequency sampling method.
# C: the number of filter coefficients (C must be odd).
# Hk: sampled frequency response, for k = 0,1,2,...,M=(C-1)/2.
# Output:
# vetor B: linear phase FIR filter coefficients.
  M = (C - 1)/2 # half of coefficients
  B = zeros(C)*1j
  for n in arange(0,C):
     B[n] = (1/float(C))*(Hk[0]+2*sum(Hk[1:M+1]*cos(2*pi*arange(0,M)*(n-M)/C)))
  return B
  
fs = 550
# frequencia de amostragem (Hz)
H1 = array([0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])  # amplitude amostras
# valores das amostras da RF desejada
B1 = firfs(80,H1)
# projeta o filtro c/ ‘freq. sampling’
w, h1 = freqz(B1,1,512,fs)
# magnitude da resp. em frequencia
f1 = 180.*unwrap(angle(h1))/pi
H2 = array([0,0,0,0,1/2,1,1,1,1,1/2,0,0,0])
# valores da RF desejada mais suaves
B2 = firfs(25,H2)
# projeta o filtro c/ ‘freq. sampling’
w, h2 = freqz(B2,1,512,fs)
# magnitude da resp. em frequencia
f2 = 180.*unwrap(angle(h2))/pi
# unwrap(): desempacota fase
f = w/pi*fs/2. # freq. linear em Hz
subplot(2,1,1); plot(f,20.*log10(abs(h1)),'-.',f,20.*log10(abs(h2))); grid('on')
axis(array([0., fs/2., -100., 10.]))
xlabel(u'Frequência (Hz)'); ylabel('Magnitude (dB)')
subplot(2,1,2); plot(f,f1,'-.',f,f2); grid('on')
axis(array([0., fs/2., -1100., 300.]))
xlabel(u'Frequência (Hz)'); ylabel('Fase (graus)')

y = lfilter(B1,1,x)
figure()
plot(y)

z=fft.fft(y)

figure()

plot(z)
