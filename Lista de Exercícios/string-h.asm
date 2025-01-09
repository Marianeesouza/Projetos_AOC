
# Projeto 1 VA Arquitetura e Organização de Computadores - 2024.2
# Alunos: Heitor Leander Feitosa da silva
#         João victor Morais Barreto da silva
#         Mariane Elisa dos Santos Souza
#         Samuel Roberto de Carvalho Bezerra

.data
	source:    .asciiz "Hello, MIPS!"    # String de origem
	source2:	.asciiz "Olá, MIPS!" 
	destination: .space 100              # Espaço reservado para a string destino

.text
	main:
		# Configuração inicial
    	la $a0, destination   # Endereço do destino (deve apontar para uma área válida de memória)
    	la $a1, source        # Endereço da origem (deve apontar para a string "Hello, MIPS!")
    	jal strcpy            # Chama a função strcpy
		
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
		sub $sp, $sp, 8          # Cria espaço para dois valores de 4 bytes
    	sw $a0, 0($sp)           # Salva $a0 na pilha
		sw $a1, 4($sp)           # Salva $a1 na pilha

    	# Início da cópia
		copia_strcpy:
			lb $t0, 0($a1) # Carrega o caractere atual para o t0
			sb $t0, 0($a0) # Guarda o caractere atual do t0 para o a0
			beq $t0, $zero, fim_copia_strcpy # Se o caractere for nulo, então a string terminou
			
			# Passa para o proximo byte da string
			addi $a1, $a1, 1 
			addi $a0, $a0, 1
			j copia_strcpy
			
		fim_copia_strcpy:
			# adicionando uma quebra de linha ao fim da string
			li $t0, 10            # Caractere '\n' em ASCII é 10
       		sb $t0, 0($a0)        # Adiciona '\n' ao final da string copiada
       				
       		# Colocando o caractere nulo no lugar
        	addi $a0, $a0, 1      # Incrementa o destino para o próximo byte
        	sb $zero, 0($a0)      # Adiciona o caractere NULL (\0) após a quebra de linha
        			
        	move $v0, $a0         # Retorna o endereço do destino atualizado
        	# Restaurar os valores originais de $a0 e $a1
        	lw $a0, 0($sp)        # Restaura $a0 da pilha
        	lw $a1, 4($sp)        # Restaura $a1 da pilha
        	addi $sp, $sp, 8      # Desaloca o espaço usado na pilha
             		
			# Retorna da função
			jr $ra
        
	memcpy: # Copia uma quantidade num (a2) de caracteres de uma string do source (a1) para o destination (a0) 
        
        # Salvar os valores originais de $a0 e $a1 na pilha
		sub $sp, $sp, 8          # Cria espaço para dois valores de 4 bytes
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
			li $t0, 10            # Caractere '\n' em ASCII é 10
       		sb $t0, 0($a0)        # Adiciona '\n' ao final da string copiada
       				
       		# Colocando o caractere nulo no lugar
        	addi $a0, $a0, 1      # Incrementa o destino para o próximo byte
        	sb $zero, 0($a0)      # Adiciona o caractere NULL (\0) após a quebra de linha
        			
        	move $v0, $a0         # Retorna o endereço do destino atualizado
			# Restaurar os valores originais de $a0 e $a1
        	lw $a0, 0($sp)        # Restaura $a0 da pilha
        	lw $a1, 4($sp)        # Restaura $a1 da pilha
        	addi $sp, $sp, 8      # Desaloca o espaço usado na pilha
             		
			# Retorna da função
			jr $ra
	
	strcmp: 
    	li $v0, 0             # Inicializa o valor de v0 como 0 (presumimos strings iguais inicialmente)

    	# Salvar os valores originais de $a0 e $a1 na pilha
    	sub $sp, $sp, 8        # Cria espaço para dois valores de 4 bytes
    	sw $a0, 0($sp)         # Salva $a0 na pilha
    	sw $a1, 4($sp)         # Salva $a1 na pilha

    		verifica_strcmp:
        		lb $t1, 0($a1)     # Carrega o caractere atual de a1 (str2)
        		lb $t0, 0($a0)     # Carrega o caractere atual de a0 (str1)
        		beq $t0, $t1, verifica_zero_strcmp  # Se os caracteres forem iguais, vai verificar se acabou

        		# Se não forem iguais, calcula a diferença
        		sub $v0, $t0, $t1  # Calcula a diferença t0 - t1
        		j fim_strcmp

    		verifica_zero_strcmp:
        		beq $t0, $zero, fim_strcmp  # Se o caractere for nulo, as strings acabaram

        		# Passa para o próximo caractere
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
        		addi $sp, $sp, 8     # Desaloca o espaço usado na pilha
        		jr $ra               # Retorna da função

	strncmp: # strcmp com contagem de caracteres
        # Salvar os valores originais de $a0 e $a1 na pilha
		sub $sp, $sp, 8          # Cria espaço para dois valores de 4 bytes
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

        	# Passa para o próximo caractere
        	addi $a1, $a1, 1
        	addi $a0, $a0, 1
        	j verifica_strcmp

    	fim_strncmp:
    		sub $v0, $t0, $t1  # Calcula a diferença t0 - t1
        	# Se as strings forem iguais, imprime 0
        	move $a0, $v0        # Move o valor de v0 para $a0
        	li $v0, 1            # Syscall para imprimir inteiro
        	syscall

        	# Restaura os valores originais de $a0 e $a1
        	lw $a0, 0($sp)       # Restaura $a0 da pilha
        	lw $a1, 4($sp)       # Restaura $a1 da pilha
        	addi $sp, $sp, 8     # Desaloca o espaço usado na pilha
        	jr $ra               # Retorna da função

	strcat:
        # Salvar os valores originais de $a0 e $a1 na pilha
		sub $sp, $sp, 8          # Cria espaço para dois valores de 4 bytes
    	sw $a0, 0($sp)           # Salva $a0 na pilha
		sw $a1, 4($sp)           # Salva $a1 na pilha
		
		acha_final_strcat:
			lb $t0, 0($a0)        # Carrega o primeiro caractere de destination
			beq $t0, $zero, copia_final_strcat  # Se for NULL (\0), encontrou o final
        	addi $a0, $a0, 1       # Move para o próximo caractere em destination
        	j acha_final_strcat
        	
        copia_final_strcat:
        	lb $t1, 0($a1)         # Carrega o caractere de source
        	beq $t1, $zero, fim_strcat  # Se for NULL (\0), fim da string source
        	sb $t1, 0($a0)         # Coloca o caractere de source em destination
        	addi $a0, $a0, 1       # Move para o próximo caractere em destination
        	addi $a1, $a1, 1       # Move para o próximo caractere em source
        	j copia_final_strcat
        
        fim_strcat:
        	# Adicionar o caractere NULL (\0) no final da string concatenada
        	sb $zero, 0($a0)       # Coloca \0 no final de destination

    		# Retorna o endereço de destination
    		move $v0, $a0            # Retorna o endereço de destination
    		# Restaura os valores originais de $a0 e $a1
        	lw $a0, 0($sp)       # Restaura $a0 da pilha
        	lw $a1, 4($sp)       # Restaura $a1 da pilha
        	addi $sp, $sp, 8     # Desaloca o espaço usado na pilha
        	jr $ra               # Retorna da função
