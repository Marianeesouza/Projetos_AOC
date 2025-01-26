
# Projeto 1 VA Arquitetura e Organiza��o de Computadores - 2024.2
# Alunos: Heitor Leander Feitosa da silva
#         Jo�o victor Morais Barreto da silva
#         Mariane Elisa dos Santos Souza
#         Samuel Roberto de Carvalho Bezerra

.data
	source:    .asciiz "Hello, MIPS!"    # String de origem
	source2:	.asciiz "Ol�, MIPS!" 
	destination: .space 100              # Espa�o reservado para a string destino

.text
	main:
		# Configura��o inicial
    	la $a0, destination   # Endere�o do destino (deve apontar para uma �rea v�lida de mem�ria)
    	la $a1, source        # Endere�o da origem (deve apontar para a string "Hello, MIPS!")
    	jal strcpy            # Chama a fun��o strcpy
		
    	# Exibe a string copiada
    	li $v0, 4             # Chamada de sistema para imprimir string
    	syscall
    		
    	# verifica igualdade
    	jal strcmp
		
		# Teste de memcpy
		li $a2, 3
    	la $a1, source2
    	jal memcpy
    	li $v0, 4           
    	syscall
    		
    	# verifica igualdade
    	jal strcmp

    	# Finaliza o programa
    	li $v0, 10          # Chamada de sistema para encerrar o programa
    	syscall

	strcpy: # Copia uma string do source (a1) para o destination (a0)
		# Salvar os valores originais de $a0 e $a1 na pilha
		sub $sp, $sp, 8          # Cria espa�o para dois valores de 4 bytes
    	sw $a0, 0($sp)           # Salva $a0 na pilha
		sw $a1, 4($sp)           # Salva $a1 na pilha

    	# In�cio da c�pia
		copia_strcpy:
			lb $t0, 0($a1) # Carrega o caractere atual para o t0
			sb $t0, 0($a0) # Guarda o caractere atual do t0 para o a0
			beq $t0, $zero, fim_copia_strcpy # Se o caractere for nulo, ent�o a string terminou
			
			# Passa para o proximo byte da string
			addi $a1, $a1, 1 
			addi $a0, $a0, 1
			j copia_strcpy
			
		fim_copia_strcpy:
			# adicionando uma quebra de linha ao fim da string
			li $t0, 10            # Caractere '\n' em ASCII � 10
       		sb $t0, 0($a0)        # Adiciona '\n' ao final da string copiada
       				
       		# Colocando o caractere nulo no lugar
        	addi $a0, $a0, 1      # Incrementa o destino para o pr�ximo byte
        	sb $zero, 0($a0)      # Adiciona o caractere NULL (\0) ap�s a quebra de linha
        			
        	move $v0, $a0         # Retorna o endere�o do destino atualizado
        	# Restaurar os valores originais de $a0 e $a1
        	lw $a0, 0($sp)        # Restaura $a0 da pilha
        	lw $a1, 4($sp)        # Restaura $a1 da pilha
        	addi $sp, $sp, 8      # Desaloca o espa�o usado na pilha
             		
			# Retorna da fun��o
			jr $ra
        
	memcpy: # Copia uma quantidade num (a2) de caracteres de uma string do source (a1) para o destination (a0) 
        
        # Salvar os valores originais de $a0 e $a1 na pilha
		sub $sp, $sp, 8          # Cria espa�o para dois valores de 4 bytes
    	sw $a0, 0($sp)           # Salva $a0 na pilha
		sw $a1, 4($sp)           # Salva $a1 na pilha
		
		copia_memcpy:
        	beqz $a2, fim_copia_memcpy # Se o contador chegar a 0, finaliza
        	lb $t0, 0($a1) # Carrega o caractere atual para o t0
			sb $t0, 0($a0) # Guarda o caractere atual do t0 para o a0
			
			# Passa para o proximo byte da string
			addi $a1, $a1, 1 
			addi $a0, $a0, 1
			
			addi $a2, $a2, -1 # subtrai em 1 o contador
			j copia_memcpy
			
		fim_copia_memcpy:
			# adicionando uma quebra de linha ao fim da string
			li $t0, 10            # Caractere '\n' em ASCII � 10
       		sb $t0, 0($a0)        # Adiciona '\n' ao final da string copiada
       				
       		# Colocando o caractere nulo no lugar
        	addi $a0, $a0, 1      # Incrementa o destino para o pr�ximo byte
        	sb $zero, 0($a0)      # Adiciona o caractere NULL (\0) ap�s a quebra de linha
        			
        	move $v0, $a0         # Retorna o endere�o do destino atualizado
			# Restaurar os valores originais de $a0 e $a1
        	lw $a0, 0($sp)        # Restaura $a0 da pilha
        	lw $a1, 4($sp)        # Restaura $a1 da pilha
        	addi $sp, $sp, 8      # Desaloca o espa�o usado na pilha
             		
			# Retorna da fun��o
			jr $ra
	
	strcmp: 
    	li $v0, 0             # Inicializa o valor de v0 como 0 (presumimos strings iguais inicialmente)

    	# Salvar os valores originais de $a0 e $a1 na pilha
    	sub $sp, $sp, 8        # Cria espa�o para dois valores de 4 bytes
    	sw $a0, 0($sp)         # Salva $a0 na pilha
    	sw $a1, 4($sp)         # Salva $a1 na pilha

    		verifica_strcmp:
        		lb $t1, 0($a1)     # Carrega o caractere atual de a1 (str2)
        		lb $t0, 0($a0)     # Carrega o caractere atual de a0 (str1)
        		beq $t0, $t1, verifica_zero_strcmp  # Se os caracteres forem iguais, vai verificar se acabou

        		# Se n�o forem iguais, calcula a diferen�a
        		sub $v0, $t0, $t1  # Calcula a diferen�a t0 - t1
        		j fim_strcmp

    		verifica_zero_strcmp:
        		beq $t0, $zero, fim_strcmp  # Se o caractere for nulo, as strings acabaram

        		# Passa para o pr�ximo caractere
        		addi $a1, $a1, 1
        		addi $a0, $a0, 1
        		j verifica_strcmp

    		fim_strcmp:
        		# Se as strings forem iguais, imprime 0
        		move $a0, $v0        # Move o valor de v0 para $a0
        		li $v0, 1            # Syscall para imprimir inteiro
        		syscall

        		# Restaura os valores originais de $a0 e $a1
        		lw $a0, 0($sp)       # Restaura $a0 da pilha
        		lw $a1, 4($sp)       # Restaura $a1 da pilha
        		addi $sp, $sp, 8     # Desaloca o espa�o usado na pilha
        		jr $ra               # Retorna da fun��o

	strncmp: # strcmp com contagem de caracteres
        # Salvar os valores originais de $a0 e $a1 na pilha
		sub $sp, $sp, 8          # Cria espa�o para dois valores de 4 bytes
    	sw $a0, 0($sp)           # Salva $a0 na pilha
		sw $a1, 4($sp)           # Salva $a1 na pilha
		
		verifica_strncmp:
			beqz $a2, fim_strcmp # Se o contador chegar a 0, finaliza
			lb $t1, 0($a1)     # Carrega o caractere atual de a1 (str2)
        		lb $t0, 0($a0)     # Carrega o caractere atual de a0 (str1)
        		beq $t0, $t1, verifica_zero_strncmp  # Se os caracteres forem iguais, vai verificar se acabou
        		j fim_strcmp

    	verifica_zero_strncmp:
        	beq $t0, $zero, fim_strcmp  # Se o caractere for nulo, as strings acabaram
        	subi $a2, $a2, 1

        	# Passa para o pr�ximo caractere
        	addi $a1, $a1, 1
        	addi $a0, $a0, 1
        	j verifica_strcmp

    	fim_strncmp:
    		sub $v0, $t0, $t1  # Calcula a diferen�a t0 - t1
        	# Se as strings forem iguais, imprime 0
        	move $a0, $v0        # Move o valor de v0 para $a0
        	li $v0, 1            # Syscall para imprimir inteiro
        	syscall

        	# Restaura os valores originais de $a0 e $a1
        	lw $a0, 0($sp)       # Restaura $a0 da pilha
        	lw $a1, 4($sp)       # Restaura $a1 da pilha
        	addi $sp, $sp, 8     # Desaloca o espa�o usado na pilha
        	jr $ra               # Retorna da fun��o

	strcat:
        # Salvar os valores originais de $a0 e $a1 na pilha
		sub $sp, $sp, 8          # Cria espa�o para dois valores de 4 bytes
    	sw $a0, 0($sp)           # Salva $a0 na pilha
		sw $a1, 4($sp)           # Salva $a1 na pilha
		
		acha_final_strcat:
			lb $t0, 0($a0)        # Carrega o primeiro caractere de destination
			beq $t0, $zero, copia_final_strcat  # Se for NULL (\0), encontrou o final
        	addi $a0, $a0, 1       # Move para o pr�ximo caractere em destination
        	j acha_final_strcat
        	
        copia_final_strcat:
        	lb $t1, 0($a1)         # Carrega o caractere de source
        	beq $t1, $zero, fim_strcat  # Se for NULL (\0), fim da string source
        	sb $t1, 0($a0)         # Coloca o caractere de source em destination
        	addi $a0, $a0, 1       # Move para o pr�ximo caractere em destination
        	addi $a1, $a1, 1       # Move para o pr�ximo caractere em source
        	j copia_final_strcat
        
        fim_strcat:
        	# Adicionar o caractere NULL (\0) no final da string concatenada
        	sb $zero, 0($a0)       # Coloca \0 no final de destination

    		# Retorna o endere�o de destination
    		move $v0, $a0            # Retorna o endere�o de destination
    		# Restaura os valores originais de $a0 e $a1
        	lw $a0, 0($sp)       # Restaura $a0 da pilha
        	lw $a1, 4($sp)       # Restaura $a1 da pilha
        	addi $sp, $sp, 8     # Desaloca o espa�o usado na pilha
        	jr $ra               # Retorna da fun��o


strncmp:
	la $t0, ($a0)
	la $t1, ($a1)
	move $t5, $a3
	j strncmp_loop

	
strncmp_loop:
	lb $t2, ($t0)
	lb $t3, ($t1)
	addi $t0, $t0, 1
	addi $t1, $t1, 1
	subi $t5, $t5 1
	sub $t4, $t2, $t3 # t4 = t2 - t3
	bnez $t4, strncmp_done # se t4 é diferente de 0
	beqz $t5, strncmp_done # se t5 = 0
	beqz $t4, strncmp_loop # se t4 = 0
	


strncmp_done:
	move $v0, $t4
	jr $ra