extends Node2D

var teste = false
var valor = 0

# Declarei aqui a variavel do erro 4
var nome = ""

# 1 - Tinha caractere inexistente no ASCII "ú"
# var número = 0
var numero = 0

# 2 - Variavel não havia sido declarada ainda
#lista = []
var lista = []

func _on_Button_pressed():
	# Coletando dados inseridos pelo usuário
	# 3 - Referenciava variavel ainda não declarada, que agora é numero
	# número = int(LineEdit.text)
	nome = String($LineEdit.text)
	# 4 - Referenciava variavel não declarada, criei a variavel
	# $LineEdit.text = nome
	$LineEdit.text = ''


func _on_Button2_pressed():
	#Incrementando o número inserido pelo usuário
	# for i in range(10):
		#Numero+=i
	# 5 - Chamava variavel não declarada (Numero), corrigi para numero
	numero += int($LineEdit.text)
	
	# 6 - Chamava variavel não declarada (Numero), corrigi para numero
		#lista.append(Numero)
	lista.append(numero)
	# 7 - Estava passando valor do tipo Int
	$Label.text = String(numero)
	
	# 8 - Limpa input
	$LineEdit.text = ''


func _on_Button3_pressed():
	#Mudando o nome do usuário de acordo com os dados da lista
	#Se houver algum número ímpar o nome deve adicionar "baldo" ao final
	# 9 - Chama variavel não declarada
	var i = 0
	var hasOdd = false
	print(lista)
	#while(len(lista)):
	while(len(lista) > i):
		#cont=0
		print(lista[i] % 2)
		# Checava se o numero era impar, mas fazia função
		if(lista[i] % 2 == 0):
			i += 1
		# Was only checking if i is different of 0
		else:
			hasOdd = true
		i+=1
		
	$Label2.text = nome + 'baldo'
