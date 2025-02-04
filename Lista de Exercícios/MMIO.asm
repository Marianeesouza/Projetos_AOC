
# Projeto 1 VA Arquitetura e Organizacao de Computadores - 2024.2
# Alunos: Heitor Leander Feitosa da Silva
#         Joao victor Morais Barreto da silva
#         Mariane Elisa dos Santos Souza
#         Samuel Roberto de Carvalho Bezerra

# O presente arquivo descreve o funcionamento do simulador Keyboard and Display MMIO,
# sendo resposta para a questao 2 da lista de exercicios.
# O codigo utiliza o simulador MMIO para exibir um echo das entradas dadas no teclado para o display.

.text
	main:
    	jal esperar_teclado_carregar
    	jal esperar_display_carregar
        
    	# Loop continuo para leitura e exibicao dos caracteres
   	 j main

	esperar_teclado_carregar:
    	li $t0, 0xFFFF0000    # Endereco do status do teclado
    	lw $t1, 0($t0)        # Carrega o status do teclado em $t1
    	beqz $t1, esperar_teclado_carregar  # Se status for 0, entra em loop 
	
		# Aloca espaco no $sp para salvar o endeco de $ra
    	addi $sp, $sp, -4
    	sw $ra, 0($sp)
    
    	jal ler_caractere_teclado
    
    	lw $ra, 0($sp) #resgata o $ra original do $sp
    	addi $sp, $sp, 4 #devolve a pilha para a posicao original
    
    	jr $ra
    
	ler_caractere_teclado:
		li $t0, 0xFFFF0004    # Endereco do data do teclado
   		lw $t2, 0($t0)        # Carrega o caractere em $t2
    
    	jr $ra

	esperar_display_carregar:
    	li $t0, 0xFFFF0008    # Endereco do status do display
    	lw $t1, 0($t0)        # Carrega o status do display em $t1
    	beqz $t1, esperar_display_carregar  # Se status for 0, espera
	
		# Aloca espaco no $sp para salvar o endereco de $ra
    	addi $sp, $sp, -4
    	sw $ra, 0($sp)
    
    	jal escrever_caractere_display
    
    	lw $ra, 0($sp) #resgata o $ra original do $sp
    	addi $sp, $sp, 4 #devolve a pilha para a posicao original
    
   		jr $ra
	
	escrever_caractere_display:
   		# Escrever o caractere no display
    	li $t0, 0xFFFF000C    # Endereco do data do display
    	sw $t2, 0($t0)        # Escreve o caractere no display

		jr $ra
