#
#   Hello World server in Python
#   Binds REP socket to tcp://*:5555
#   Expects b"Hello" from client, replies with b"World"
#
import zmq
import time

context = zmq.Context()
socket = context.socket(zmq.REP)
socket.bind("tcp://*:5555")

contas = ["1","2","3","4","5"]
senhas = ["2","4","6","8","10"]
saldo = [10,20,30,40,50]

while True:
	contaOk = False
	senhaOk = False
    #  checagem de Conta
	while contaOk == False :
		message = socket.recv()
		for x in range(0,4):
			if message == contas[x]:
				nConta = x
				contaOk = True
				socket.send(b"OK")
			elif message == "sair":
				senhaOk = False
				contaOk = False
				booleanOperacao = False
				socket.send("OK")
			#else:
			#	socket.send(b"Conta nao Cadastrada")
	#checagem de senhas
	while senhaOk == False:
		message = socket.recv()
		if message == senhas[nConta]:
			senhaOk = True
			socket.send("OK")
		elif message == "sair":
			senhaOk = False
			contaOk = False
			booleanOperacao = False
			#socket.send(b"OK")
		#else: temos q tratar qwuando a conta e senha NAO EXISTEM
		#	socket.send(b"Senha Incorreta")
	
	booleanOperacao = True				
	
	#realizacao de operacoes
	while booleanOperacao == True:
		operacao = socket.recv()
		time.sleep(1)
		if operacao == "sair" :
			senhaOk = False
			contaOk = False
			booleanOperacao = False
		elif operacao == "1": # sacar
			print("SACAR Valor")
			valor = socket.recv()
			if int(valor) > saldo[nConta]:
				socket.send(b"Saldo Insuficiente")
			else:
				saldo[nConta] -= int(valor)
				socket.send( str(saldo[nConta]) )
			#socket.send(b"OK")	
		elif operacao == "2": #depositar
			print("Depositar valor")
			valor = socket.recv()
			print("valor recebido %s",valor)
			saldo[nConta] += int(valor)
			print("novo saldo %i",saldo[nConta] )
			socket.send(b"%s", str(saldo[nConta]))
			#socket.send(b"OK")	
