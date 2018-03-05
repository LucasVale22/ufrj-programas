#
#   Hello World client in Python
#   Connects REQ socket to tcp://localhost:5555
#   Sends "Hello" to server, expects "World" back
#

import zmq
import time

context = zmq.Context()

#  Socket to talk to server
print("Connecting to Server")
socket = context.socket(zmq.REQ)
socket.connect("tcp://localhost:5555")

contaOk = False
senhaOk = False

#  Do 10 requests, waiting each time for a response
while contaOk == False:
	conta = str( raw_input("Digite sua Conta:") ) # ver outra forma de ler dados
	socket.send(conta)                             # transformar em 
	message = socket.recv()
	if message == "OK" :
		contaOk = True
	else:
		contaOk = False

while senhaOk == False:
	senha = str( raw_input("Digite sua Senha:") )
	socket.send(senha)
	message = socket.recv()
	if message == "OK" :
		senhaOk = True
		print("Logado Com Sucesso")
	else:
		senhaOk = False

booleanOperacao = True

while booleanOperacao == True:
	operacao = str( raw_input("Selecione 1 pra sacar e 2 pra depositar:") )
	socket.send(operacao)
	time.sleep(1)
	if operacao == "sair" :
		#socket.send(operacao)
		senhaOk = False
		contaOk = False
		booleanOperacao = False
	elif operacao == "1": # sacar
		valor = str(raw_input("Digite o Valor q sera sacado:") )
		#socket.send(operacao)
		time.sleep(1)
		socket.send(valor)
		message = socket.recv()
		if	message == "Saldo Insuficiente" :
			print("Saldo insuficiente")
		else: # tratar quando servidor nao retorna ok
			print("Saque realizado com sucesso")
			saldo = socket.recv()
			print("Novo saldo em conta %s", saldo)
				
	elif operacao == "2": #depositar
		#socket.send(operacao)
		valor = str( raw_input("Digite o Valor q sera depositado:") )
		time.sleep(1)
		socket.send(valor)
		saldo = socket.recv()
		print("Novo saldo em conta %s", saldo)
