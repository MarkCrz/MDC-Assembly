# Disciplina: Arquitetura e Organização de Computadores
# Atividade: Avaliação 01 – Programação em Linguagem de Montagem
# Programa 01
# Grupo: - Marco A. Corazza J.


	.data
	
texto1: .asciiz "\nEntre com um valor inteiro (maior do que zero): "
texto2: .asciiz "\nValor inválido"
texto3: .asciiz "\nDigite uma operação, sendo que 0: encerra o programa; 1: informa o resto da divisão por 2; e 2: informa o resultado da divisão por 2: "
texto4: .asciiz "\nOperação invalida"

texto5: .asciiz "\nPrograma Encerrado"
texto6: .asciiz "\nO resto da divisão de "
texto7: .asciiz "\nO resultado da divisão de "
texto8: .asciiz " por 2 é: "


	.text
main:

	LoopN:	
		la $a0, texto1 		#Carrega em $a0 o vetor de char
		addi $v0, $zero, 4 	#Carrega em $v0 a função de imprimir uma string
		syscall			#Imprime no console o vetor de char
	
		addi $v0, $zero, 5	#Carrega em $v0 a função de ler um inteiro do console
		syscall			#Pega o número inteiro digitado
		addi $t0, $v0, 0	#Coloca no registrador tempórario o valor lido em $v0
	
		slti $t1, $t0, 1		#Se $t0 < 1 então $t1 = 1 senão $t1 = 0
		beq $t1, $zero, LoopOperator	#Se $t1 for 0 ele entra no LoopOperator
		la $a0, texto2			#Carrega em $a0 o vetor de char
		addi $v0, $zero, 4		#Carrega em $v0 a função de imprimir uma string
		syscall				#Imprime no console o vetor de char
		j LoopN				#Volta pro inicio de LoopN

	LoopOperator:
		la $a0, texto3		#Carrega em $a0 o vetor de char
		addi $v0, $zero, 4	#Carrega em $v0 a função de imprimir uma string
		syscall			##Imprime no console o vetor de char
	
		addi $v0, $zero, 5	#Carrega em $v0 a função de ler um inteiro do console
		syscall			#Pega o número inteiro digitado
		addi $t1, $v0, 0	#Coloca no registrador tempórario o valor lido em $v0
		
		slti $t2, $t1, 0		#Se $t1 < 0 então $t2 = 1 senão $t2 = 0
		beq $t2, $zero, LoopOperator2	#Se $t2 for 0 ele entra no LoopOperator2
		la $a0, texto4			#Carrega em $a0 o vetor de char
		addi $v0, $zero, 4		#Carrega em $v0 a função de imprimir uma string
		syscall				#Imprime no console o vetor de char
		j LoopOperator			#Volta para o inicio de LoopOperator

	LoopOperator2:
		slti $t2, $t1, 3		#Se $t1 < 3 então $t2 = 1 senão $t2 = 0
		beq $t2, 1, DefineOperation	#Se $t2 == 1 pula para DefineOperation
		la $a0, texto4			#Carrega em $a0 o vetor de char
		addi $v0, $zero, 4		#Carrega em $v0 a função de imprimir uma string
		syscall				#Imprime no console o vetor de char
		j LoopOperator			#volta para o inicio de LoopOperator
	

 	DefineOperation:
 		add $s0, $zero, $t0	#Soma o valor de $t0 + 0 e coloca no $s0
 		add $s1, $zero, $t1	#Soma o valor de $t1 + 0 e coloca no $s1
 	
 		beq $s1, 0, Finish		#Se $s1 for igual a 0 então ele vai para Finish
 		beq $s1, 1, RestDivision	#Se $s1 for igual a 1 então ele vai para RestDivision
 		beq $s1, 2, Division		#Se $s1 for igual a 2 então ele vai para Division
 
 	RestDivision:
 		add $t0, $zero, $s0	#Adiciona em $t0 o valor de $s0
 		
 		LoopRD:
 			blt $t0, 2, FinishRD	#Se $t0 for menor que 2 ele vai para FinishRD senão continua na linha de baixo
 			sub $t0, $t0, 2		#$t0 = $t0 - 2
 			j LoopRD		#Pula para LoopRD
 		
 		FinishRD:
 			la $a0, texto6		#Carrega em $a0 o vetor de char
 			addi $v0, $zero, 4	#Carrega em $v0 a função de imprimir uma string
 			syscall			#Imprime no console o vetor de char
 		
 			addi $a0, $s0, 0	#Adiciona o valor de i para que se possa imprimir
			addi $v0, $zero, 1	#Adiciona em $v0 o número para ser impresso
			syscall			#Imprime no console o valor de $s0
 		
 			add $s0, $zero, $t0	#Coloca em $s0 o valor de $t0 que é o resultado da operação mod sem mod
 		
 			la $a0, texto8		#Carrega em $a0 o vetor de char
 			addi $v0, $zero, 4	#Carrega em $v0 a função de imprimir uma string
 			syscall			#Imprime no console o vetor de char
 		
 			addi $a0, $s0, 0	#Adiciona o valor para que se possa imprimir
			addi $v0, $zero, 1	#Adiciona em $v0 a função de imprimir inteiro
			syscall			#Imprime no console o valor de $s0
 			j Finish		#Vai para Finish
 
 	Division:
 		add $t0, $zero, $s0	#Adiciona em $t0 o valor de $s0
 		addi $t1, $zero, 0	#Coloca o $t1 como Null ou 0
 	
 		LoopD:  
 			blt $t0, 2, FinishD	#Se $t0 for menor que 2 ele vai para FinishD senão continua na linha de baixo
 			sub $t0, $t0, 2		#$t0 = $t0 - 2
 			add $t1, $t1, 1		#$t1 = $t1 + 1
 			j LoopD			#Pula para LoopD
 	
 		FinishD:
 			la $a0, texto7		#Carrega em $a0 o vetor de char
 			addi $v0, $zero, 4	#Carrega em $v0 a função de imprimir uma string
 			syscall			#Imprime no console o vetor de char
 		
 			addi $a0, $s0, 0	#Adiciona o valor de i para que se possa imprimir
			addi $v0, $zero, 1	#Adiciona em $v0 o número para ser impresso
			syscall			#Imprime no console o valor de $s0
			
			add $s0, $zero, $t1	#Coloca em $s0 o valor de $t1 que é o resultado da divisão dem div
		
			la $a0, texto8		#Carrega em $a0 o vetor de char
 			addi $v0, $zero, 4	#Carrega em $v0 a função de imprimir uma string
 			syscall			#Imprime no console o vetor de char
 		
 			addi $a0, $s0, 0	#Adiciona o valor para que se possa imprimir
			addi $v0, $zero, 1	#Adiciona em $v0 a função de imprimir inteiro
			syscall			#Imprime no console o valor de $s0
 			j Finish		#Vai para Finish
 	
 	Finish:
 		la $a0, texto5		#Carrega em $a0 o vetor de char
		addi $v0, $zero, 4	#Carrega em $v0 a função de imprimir uma string
		syscall			#Imprime no console o vetor de char