# Projeto 1 VA Arquitetura e Organização de Computadores - 2024.2
# Alunos: Heitor Leander Feitosa da silva
#         João victor Morais Barreto da silva
#         Mariane Elisa dos Santos Souza
#         Samuel Roberto de Carvalho Bezerra

.data
	banner:  		.asciiz "MIPShelf-shell>>"
	comando: 		.space 100    # Espaço reservado para o comando digitado pelo usuário
	data_sistema:   .space 5  	  # Espaço reservado para a data do sistema
	hora_sistema: 	.space 5 	  # Espaço reservado para a hora do sistema
	
	# Caracteres
	barra_n:   		.byte 10      # Valor em ASCII do caractere de quebra de linha '\n'
	espaco:			.byte 32      # Valor em ASCII do caractere de espaço ' '       
	
	# Livro:
	titulo:  	.space 30     # Espaço reservado para o título do livro
	autor:    	.space 30     # Espaço reservado para o nome do autor do livro
	ISBN:       .space 10     # Espaço reservado para o código de ISBN do livro
	quantidade: .space 5   	  # Espaço reservado para a quantidade de livros disponíveis:
	
	# Usuário:
	nome:   	.space 30     # Espaço reservado para o nome do usuário
	matricula:	.space 10     # Espaço reservado para o número de matrícula do usuário
	curso:      .space 15     # Espaço reservado para o curso do usuário
	
	# Empréstimo:
	matricula_usuario_ass: 	.space 10   # Espaço reservado para a matrícula do usuário associado ao empréstimo
	ISBN_livro_ass:         .space 10   # Espaço reservado para o código de ISBN do livro associado ao empréstimo
	data_registro:  		.space 10   # Espaço reservado para a data em que foi registrado o empréstimo
	data_devolucao: 		.space 10   # Espaço reservado para a data de devolução do empréstimo
	
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
	
	# Argumentos
	arg_titulo:      	.asciiz "--titulo"
	arg_autor:      	.asciiz "--autor"
	arg_ISBN:        	.asciiz "--isbn"
	arg_quantidade: 	.asciiz "--qtd"
	arg_nome:			.asciiz "--nome"
	arg_matricula:  	.asciiz "--matricula"
	arg_curso:			.asciiz "--curso"
	arg_devolucao: 		.asciiz "--devolucao"
	arg_data:           .asciiz "--data"
	arg_hora:           .asciiz "--hora"
	
	# Mensagens de confirmação:
	msgC_livro_cadastrado: 		.asciiz "Livro cadastrado com sucesso!"
	msgC_usuario_cadastrado: 	.asciiz "Usuario cadastrado com sucesso!"
	msgC_emprestimo_realizado: 	.asciiz "Empréstimo realizado com sucesso!"
	msgC_livro_removido:        .asciiz "Livro removido com sucesso!"
	msgC_usuario_removido:      .asciiz "usuario removido com sucesso!"
	
	# Mensagens de erro:
	msgE_comando_invalido:         			 .asciiz "Comando inválido!"
	msgE_acervo_vazio:						 .asciiz "O acervo está vazio."
	msgE_esprestimo_indisponivel: 		     .asciiz "Livro indisponível para o empréstimo."
	msgE_relatorio_indisponivel:  			 .asciiz "Não há dados disponíveis para gerar o relatório."
	msgE_livro_nao_encontrado:     			 .asciiz "O livro informado não foi encontrado no acervo."
	msgE_livro_esta_emprestado:    			 .asciiz "O livro não pode ser removido por estar emprestado."
	msgE_usuario_nao_encontrado:    		 .asciiz "O usuário informado não foi encontrado no acervo."
	msgE_usuario_tem_pendencias:    		 .asciiz "O usuário não pode ser removido por ter devoluções pendêntes."
	msgE_parte1_falta_argumento_obrigatorio: .asciiz "O campo \"" 
	msgE_parte2_falta_argumento_obrigatorio: .asciiz "\" é obrigatório, certifique de usá-lo para que a operação seja realizada"
	
.text
.globl main

main:
	# Escrever aqui a função que lê os dados do arquivo .txt
	jal escrever_banner_display
	jal esperar_input_teclado

	j main 
                      
esperar_display_carregar:
	li $t0, 0xFFFF0008   		   		  # Endereço do status do display
    lw $t0, 0($t0)        				  # Carrega o status do display diretamente em $t0
    beqz $t0, esperar_display_carregar    # Se status for 0, entra em loop
    
    jr $ra

escrever_string_display:
	# $t1: reg que possui o endereço da string a ser digitada no display
	
	# Aloca espaço no $sp para salvar o endereço de $ra
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    
    jal esperar_display_carregar 	# Pula para a função que espera o display carregar
    
    lw $ra, 0($sp) 			   		#resgata o $ra original do $sp
    addi $sp, $sp, 4		  		#devolve a pilha para a posicao original
    
    li $t0, 0xFFFF000C         		# Endereço do Transmiter data do display

	loop_string_display:
		lb $t2, 0($t1)   			# Carrega um caractere da string de $t1 para $t2
    	beqz $t2, fim    			# Se o caractere em $t2 for o caractere de fim de string, sai do loop
    	sw $t2, 0($t0)    			# Caso contrário, escreve o caractere no display
    	addi $t1, $t1, 1  			# Avança para o próximo caractere
    	j loop_string_display       # Continua com loop
    
    fim:
    jr $ra

esperar_input_teclado:
    li $t0, 0xFFFF0000   			 # Endereço do status do teclado
    lw $t0, 0($t0)        			 # Carrega o status do teclado diretamente em $t0
    beqz $t0, esperar_input_teclado  # Se status for 0, entra em loop
	
	li $t0, 0xFFFF0004       # Endereço do Receiver data do teclado
   	lw $t1, 0($t0)           # Carrega o caractere digitado em $t1
    
  	# O trecho seguinte armazena o caractere digitado no espaço reservado para comando
    la $s0, comando          # Carrega o endereço de comando em $s0
    
    loop_armazenar:
        lb $t2, 0($s0)       # Lê o caractere atual do comando e armazena em $t2
        beqz $t2, armazenar  # Se o caractere atual for nulo, armazena
        addi $s0, $s0, 1     # Caso contrário avança para a próxima posição
        j loop_armazenar	 # entra em loop

    armazenar:
        sb $t1, 0($s0)       # Salva o caractere digitado na posição atual do comando
    
    # Verifica se o caractere digitado é barra_n (\n)
    la $t2, barra_n                  # Carrega o endereço de barra_n
    lb $t2, 0($t2)                   # Carrega o valor de barra_n
    beq $t1, $t2, verificar_comando  # Se for barra_n, chama verificar_comando

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
	sw $t1, 0($t0)        # Escreve o caractere no display

	jr $ra	
	
escrever_barra_n_display:
    # Aloca espaço no $sp para salvar o endereço de $ra
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    
    jal esperar_display_carregar
    
    lw $ra, 0($sp) 			   #resgata o $ra original do $sp
    addi $sp, $sp, 4		   #devolve a pilha para a posicao original

    la $t1, barra_n            # Carrega o endereço de barra_n
    lb $t1, 0($t1)             # Carrega o valor de barra_n diretamente em $t1

    li $t0, 0xFFFF000C         # Endereço do Transmitter data do display
    sw $t1, 0($t0)             # Escreve o caractere \n no display

    jr $ra
    
escrever_banner_display:
	la $t1, banner      # Carrega o endereço do início da string do banner
	
    # Aloca espaço no $sp para salvar o endereço de $ra
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    
    jal escrever_string_display
    
    lw $ra, 0($sp) 		#resgata o $ra original do $sp
    addi $sp, $sp, 4	#devolve a pilha para a posicao original

    jr $ra
     
verificar_comando:
	jal escrever_barra_n_display    # pula para a função que escreve o caractere de quebra de linha (\n) no display
    sb $zero, 0($s0)       			# Substitui o \n digitado pelo usuário pelo caractere nulo (\0)
    
    # Aqui será implementada a lógica de verificação de comando
    
    j main   #  pula pro main

escrever_livro_cadastrado_display:
    jal escrever_barra_n_display    # pula para a função que irá imprimir uma quebra de linha no display
    la $t1, msgC_livro_cadastrado   # Carrega o endereço de msgC_livro_cadastrado
    jal escrever_string_display     # Pula para a função genérica que irá imprimir a string armazenada em $t1
    jal escrever_barra_n_display    
    j main   
    
escrever_usuario_cadastrado_display:
    jal escrever_barra_n_display    # pula para a função que irá imprimir uma quebra de linha no display
    la $t1, msgC_usuario_cadastrado # Carrega o endereço de msgC_usuario_cadastrado 
    jal escrever_string_display     # Pula para a função genérica que irá imprimir a string armazenada em $t1
    jal escrever_barra_n_display   
    j main   
    
escrever_emprestimo_realizado_display:
    jal escrever_barra_n_display       # pula para a função que irá imprimir uma quebra de linha no display
    la $t1, msgC_emprestimo_realizado  # Carrega o endereço de msgC_emprestimo_realizado
    jal escrever_string_display        # Pula para a função genérica que irá imprimir a string armazenada em $t1
    jal escrever_barra_n_display      
    j main   
    
escrever_livro_removido_display:
    jal escrever_barra_n_display    # pula para a função que irá imprimir uma quebra de linha no display
    la $t1, msgC_livro_removido     # Carrega o endereço de msgC_livro_removido
    jal escrever_string_display     # Pula para a função genérica que irá imprimir a string armazenada em $t1
    jal escrever_barra_n_display    
    j main   
    
escrever_usuario_removido_display:
    jal escrever_barra_n_display    # pula para a função que irá imprimir uma quebra de linha no display
    la $t1, msgC_usuario_removido   # Carrega o endereço de msgC_usuario_removido
    jal escrever_string_display     # Pula para a função genérica que irá imprimir a string armazenada em $t1
    jal escrever_barra_n_display    
    j main   

escrever_comando_invalido_display:
    jal escrever_barra_n_display    # pula para a função que irá imprimir uma quebra de linha no display
	la $t1, msgE_comando_invalido   # Carrega o endereço de msgE_comando_invalido
    jal escrever_string_display     # Pula para a função genérica que irá imprimir a string armazenada em $t1
    jal escrever_barra_n_display    
    j main   
	
escrever_acervo_vazio_display:
    jal escrever_barra_n_display    # pula para a função que irá imprimir uma quebra de linha no display
    la $t1, msgE_acervo_vazio       # Carrega o endereço de msgE_acervo_vazio
    jal escrever_string_display     # Pula para a função genérica que irá imprimir a string armazenada em $t1
    jal escrever_barra_n_display        
    j main   

escrever_esprestimo_indisponivel_display:
    jal escrever_barra_n_display    	   # pula para a função que irá imprimir uma quebra de linha no display
    la $t1, msgE_esprestimo_indisponivel   # Carrega o endereço de msgE_comando_invalido
    jal escrever_string_display            # Pula para a função genérica que irá imprimir a string armazenada em $t1
    jal escrever_barra_n_display     
    j main   

escrever_relatorio_indisponivel_display:
    jal escrever_barra_n_display    	  # pula para a função que irá imprimir uma quebra de linha no display
    la $t1, msgE_relatorio_indisponivel   # Carrega o endereço de msgE_relatorio_indisponivel
    jal escrever_string_display           # Pula para a função genérica que irá imprimir a string armazenada em $t1
    jal escrever_barra_n_display    
    j main   
    
escrever_livro_nao_encontrado_display:
    jal escrever_barra_n_display    	# pula para a função que irá imprimir uma quebra de linha no display
    la $t1, msgE_livro_nao_encontrado   # Carrega o endereço de msgE_livro_nao_encontrado 
    jal escrever_string_display         # Pula para a função genérica que irá imprimir a string armazenada em $t1
    jal escrever_barra_n_display    
    j main   

escrever_livro_esta_emprestado_display:
    jal escrever_barra_n_display    	 # pula para a função que irá imprimir uma quebra de linha no display
    la $t1, msgE_livro_esta_emprestado   # Carrega o endereço de msgE_livro_esta_emprestado
    jal escrever_string_display          # Pula para a função genérica que irá imprimir a string armazenada em $t1
    jal escrever_barra_n_display        
    j main   
    
escrever_usuario_nao_encontrado_display:
    jal escrever_barra_n_display    	  # pula para a função que irá imprimir uma quebra de linha no display
    la $t1, msgE_usuario_nao_encontrado   # Carrega o endereço de msgE_usuario_nao_encontrado
    jal escrever_string_display           # Pula para a função genérica que irá imprimir a string armazenada em $t1
    jal escrever_barra_n_display        
    j main   
    
escrever_usuario_tem_pendencias_display:
    jal escrever_barra_n_display    # pula para a função que irá imprimir uma quebra de linha no display    
    la $t1, msgE_usuario_tem_pendencias   # Carrega o endereço de msgE_usuario_tem_pendencias
    jal escrever_string_display           # Pula para a função genérica que irá imprimir a string armazenada em $t1
    jal escrever_barra_n_display   
    j main   

# Função genérica que imprime a mensagem de falta de qualquer argumento no display
escrever_falta_argumento_obrigatorio_display:
	# $s1: reg que possui o endereço do argumento faltante
	
	# Aloca espaço no $sp para salvar o endereço de $ra
    addi $sp, $sp, -4
    sw $ra, 0($sp)
	
	la $t1, msgE_parte1_falta_argumento_obrigatorio  # Carrega o endeço de msgE_parte1_falta_argumento_obrigatorio
	jal escrever_string_display  # Pula para a função genérica que irá imprimir a string armazenada em $t1
	
	addi $t1, $s1, 0   # soma $s1 com 0 e armazena em t1 (em outras palavras copia o endereço de $s1 pra $t1)
	jal escrever_string_display   
	
	la $t1, msgE_parte2_falta_argumento_obrigatorio  # Carrega o endeço de msgE_parte2_falta_argumento_obrigatorio
	jal escrever_string_display     
	
	lw $ra, 0($sp) 		#resgata o $ra original do $sp
    addi $sp, $sp, 4	#devolve a pilha para a posicao original

    jr $ra                 
	  
escrever_falta_argumento_titulo_display:
    jal escrever_barra_n_display    # pula para a função que irá imprimir uma quebra de linha no display
	la $s1, arg_titulo  # Carrega o endereço arg_titulo
	jal escrever_falta_argumento_obrigatorio_display
	jal escrever_barra_n_display    
    j main   
	
escrever_falta_argumento_autor_display:
    jal escrever_barra_n_display    # pula para a função que irá imprimir uma quebra de linha no display
	la $s1, arg_autor  # Carrega o endereço arg_autor
	jal escrever_falta_argumento_obrigatorio_display
    jal escrever_barra_n_display    
    j main   
	
escrever_falta_argumento_ISBN_display:
    jal escrever_barra_n_display    # pula para a função que irá imprimir uma quebra de linha no display
	la $s1, arg_ISBN  # Carrega o endereço arg_ISBN
	jal escrever_falta_argumento_obrigatorio_display
	jal escrever_barra_n_display    
    j main   
	
escrever_falta_argumento_quantidade_display:
    jal escrever_barra_n_display    # pula para a função que irá imprimir uma quebra de linha no display
	la $s1, arg_quantidade  # Carrega o endereço arg_quantidade 
	jal escrever_falta_argumento_obrigatorio_display
    jal escrever_barra_n_display    
    j main   
	
escrever_falta_argumento_nome_display:
    jal escrever_barra_n_display    # pula para a função que irá imprimir uma quebra de linha no display
	la $s1, arg_nome  # Carrega o endereço arg_nome
	jal escrever_falta_argumento_obrigatorio_display
	jal escrever_barra_n_display    
    j main   
	
escrever_falta_argumento_matricula_display:
    jal escrever_barra_n_display    # pula para a função que irá imprimir uma quebra de linha no display
	la $s1, arg_matricula  # Carrega o endereço arg_matricula
	jal escrever_falta_argumento_obrigatorio_display
    jal escrever_barra_n_display    
    j main   
	
escrever_falta_argumento_curso_display:
    jal escrever_barra_n_display    # pula para a função que irá imprimir uma quebra de linha no display
	la $s1, arg_curso  # Carrega o endereço arg_curso
	jal escrever_falta_argumento_obrigatorio_display
    jal escrever_barra_n_display    
    j main   
	
escrever_falta_argumento_devolucao_display:
    jal escrever_barra_n_display    # pula para a função que irá imprimir uma quebra de linha no display
	la $s1, arg_devolucao  # Carrega o endereço arg_devolucao
	jal escrever_falta_argumento_obrigatorio_display
	jal escrever_barra_n_display    
    j main  
    
escrever_falta_argumento_data_display:
    jal escrever_barra_n_display    # pula para a função que irá imprimir uma quebra de linha no display
	la $s1, arg_data  # Carrega o endereço arg_data
	jal escrever_falta_argumento_obrigatorio_display
	jal escrever_barra_n_display    
    j main   
	 	     	            
escrever_falta_argumento_hora_display:
    jal escrever_barra_n_display    # pula para a função que irá imprimir uma quebra de linha no display
	la $s1, arg_hora  # Carrega o endereço arg_hora
	jal escrever_falta_argumento_obrigatorio_display
	jal escrever_barra_n_display    
    j main  
    
incrementar_s0:
	addi $s0, $s0, 1
    jr $ra	      
               	         

