from scipy.signal import butter, lfilter
import matplotlib.pyplot as plt
import numpy as np

def timeArray(samples):
	time = list(range(samples))
	time = map (lambda x: x*(1.0/360.0), time)
	return time		

def freqCardiaca(Rindices):
	tempoEntreRs = []
	for i in range (0, len(Rindices) - 1):
		tempoEntreRs.append(Rindices[i] - Rindices[i+1])
	tempoEntreRs = map (lambda x: abs(x*(1.0/360.0)), tempoEntreRs)

	medianaTempo = np.median(np.array(tempoEntreRs))

	print medianaTempo
	print max(tempoEntreRs)
	print min(tempoEntreRs)
	
def findR(signal):
	zeros = 0
	picoR = []
	picoRIndice = []
	maximoValor = 0.0
	for i in range (0, len(signal)-1):

		if (signal[i] > maximoValor): 
			maximoValor = signal[i]
			maximoIndice = i
		if (abs(signal[i]) < 10):
			zeros += 1
			if (zeros >= 10 and maximoValor > 45):
				zeros = 0
				picoR.append(maximoValor);
				picoRIndice.append(maximoIndice);
				maximoValor = 0.1

	return picoR, picoRIndice


def butter_bandpass(lowcut, highcut, fs, order=5):
    nyq = 0.5 * fs
    low = lowcut / nyq
    high = highcut / nyq
    b, a = butter(order, [low, high], btype='band')
    return b, a


def butter_bandpass_filter(data, lowcut, highcut, fs, order=5):
    b, a = butter_bandpass(lowcut, highcut, fs, order=order)
    y = lfilter(b, a, data)
    return y


def main():
	"""
	Programa detector de complexos QRS

	O programa filtra por meio de um passa-faixa de frequencia de corte inferior igual 10Hz e superior
	igual a 28Hz e plota os sinais originais e filtrados. Os ultimos com marcacoes do pico R.
	"""
	
	file = open('100.dat', 'r')
	linha = 0

	signalOne = []
	signalTwo = []


	for line in file:
		linha += 1
		if (linha % 2 == 0) :
			signalOne.append(int(line))
	
		else :
			signalTwo.append(int(line))


	# Sample rate and desired cutoff frequencies (in Hz).
	fs = 360.0
	lowcut = 10.0
	highcut = 28.0

	#Filter
	y1 = butter_bandpass_filter(signalOne, lowcut, highcut, fs, order=4)
	y2 = butter_bandpass_filter(signalTwo, lowcut, highcut, fs, order=4)


	y1deslocado = []
	y2deslocado = []

	for i in range (0, (len(y1) - 201)) :
		y1deslocado.append(y1[i + 200])
		y2deslocado.append(y2[i + 200])

	ry1, ry1Indices = findR(y1deslocado)
	ry2, ry2Indices = findR(y2deslocado)

	freqCardiaca(ry1Indices)
	freqCardiaca(ry2Indices)

	timeOriginal = timeArray(len(signalOne))
	timeFiltered = timeArray(len(y1deslocado))

	plt.figure(1)
	plt.grid(True)
	plt.subplot(211)
	plt.title('Signal 1 - Original')
	plt.xlabel('Tempo (s)')
	plt.ylabel('Amplitude do sinal')
	plt.axis([0, max(timeOriginal), min(signalOne) - 30, max(signalOne) + 30])
	plt.plot(timeOriginal, signalOne)
	plt.subplot(212)
	plt.title('Signal 2 - Original')
	plt.xlabel('Tempo (s)')
	plt.ylabel('Amplitude do sinal')
	plt.axis([0, max(timeOriginal), min(signalTwo) - 30, max(signalTwo) + 30])
	plt.plot(timeOriginal, signalTwo)

	plt.figure(2)
	plt.grid(True)
	plt.subplot(211)
	plt.title('Signal 1 - Filtered')
	plt.xlabel('Tempo (s)')
	plt.ylabel('Amplitude do sinal')
	plt.axis([0, max(timeFiltered), min(y1deslocado) - 30, max(y1deslocado) + 30])
	plt.plot(timeFiltered, y1deslocado)
	plt.subplot(212)
	plt.title('Signal 2 - Filtered')
	plt.xlabel('Tempo (s)')
	plt.ylabel('Amplitude do sinal')
	plt.axis([0, max(timeFiltered), min(y2deslocado) - 30, max(y2deslocado) + 30])
	plt.plot(timeFiltered, y2deslocado)


	plt.figure(3)
	plt.grid(True)	
	plt.subplot(211)
	plt.title('Signal 1 - Filtered')
	plt.xlabel('Amostra')
	plt.ylabel('Amplitude do sinal')
	plt.plot(ry1Indices, ry1, 'ro', y1deslocado)

	plt.subplot(212)
	plt.title('Signal 2 - Filtered')
	plt.xlabel('Amostra')
	plt.ylabel('Amplitude do sinal')
	plt.plot(ry2Indices, ry2, 'ro',y2deslocado)
	plt.show()

main()