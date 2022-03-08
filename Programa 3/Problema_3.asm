# Disciplina: Arquitetura e Organização de Computadores
# Atividade: Avaliação 03 – Programação de Procedimentos
# Problema 1
# Grupo: - Marco A. Corazza J.

	.data		#segmento de dados
		texto1: .asciiz "\nDigite um valor: "
		texto2: .asciiz "\nValor do MDC: "

	
	.text 
	
	j Main
	
	Main:	
		jal LerValor			#Vai para a função de ler um inteiro
		add $s0, $v0, $zero		#Adiciona o valor retornado na função em $s0
		jal LerValor			#Vai para a função de ler um inteiro
		add $s1, $v0, $zero		#Adiciona o valor retornado na função em $s0
		jal MDC				#Entra na função MDC
		add $s3, $v0, $zero		#Adiciona o valor de $v0 em $s3
		jal ImprimirValorMDC		#Vai para a função de imprimir um inteiro
		j Exit				#Finaliza o programa
		
	
	MDC:
		addi $sp, $sp, -8	#Decrementa $sp em 2
		sw $s0, 4($sp)		#Adiciona na pilha o valor de $s0
		sw $s1, 0($sp)		#Adiciona na pilha o valor de $s1
		
		While:
			beq $s0, $s1, ContinuaMDC	#Se x == y vai para ContinuaMDC
			blt $s0, $s1, MDCY		#Se x < y vai para MDCY
			sub $s0, $s0, $s1		#Se x > y, então x = x - y
			j While				#While enquanto x != y
		
		MDCY:
			sub $s1, $s1, $s0		#y = y - x
			j While				#While enquanto x != y
			
		ContinuaMDC:
			add $v0, $s0, $zero		#Return x
			
			lw $s1, 0($sp)		#Restaura o valor colocado na pilha
			lw $s0, 4($sp)		#Restaura o valor colocado na pilha
			addi $sp, $sp, 8 	#Incrementa $sp em 2
			
			jr $ra			#Retorna na linha de baixa da chamada
	
	LerValor:
		la $a0, texto1		#Coloca em $a0 o texto1
		addi $v0, $zero, 4	#Carrega em $v0 a função de imprimir uma string
		syscall			#Imprime no console a string
		
		addi $v0, $zero, 5	#Carrega em $v0 a função de ler um int
		addi $v0, $v0, 0	#Adiciona o valor lido em $v0
		syscall			#Pega o número digitado no console
		
		jr $ra			#retorna o valor de $v0
		
	ImprimirValorMDC:
		la $a0, texto2		#Coloca em $a0 o texto2
		addi $v0, $zero, 4	#Carrega em $v0 a função de imprimir uma string
		syscall			#Imprime no console a string
		
		li $v0, 1		#Carrega em $v0 a função de imprimir um int
		add $a0, $s3, $zero	#Coloca o valor de $t9 em $a0 para imprimir no console
		syscall			#Imprime no console
		
		jr $ra			#Retorna para a função Main

	Exit:		#Finaliza o programa
		