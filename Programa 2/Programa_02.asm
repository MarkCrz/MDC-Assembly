# Disciplina: Arquitetura e Organização de Computadores
# Atividade: Avaliação 01 – Programação em Linguagem de Montagem
# Programa 02
# Grupo: - Marco A. Corazza J.


	.data		#segmento de dados

Vector_A: .word 0, 0, 0, 0, 0, 0, 0, 0 		#Definição do Vector A. Coloca os valores em 0

texto1: .asciiz "\nDigite o tamanho do vetor (máx = 8): "
texto2: .asciiz "\nTamanho inválido"
texto3: .asciiz "\nEntre com o valor de: A["
texto4: .asciiz "\nVector_A["
texto5: .asciiz "]: "
texto6: .asciiz "\nValor inválido"

	.text		#Segmento de código

main:
	addi $t0, $zero, 0	#$t0 = 0 (i = 0)
	la $s1, Vector_A	#Inicializa o Vector_A

	LoopTV:
		la $a0, texto1		#Coloca em $a0 o texto1
		addi $v0, $zero, 4	#Carrega em $v0 a função de imprimir uma string
		syscall			#Imprime no console a string
	
		addi $v0, $zero, 5	#Carrega em $v0 a função de ler um int
		syscall			#Pega o número digitado no console
		addi $s0, $v0, 0	#Coloca o número lido em $s0
		
		bge $s0, 1, Verify2	#Se $s0 for maior ou igual a 1 vai para Verify2, senão continua
		la $a0, texto2		#Coloca em $a0 o texto2
		addi $v0, $zero, 4	#Carrega em $v0 a função de imprimir uma string
		syscall			#Imprime no console a string
		j LoopTV		#Pula para LoopTV
		
       		Verify2: 
       			ble $s0, 8, PreencheVector	#Se $s0 for menor ou igual a 8 vai para para PreencheVector, senão continua
       			la $a0, texto2			#Coloca em $a0 o texto2
			addi $v0, $zero, 4		#Carrega em $v0 a função de imprimir uma string
			syscall				#Imprime no console a string
			j LoopTV			#Pula para LoopTV
		
	PreencheVector:
		la $a0, texto3		#Coloca em $a0 o texto3
		addi $v0, $zero, 4	#Carrega em $v0 a função de imprimir uma string
		syscall			#Imprime no console a string
		
		addi $a0, $t0, 0	#Adiciona o valor de i para que se possa imprimir
		addi $v0, $zero, 1	#Adiciona em $v0 a função de imprimir inteiro
		syscall			#Imprime no console o valor de $t0
		
		la $a0, texto5		#Coloca em $a0 o texto5
		addi $v0, $zero, 4	#Carrega em $v0 a função de imprimir uma string
		syscall			#Imprime no console a string
		
		addi $v0, $zero, 5	#Carrega em $v0 a função de ler um int
		syscall			#Pega o número digitado no console
		addi $t3, $v0, 0	#Coloca o número lido em $t3
		
		bge $t3, 1, VerifyNum2	#Se $s0 for maior ou igual a 1 vai para VerifyNum2, senão continua
		la $a0, texto6		#Coloca em $a0 o texto6
		addi $v0, $zero, 4	#Carrega em $v0 a função de imprimir uma string
		syscall			#Imprime no console a string
		j PreencheVector	#Pula para PrencheVector
		
    		VerifyNum2:
    			ble $t3, 8, ContinuePV	#Se $s0 for menor ou igual a 8 vai para para ContinuePV , senão continua
    			la $a0, texto6		#Coloca em $a0 o texto6
			addi $v0, $zero, 4	#Carrega em $v0 a função de imprimir uma string
			syscall			#Imprime no console a string
			j PreencheVector	#Pula para PrencheVecto
		
		ContinuePV:
			add $t1, $t0, $t0	#$t1 = 2 * $t0
			add $t1, $t1, $t1	#$t1 = 4 * $t1
			add $t1, $t1, $s1	#$t1 = end.base + 4.i (deslocamento) = end. de salvar[i]
			lw $t2, 0($t1)		#$t2 = Vector_A[i]
		
			add $t2, $t3, $zero	#Adiciona o valor digitado em $t2
			sw $t2, 0($t1)		#Salva o valor no Vector_A[i]
			addi $t0, $t0, 1	#$t0++
		
			bne $t0, $s0, PreencheVector	#Enquanto $t0 (i) for diferente de $s0 (tamanho) vai para PreencheVector
		
			la $s1, Vector_A	#Inicializa o Vector_A
			addi $t0, $zero, 0	#$t0 = 0 (i = 0)
			add $t4, $zero, $s0	#$t4 = $s0 (j = tamanho do Vector_A)
			subi $t4, $t4, 1	#Arruma o indice de j
		
			j Division		#Pula para Division
		
	Division:
		addi $t9, $zero, 0
		add $t8, $zero, $s0
		
		LoopD:  
			blt $t8, 2, FinishD	#Se $t8 for menor que 2 ele vai para FinishD senão continua na linha de baixo
 			sub $t8, $t8, 2		#$t8 = $t8 - 2
 			add $t9, $t9, 1		#$t9 = $t9 + 1
 			j LoopD			#Pula para LoopD
 		
 		FinishD:
 			add $s2, $zero, $t9	#Adiciona o resultado em $s2
 			addi $t9, $zero, 0	#Zera o $t9
 			addi $t8, $zero, 0	#Zera o $t8
 			j TrocaValores		#Pula para TrocaValores

	TrocaValores:
		beq $s0, 1, ImprimeVector	#Se o tamanho do Vector_A for 1 então ele vai direto para impressão
		add $t1, $t0, $t0		#$t1 = 2 * $t0
		add $t1, $t1, $t1		#$t1 = 4 * $t1
		add $t1, $t1, $s1		#$t1 = end.base + 4.i (deslocamento) = end. de salvar[i]
		lw $t2, 0($t1)			#$t2 = Vector_A[i]
		
		add $t5, $t4, $t4	#$t5 = 2 * $t4
		add $t5, $t5, $t5	#$t5 = 4 * $t5
		add $t5, $t5, $s1	#$t5 = end.base + 4.j (deslocamento) = end. de salvar[j]
		lw $t6, 0($t5)		#$t6 = Vector_A[j]
		
		add $t7, $t6, $zero	#Adiciona em $t7 o valor do Vector_A[j]
		
		add $t6, $t2, $zero	#Adiciona o valor do Vector_A[i] em $t6
		add $t2, $t7, $zero	#Adiciona o valor do Vector_A[j] em $t2
		sw $t6, 0($t5)		#Salva o valor no Vector_A[j]
		sw $t2, 0($t1)		#Salva o valor no Vector_A[i]
		addi $t0, $t0, 1	#$t0++
		subi $t4, $t4, 1	#$t4--
		
		bne $t0, $s2, TrocaValores
		
		la $s1, Vector_A	#Inicializa o Vector_A
		addi $t0, $zero, 0	#$t0 = 0 (i = 0)
		

	ImprimeVector:
		la $a0, texto4		#Coloca em $a0 o texto4
		addi $v0, $zero, 4	#Carrega em $v0 a função de imprimir uma string
		syscall			#Imprime no console a string
		
		addi $a0, $t0, 0	#Adiciona o valor de i para que se possa imprimir
		addi $v0, $zero, 1	#Adiciona em $v0 a função de imprimir inteiro
		syscall			#Imprime no console o valor de $t0
		
		la $a0, texto5		#Coloca em $a0 o texto5
		addi $v0, $zero, 4	#Carrega em $v0 a função de imprimir uma string
		syscall	
		
		add $t1, $t0, $t0	#$t1 = 2 * $t0
		add $t1, $t1, $t1	#$t1 = 4 * $t1
		add $t1, $t1, $s1	#$t1 = end.base + 4.i (deslocamento) = end. de salvar[i]
		lw $t2, 0($t1)		#$t2 = Vector_A[i]
		
		addi $a0, $t2, 0	#Adiciona o valor para que se possa imprimir
		addi $v0, $zero, 1	#Adiciona em $v0 a função de imprimir inteiro
		syscall			#Imprime no console o valor de $t0
		addi $t0, $t0, 1	#$t0++
		
		bne $t0, $s0, ImprimeVector	#Enquanto $t0 (i) for diferente de $s0 (tamanho) vai para ImprimeVector
		
		
		 
	
	
