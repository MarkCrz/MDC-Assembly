# Disciplina: Arquitetura e Organização de Computadores
# Atividade: Avaliação 03 – Programação de Procedimentos
# Problema 2
# Grupo: - Marco A. Corazza J.

	.data		#segmento de dados
		texto1: .asciiz "\nDigite um valor: "
		texto2: .asciiz "\nValor do MDC Recursivo: "
	
	.text 
	
	j Main
	
	Main:	
		jal LerValor			#Vai para a função de ler um inteiro
		add $s0, $v0, $zero		#Adiciona o valor retornado na função em $s0
		jal LerValor			#Vai para a função de ler um inteiro
		add $s1, $v0, $zero		#Adiciona o valor retornado na função em $s0
		jal MDCRecursivo		#Entra na função MDCRecursivo
		add $s3, $v0, $zero		#Adiciona o valor de $v0 em $s3
		jal ImprimirValorMDCRecursivo	#Vai para a função de imprimir um inteiro
		j Exit				#Finaliza o programa
			
	MDCRecursivo:
		addi $sp, $sp, -12			#Decrementa $sp em 3
		sw $s0, 8($sp)				#Adiciona na pilha o valor de $s0
		sw $s1, 4($sp)				#Adiciona na pilha o valor de $s1
		sw $ra, 0($sp)				#Adiciona na pilha o valor de $ra
		
		beq $s0, $s1, ContinuaMDCRecursivo	#Se x == y vai para ContinuaMDCRecursivo
		blt $s0, $s1, MDCYRecursivo		#Se x < y vai para MDCYRecursivo
		
		sub $s0, $s0, $s1 			#Se x > y, então x = x - y
		jal MDCRecursivo			#Entra na função novamente
		
		lw $ra, 0($sp)				#Restaura o valor colocado na pilha
		lw $s1, 4($sp)				#Restaura o valor colocado na pilha
		lw $s0, 8($sp)				#Restaura o valor colocado na pilha
		addi $sp, $sp, 12			#Incrementa $sp em 3
			
		jr $ra
		
		MDCYRecursivo:
			sub $s1, $s1, $s0		#y = y - x
			
			jal MDCRecursivo		#Entra na função novamente
			
			lw $ra, 0($sp)			#Restaura o valor colocado na pilha
			lw $s1, 4($sp)			#Restaura o valor colocado na pilha
			lw $s0, 8($sp)			#Restaura o valor colocado na pilha
			addi $sp, $sp, 12		#Incrementa $sp em 3
			
			jr $ra
		
		ContinuaMDCRecursivo:
			add $v0, $s0, $zero		#Return x
			
			lw $ra, 0($sp)			#Restaura o valor colocado na pilha
			lw $s1, 4($sp)			#Restaura o valor colocado na pilha
			lw $s0, 8($sp)			#Restaura o valor colocado na pilha
			addi $sp, $sp, 12		#Incrementa $sp em 3
			
			jr $ra
	
	LerValor:
		la $a0, texto1		#Coloca em $a0 o texto1
		addi $v0, $zero, 4	#Carrega em $v0 a função de imprimir uma string
		syscall			#Imprime no console a string
		
		addi $v0, $zero, 5	#Carrega em $v0 a função de ler um int
		addi $v0, $v0, 0	#Adiciona o valor lido em $v0
		syscall			#Pega o número digitado no console
		
		jr $ra			#retorna o valor de $v0
		
	ImprimirValorMDCRecursivo:
		la $a0, texto2		#Coloca em $a0 o texto2
		addi $v0, $zero, 4	#Carrega em $v0 a função de imprimir uma string
		syscall			#Imprime no console a string
		
		li $v0, 1		#Carrega em $v0 a função de imprimir um int
		add $a0, $s3, $zero	#Coloca o valor de $t9 em $a0 para imprimir no console
		syscall			#Imprime no console
		
		jr $ra			#Retorna para a função Main
		
	Exit:		#Finaliza o programa