
# Projeto 1 VA Arquitetura e Organização de Computadores - 2024.2
# Alunos: Heitor Leander Feitosa da silva
#         João victor Morais Barreto da silva
#         Mariane Elisa dos Santos Souza
#         Samuel Roberto de Carvalho Bezerra
.text
	main:
    	jal esperar_teclado_carregar
    	jal esperar_display_carregar
        
    	# Loop contínuo para leitura e exibição dos caracteres
   	 j main

	esperar_teclado_carregar:
    	li $t0, 0xFFFF0000    # Endereço do status do teclado
    	lw $t1, 0($t0)        # Carrega o status do teclado em $t1
    	beqz $t1, esperar_teclado_carregar  # Se status for 0, entra em loop 
	
		# Aloca espaço no $sp para salvar o endeço de $ra
    	addi $sp, $sp, -4
    	sw $ra, 0($sp)
    
    	jal ler_caractere_teclado
    
    	lw $ra, 0($sp) #resgata o $ra original do $sp
    	addi $sp, $sp, 4 #devolve a pilha para a posicao original
    
    	jr $ra
    
	ler_caractere_teclado:
		li $t0, 0xFFFF0004    # Endereço do data do teclado
   		lw $t2, 0($t0)        # Carrega o caractere em $t2
    
    	jr $ra

	esperar_display_carregar:
    	li $t0, 0xFFFF0008    # Endereço do status do display
    	lw $t1, 0($t0)        # Carrega o status do display em $t1
    	beqz $t1, esperar_display_carregar  # Se status for 0, espera
	
		# Aloca espaço no $sp para salvar o endeço de $ra
    	addi $sp, $sp, -4
    	sw $ra, 0($sp)
    
    	jal escrever_caractere_display
    
    	lw $ra, 0($sp) #resgata o $ra original do $sp
    	addi $sp, $sp, 4 #devolve a pilha para a posicao original
    
   		jr $ra
	
	escrever_caractere_display:
   		# Escrever o caractere no display
    	li $t0, 0xFFFF000C    # Endereço do data do display
    	sw $t2, 0($t0)        # Escreve o caractere no display

		jr $ra
