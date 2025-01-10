# Projeto 1 VA Arquitetura e Organização de Computadores - 2024.2
# Alunos: Heitor Leander Feitosa da silva
#         João victor Morais Barreto da silva
#         Mariane Elisa dos Santos Souza
#         Samuel Roberto de Carvalho Bezerra

.data
	banner:  	.asciiz "MIPShelf-shell>>"
	barra_n:    .byte 10      # Valor em ASCII do caractere de quebra de linha \n
	comando: 	.space 100    # Espaço reservado para o comando digitado pelo usuário
	
	# Livro:
	titulo:  	.space 50     # Espaço reservado para o título do livro
	autor:    	.space 50     # Espaço reservado para o nome do autor do livro
	ISBN:       .space 10     # Espaço reservado para o código de ISBN do livro
	quantidade: .space 5   	  # Espaço reservado para a quantidade de livros disponíveis:
	
	# Usuário:
	nome:   	.space 50     # Espaço reservado para o nome do usuário
	matricula:	.space 10     # Espaço reservado para o número de matrícula do usuário
	curso:      .space 25     # Espaço reservado para o curso do usuário
	
	# Empréstimo:
	matricula_usuario_ass: 	.space 10   # Espaço reservado para a matrícula do usuário associado ao empréstimo
	ISBN_livro_ass:         .space 10   # Espaço reservado para o código de ISBN do livro associado ao empréstimo
	data_registro:  	.space 10       # Espaço reservado para a data em que foi registrado o empréstimo
	data_devolucao: 	.space 10       # Espaço reservado para a data de devolução do empréstimo
	
	# Comandos:
	cmd_data_hora: 			.asciiz "data_hora"
	cmd_cadastrar_livro: 	.asciiz "cadastrar_livro"
	cmd_cadastrar_usuario:  .asciiz "cadastrar_usuario"
	cmd_listar_livro: 		.asciiz "listar_livro"
	cmd_reg_emprestimo:     .asciiz "registrar_emprestimo"
	cmd_gerar_relatorio:    .asciiz "gerar_relatorio"
	cmd_remover_livro:      .asciiz "remover_livro"
	cmd_remover_usuario: 	.asciiz "remover_usuario"
	cmd_savar_dados: 	    .asciiz "salvar_dados"
	cmd_formatar_dados: 	.asciiz "formatar_dados"
	
	# Mensagens de confirmação:
	msgC_livro_cadastrado: 		.asciiz "Livro cadastrado com sucesso!"
	msgC_usuario_cadastrado: 	.asciiz "Usuario cadastrado com sucesso!"
	msgC_emprestimo_realizado: 	.asciiz "Empréstimo realizado com sucesso!"
	msgC_livro_removido:        .asciiz "Livro removido com sucesso!"
	msgC_usuario_removido:      .asciiz "usuario removido com sucesso!"
	
	# Mensagens de erro:
	msgE_comando_invalido:          .asciiz "Comando inválido"
	msgE_acervo_vazio:				.asciiz "O acervo está vazio."
	msgE_esprestimo_indisponivel: 	.asciiz "Livro indisponível para o empréstimo."
	msgE_relatorio_indisponivel:    .asciiz "Não há dados disponíveis para gerar o relatório."
	msgE_livro_nao_encontrado:      .asciiz "O livro informado não foi encontrado no acervo."
	msgE_livro_esta_emprestado:     .asciiz "O livro não pode ser removido por estar emprestado."
	msgE_usuario_nao_encontrado:    .asciiz "O usuário informado não foi encontrado no acervo."
	msgE_usuario_tem_pendencias:    .asciiz "O usuário não pode ser removido por ter devoluções pendêntes."
	
.text
.globl main

main:
	# Escrever aqui a função que lê os dados do arquivo .txt	
	jal escrever_banner_display
	jal esperar_input_teclado
	
	j main # entra em loop
	
esperar_display_carregar:
	li $t0, 0xFFFF0008   		   		  # Endereço do status do display
    lw $t1, 0($t0)        				  # Carrega o status do display em $t1
    beqz $t1, esperar_display_carregar    # Se status for 0, entra em loop
    
    jr $ra

# função genérica que escreve qualquer string cujo endereço esteja armazenado em $t2 no display 
escrever_string_display:
	# Aloca espaço no $sp para salvar o endereço de $ra
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    
    jal esperar_display_carregar
    
    lw $ra, 0($sp) 			   #resgata o $ra original do $sp
    addi $sp, $sp, 4		   #devolve a pilha para a posicao original
    
    li $t0, 0xFFFF000C         # Endereço do Transmiter data do display

	loop_string_display:
		lb $t3, 0($t2)   			# Carrega um caractere da string de $t2 para $t3
    	beqz $t3, fim    			# Se o caractere em $t3 for o caractere de fim de string, sai do loop
    	sw $t3, 0($t0)    			# Caso contrário, escreve o caractere no display
    	addi $t2, $t2, 1  			# Avança para o próximo caractere
    	j loop_string_display       # Continua com loop
    
    fim:
    jr $ra

esperar_input_teclado:
    li $t0, 0xFFFF0000   			 # Endereço do status do teclado
    lw $t1, 0($t0)        			 # Carrega o status do teclado em $t1
    beqz $t1, esperar_input_teclado  # Se status for 0, entra em loop
	
	li $t0, 0xFFFF0004       # Endereço do Receiver data do teclado
   	lw $t2, 0($t0)           # Carrega o caractere digitado em $t2
    
  	# O trecho seguinte armazena o caractere digitado no espaço reservado para comando
    la $t3, comando          # Carrega o endereço de comando em $t3
    
    loop_armazenar:
        lb $t4, 0($t3)       # Lê o caractere atual do comando e armazena em $t4
        beqz $t4, armazenar  # Se o caractere atual for nulo, armazena
        addi $t3, $t3, 1     # Caso contrário avança para a próxima posição
        j loop_armazenar	 # entra em loop

    armazenar:
        sb $t2, 0($t3)       # Salva o caractere digitado na posição atual do comando
    
    # Verifica se o caractere digitado é barra_n (\n)
    la $t6, barra_n                  # Carrega o endereço de barra_n
    lb $t6, 0($t6)                   # Carrega o valor de barra_n
    beq $t2, $t6, verificar_comando  # Se for barra_n, chama verificar_comando

    # caso contrário, exibe o caractere no display
    jal escrever_caractere_digitado_display
    
    j esperar_input_teclado # entra em loop para esperar o próximo caractere
    
escrever_caractere_digitado_display:
    # Aloca espaço no $sp para salvar o endeço de $ra
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    
    jal esperar_display_carregar
    
    lw $ra, 0($sp) 		  #resgata o $ra original do $sp
    addi $sp, $sp, 4      #devolve a pilha para a posicao original
	
    li $t0, 0xFFFF000C    # Endereço do Receiver data do display
	sw $t2, 0($t0)        # Escreve o caractere no display

	jr $ra	
	
escrever_barra_n_display:
    # Aloca espaço no $sp para salvar o endereço de $ra
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    
    jal esperar_display_carregar
    
    lw $ra, 0($sp) 			   #resgata o $ra original do $sp
    addi $sp, $sp, 4		   #devolve a pilha para a posicao original

    la $t2, barra_n            # Carrega o endereço de barra_n
    lb $t2, 0($t2)             # Carrega o valor de barra_n em $t2

    li $t0, 0xFFFF000C         # Endereço do Transmitter data do display
    sw $t2, 0($t0)             # Escreve o caractere \n no display

    jr $ra
    
escrever_banner_display:
	la $t2, banner        # Carrega o endereço do início da string do banner
	
    # Aloca espaço no $sp para salvar o endereço de $ra
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    
    jal escrever_string_display
    
    lw $ra, 0($sp) 			   #resgata o $ra original do $sp
    addi $sp, $sp, 4		   #devolve a pilha para a posicao original

    jr $ra

escrever_livro_cadastrado_display:
    la $t2, msgC_livro_cadastrado   # Carrega o endereço de msgC_livro_cadastrado
    jal escrever_string_display     # Pula para a função genérica que irá imprimir a string armazenada em $t2
    j main   
    
escrever_usuario_cadastrado_display:
    la $t2, msgC_usuario_cadastrado # Carrega o endereço de msgC_usuario_cadastrado 
    jal escrever_string_display     # Pula para a função genérica que irá imprimir a string armazenada em $t2
    j main
    
escrever_emprestimo_realizado_display:
    la $t2, msgC_emprestimo_realizado  # Carrega o endereço de msgC_emprestimo_realizado
    jal escrever_string_display        # Pula para a função genérica que irá imprimir a string armazenada em $t2
    j main     
    
escrever_livro_removido_display:
    la $t2, msgC_livro_removido   # Carrega o endereço de msgC_livro_removido
    jal escrever_string_display   # Pula para a função genérica que irá imprimir a string armazenada em $t2
    j main    
    
escrever_usuario_removido_display:
    la $t2, msgC_usuario_removido   # Carrega o endereço de msgC_usuario_removido
    jal escrever_string_display     # Pula para a função genérica que irá imprimir a string armazenada em $t2
    j main            

escrever_comando_invalido_display:
	la $t2, msgE_comando_invalido   # Carrega o endereço de msgE_comando_invalido
    jal escrever_string_display     # Pula para a função genérica que irá imprimir a string armazenada em $t2
    j main
	
escrever_acervo_vazio_display:
    la $t2, msgE_acervo_vazio     # Carrega o endereço de msgE_acervo_vazio
    jal escrever_string_display   # Pula para a função genérica que irá imprimir a string armazenada em $t2
    j main            

escrever_esprestimo_indisponivel_display:
    la $t2, msgE_esprestimo_indisponivel   # Carrega o endereço de msgE_comando_invalido
    jal escrever_string_display            # Pula para a função genérica que irá imprimir a string armazenada em $t2
    j main          

escrever_relatorio_indisponivel_display:
    la $t2, msgE_relatorio_indisponivel   # Carrega o endereço de msgE_relatorio_indisponivel
    jal escrever_string_display           # Pula para a função genérica que irá imprimir a string armazenada em $t2
    j main 
    
escrever_livro_nao_encontrado_display:
    la $t2, msgE_livro_nao_encontrado   # Carrega o endereço de msgE_livro_nao_encontrado 
    jal escrever_string_display         # Pula para a função genérica que irá imprimir a string armazenada em $t2
    j main         

escrever_livro_esta_emprestado_display:
    la $t2, msgE_livro_esta_emprestado   # Carrega o endereço de msgE_livro_esta_emprestado
    jal escrever_string_display          # Pula para a função genérica que irá imprimir a string armazenada em $t2
    j main   
    
escrever_usuario_nao_encontrado_display:
    la $t2, msgE_usuario_nao_encontrado   # Carrega o endereço de msgE_usuario_nao_encontrado
    jal escrever_string_display           # Pula para a função genérica que irá imprimir a string armazenada em $t2
    j main    
    
escrever_usuario_tem_pendencias_display:
    la $t2, msgE_usuario_tem_pendencias   # Carrega o endereço de msgE_usuario_tem_pendencias
    jal escrever_string_display           # Pula para a função genérica que irá imprimir a string armazenada em $t2
    j main    

verificar_comando:
	jal escrever_barra_n_display    # pula para a função que escreve o caractere de quebra de linha (\n) no display
    sb $zero, 0($t3)       			# Substitui o \n pelo caractere de fim de string (\0)
    
    # Aqui será implementada a lógica de verificação de comando
    
    j main   #  pula pro main
