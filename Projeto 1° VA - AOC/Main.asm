# Projeto 1 VA Arquitetura e Organizacao de Computadores - 2024.2
# Alunos: Heitor Leander Feitosa da silva
#         Joao victor Morais Barreto da silva
#         Mariane Elisa dos Santos Souza
#         Samuel Roberto de Carvalho Bezerra

.data

	# Constantes
.eqv	keyboard_status 0xFFFF0000  # endereco do status do teclado
.eqv	display_status  0xFFFF0008  # endereco do status do display
.eqv	keyboard_buffer 0xFFFF0004  # endereco do buffer do teclado
.eqv	display_buffer  0xFFFF000C  # endereco do buffer do display

	banner:  		.asciiz "MIPShelf-shell>>"
	comando: 		.space 100    # Espaco reservado para o comando digitado pelo usuario
	data_config_usuario:       .space 20    # Espaco reservado para a data do sistema configurada pelo usuario
	hora_config_usuario:       .space 20	# Espaco reservado para a hora do sistema configurado pelo usuario
	data_atual: 	           .space 20    # Espaco reservado para armazenar a data atual 
	hora_atual:                .space 20    # Espaco reservado para armazenar a data atual
	tempo_hora_configurada1:   .space 4     # Espaco reservado para armazenar o tempo em que o usuario configurou a hora no sistema
    tempo_hora_configurada2:   .space 4     # Espaco reservado para armazenar o tempo em que o usuario configurou a hora no sistema
	
	# Caracteres
	barra_n:   		.byte 10      # Valor em ASCII do caractere de quebra de linha '\n'
	espaco:			.byte 32      # Valor em ASCII do caractere de espaco ' '       
	aspas_duplas:   .byte 34      # Valor em AscII do caractere de aspas duplas ""
	virgula:		.byte 44      # Valor em AscII do caractere da virgula (',')
	dois_pontos:    .byte 58      # Valor em ASCII do caractere de dois pontos (':')
    barra:          .byte 47      # Valor em ASCII do caractere de barra ('/')
	
	# Livro:
	titulo:  	.space 30     # Espaco reservado para o titulo do livro
	autor:    	.space 30     # Espaco reservado para o nome do autor do livro
	ISBN:       .space 10     # Espaco reservado para o codigo de ISBN do livro
	quantidade: .space 5   	  # Espaco reservado para a quantidade de livros disponiveis:
	
	# Usuario:
	nome:   	.space 30     # Espaco reservado para o nome do usuario
	matricula:	.space 10     # Espaco reservado para o numero de matricula do usuario
	curso:      .space 15     # Espaco reservado para o curso do usuario
	
	# Emprestimo:
	matricula_usuario_ass: 	.space 10   # Espaco reservado para a matricula do usuario associado ao emprestimo
	ISBN_livro_ass:         .space 10   # Espaco reservado para o codigo de ISBN do livro associado ao emprestimo
	data_registro:  		.space 10   # Espaco reservado para a data em que foi registrado o emprestimo
	data_devolucao: 		.space 10   # Espaco reservado para a data de devolu�cao do emprestimo
	
	# Reposit�rios Tempor�rios
	repo_livro: .space 4500      # Espa�o reservado para a grava��o tempor�ria dos livros cadastrados
	repo_usuario: .space 4500    # Espa�o reservado para a grava��o tempor�ria dos usu�rios cadastrados
	repo_emprestimo: .space 4000 # Espa�o reservado para a grava��o tempor�ria dos empr�stimos cadastrados
	
	# Locais dos arquivos salvos
	local_arquivo_livros: .asciiz     "C:/repo_livros.txt"
	local_arquivo_usuario: .asciiz     "C:/repo_usuarios.txt"
	local_arquivo_emprestimo: .asciiz  "C:/repo_emprestimos.txt"	
	
	# Comandos:
	cmd_cadastrar_livro: 	.asciiz "cadastrar_livro"
	cmd_cadastrar_usuario:  .asciiz "cadastrar_usuario"
	cmd_listar_livro: 		.asciiz "listar_livro"
	cmd_reg_emprestimo:     .asciiz "registrar_emprestimo"
	cmd_gerar_relatorio:    .asciiz "gerar_relatorio"
	cmd_remover_livro:      .asciiz "remover_livro"
	cmd_remover_usuario: 	.asciiz "remover_usuario"
	cmd_salvar_dados: 	    .asciiz "salvar_dados"
	cmd_formatar_dados: 	.asciiz "formatar_dados"
	cmd_data_hora: 			.asciiz "data_hora"
	cmd_ajustar_data: 	    .asciiz "ajustar_data"
	
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
	
	# Mensagens de confirma��o:
	msgC_livro_cadastrado: 		.asciiz "Livro cadastrado"
	msgC_usuario_cadastrado: 	.asciiz "Usuario cadastrado"
	msgC_emprestimo_realizado: 	.asciiz "Empr�stimo realizado"
	msgC_livro_removido:        .asciiz "Livro removido"
	msgC_usuario_removido:      .asciiz "Usuario removido"
	msgC_com_sucesso: 			.asciiz " com sucesso!"
	
	# Mensagens de erro:
	msgE_comando_invalido:         			 .asciiz "Comando invalido!"
	msgE_acervo_vazio:						 .asciiz "O acervo esta vazio."
	msgE_esprestimo_indisponivel: 		     .asciiz "Livro indisponivel para o emprestimo."
	msgE_relatorio_indisponivel:  			 .asciiz "Nao ha dados disponiveis para gerar o relatorio."
	msgE_livro_nao_encontrado:     			 .asciiz "O livro informado nao foi encontrado no acervo."
	msgE_livro_esta_emprestado:    			 .asciiz "O livro nao pode ser removido por estar emprestado."
	msgE_usuario_nao_encontrado:    		 .asciiz "O usuario informado nao foi encontrado no acervo."
	msgE_usuario_tem_pendencias:    		 .asciiz "O usuario nao pode ser removido por ter devolucoes pendentes."
	msgE_parte1_falta_argumento_obrigatorio: .asciiz "O campo \"" 
	msgE_parte2_falta_argumento_obrigatorio: .asciiz "\" e obrigatorio, certifique de usa-lo para que a operacao seja realizada"

	string_data:     .asciiz "Data: "
    string_hora:     .asciiz "Hora: "
.text
.globl main

main:
	# Escrever aqui a funcao que le os dados do arquivo .txt 
	jal escrever_banner_display
	li $s7, 0 		# inicializa $s7 com 0
	jal esperar_input_teclado

	j main 
	        
esperar_display_carregar:
	li $t0, 0xFFFF0008   		   		  # Endereco do status do display
    lw $t0, 0($t0)        				  # Carrega o status do display diretamente em $t0
    beqz $t0, esperar_display_carregar    # Se status for 0, entra em loop
    
    jr $ra

escrever_string_display:
	# $t1: reg que possui o endereco da string a ser digitada no display
	
	# Aloca espaco no $sp para salvar o endereco de $ra
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    
    jal esperar_display_carregar 	# Pula para a funcao que espera o display carregar
    
    lw $ra, 0($sp) 			   		# resgata o $ra original do $sp
    addi $sp, $sp, 4		  		# devolve a pilha para a posicao original
    
    li $t0, 0xFFFF000C         		# Endereco do Transmiter data do display
	loop_string_display:
		lb $t2, 0($t1)   			# Carrega um caractere da string de $t1 para $t2
    	beqz $t2, fim    			# Se o caractere em $t2 for o caractere de fim de string, sai do loop
    	sw $t2, 0($t0)    			# Caso contrario, escreve o caractere no display
    	addi $t1, $t1, 1  			# Avanca para o proximo caractere
    	j loop_string_display       # Continua com loop
    
    fim:
    jr $ra

esperar_input_teclado:
	# $s7: reg que serve como um apontador para a proxima posicao do caractere a ser inserido em comando 
	
    li $t0, 0xFFFF0000   			 # Endereco do status do teclado
    lw $t0, 0($t0)        			 # Carrega o status do teclado diretamente em $t0
    beqz $t0, esperar_input_teclado  # Se status for 0, entra em loop
	
	li $t0, 0xFFFF0004       # Endereco do Receiver data do teclado
   	lw $t1, 0($t0)           # Carrega o caractere digitado em $t1

  	# O trecho seguinte armazena o caractere digitado no espaco reservado para comando
    la $s0, comando          # Carrega o endereco de comando em $s0
	li $t3, 0                # inicializa $t3 com 0
	
    loop_armazenar:
        lb $t2, 0($s0)       	 # Le o caractere atual do comando e armazena em $t2
        beq $s7, $t3, armazenar  # Se o caractere atual for nulo, armazena
        addi $s0, $s0, 1     	 # Caso contrario avanca para a proxima posicao
        addi $t3, $t3, 1         # Incrementa $t3
        j loop_armazenar	 	 # entra em loop

    armazenar:
        sb $t1, 0($s0)       # Salva o caractere digitado na posicao atual do comando
        
    addi $s7, $s7, 1        # Incrementa $s7 para a proxima posicao de insercao de caracteres em comando
    
    # Verifica se o caractere digitado e barra_n (\n)
	la $t2, barra_n                  # Carrega o endereco de barra_n
    lb $t2, 0($t2)                   # Carrega o valor de barra_n
    beq $t1, $t2, verificar_comando  # Se for barra_n, chama verificar_comando

    # Caso contrario, exibe o caractere no display
    jal escrever_caractere_digitado_display
    
    j esperar_input_teclado # entra em loop para esperar o proximo caractere
    
escrever_caractere_digitado_display:
    # Aloca espaco no $sp para salvar o endereco de $ra
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    
    jal esperar_display_carregar
    
    lw $ra, 0($sp) 		  # Resgata o $ra original do $sp
    addi $sp, $sp, 4      # Devolve a pilha para a posicao original
	
    li $t0, 0xFFFF000C    # Endereco do Receiver data do display
	sw $t1, 0($t0)        # Escreve o caractere no display

	jr $ra	
	
escrever_barra_n_display:
    # Aloca espaco no $sp para salvar o endereco de $ra
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    
    jal esperar_display_carregar
    
    lw $ra, 0($sp) 			   # Resgata o $ra original do $sp
    addi $sp, $sp, 4		   # Devolve a pilha para a posicao original

    la $t1, barra_n            # Carrega o endereco de barra_n
    lb $t1, 0($t1)             # Carrega o valor de barra_n diretamente em $t1

    li $t0, 0xFFFF000C         # Endereco do Transmitter data do display
    sw $t1, 0($t0)             # Escreve o caractere \n no display

    jr $ra
    
escrever_banner_display:
	la $t1, banner      # Carrega o endereco do inicio da string do banner
	
    # Aloca espaco no $sp para salvar o endereco de $ra
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    
    jal escrever_string_display
    
    lw $ra, 0($sp) 		#resgata o $ra original do $sp
    addi $sp, $sp, 4	#devolve a pilha para a posicao original

    jr $ra

comparar_strings:
	#	$s0: reg que possui o endere�o do comando digitado pelo usu�rio
	#	$s1: reg que possui o endere�o da string a ser comparada com o comando
	#	$s2: reg que possui a quantidade de caracteres que deve ser lida 
   
	comparador_loop:
		
		lb $t0, 0($s0)                          	# Carrega o caractere em $s0 em $t0
		lb $t1, 0($s1)                          	# Carrega o caractere em $s1 em $t1
		bne $t0, $t1, retorno_strings_diferentes    # se os caracteres s�o diferentes $v0 	
		addi $s0, $s0, 1                            # Incrementa $s0, para seguir com o pr�ximo caractere da string
		addi $s1, $s1, 1                            # Incrementa $s1, para seguir com o pr�ximo caractere da string
		subi $s2, $s2, 1							# Subtrai $s2, para verificar se a contagem terminou
		beqz $s2, retorno_strings_iguais       		# Se $s2 � igual a zero significa que a contagem terminou e eles s�o iguais
		j comparador_loop
		
	retorno_strings_iguais:
		li $v0, 1         # D� ao reg $v0 valor 1 para sinalizar como flag que as strings s�o iguais
		j fim_loop 		  # pula para o fim do loop 
	
	retorno_strings_diferentes:
		li $v0, 0  		  # D� ao reg $v0 o valor 0 para sinalizar como flag que as strings s�o diferentes

	fim_loop: 
		jr $ra 

str_concat:
    # $s0: registrador que carrega a primeira parte da concatena��o
    # $s1: registrador que carrega a segunda parte da concatena��o (a parte que ser� copiada)

    # Encontra o final da string em $s0
    acha_final_concat:
        lb $t0, 0($s0)         # Carrega o caractere atual de $s0
        beq $t0, $zero, copia_para_s0  # Se encontrar NULL (\0), fim da string
        addi $s0, $s0, 1       # Avan�a o ponteiro de $s0
        j acha_final_concat    # Continua procurando o final

    # Copia a string de $s1 para o final de $s0
    copia_para_s0:
        lb $t0, 0($s1)         # Carrega o caractere atual de $s1
        beq $t0, $zero, fim_concat  # Se encontrar NULL (\0), fim da string de origem
        sb $t0, 0($s0)         # Escreve o caractere de $s1 no local apontado por $s0
        addi $s0, $s0, 1       # Avan�a o ponteiro de $s0
        addi $s1, $s1, 1       # Avan�a o ponteiro de $s1
        j copia_para_s0        # Continua copiando

    # Finaliza a string concatenada
    fim_concat:
        sb $zero, 0($s0)       # Adiciona NULL (\0) ao final da string concatenada
        jr $ra                 # Retorna

clear_buffer:
    # $s1: Aponta para o in�cio do buffer a ser limpo

    li $t0, 0            # Carrega 0 em $t0 (valor para limpar)
    
	clear_loop:
    	lb $t1, 0($s1)       # Carrega o byte atual do buffer
    	beq $t1, $zero, end_clear  # Se encontrar NULL (\0), fim da string
    	sb $t0, 0($s1)       # Substitui o byte por 0
    	addi $s1, $s1, 1     # Avan�a o ponteiro de $s0
    	j clear_loop         # Continua limpando

	end_clear:
    	jr $ra               # Retorna
		
verificar_comando:
	jal escrever_barra_n_display    # Pula para a funcao que escreve o caractere de quebra de linha (\n) no display
    sb $zero, 0($s0)       			# Substitui o \n digitado pelo usuario pelo caractere nulo (\0)
    
  	jal verificar_cmd_cadastrar_livro
  	jal verificar_cmd_cadastrar_usuario
  	jal verificar_cmd_listar_livro
  	jal verificar_cmd_reg_emprestimo
	jal verificar_cmd_gerar_relatorio
  	jal verificar_cmd_remover_livro
	jal verificar_cmd_remover_usuario
  	jal verificar_cmd_salvar_dados
  	jal verificar_cmd_formatar_dados
  	jal verificar_cmd_data_hora
	jal verificar_ajustar_data
    
    # Se n�o foi digitado nenhum dos comandos 
    j escrever_comando_invalido_display

verificar_cmd_cadastrar_livro:
	# Aloca espaco no $sp para salvar o endereco de $ra
    addi $sp, $sp, -4
    sw $ra, 0($sp)
	
  	la $s1, cmd_cadastrar_livro     # Carrega o endereco de cmd_cadastrar_livro
  	la $s0, comando                 # Carrega o endereco de comando em S0
  	li $s2, 15                      # Define a quantidade de caracteres de comando que irao ser comparados
  	jal comparar_strings            # Pula para a funcao que ira comparar as strings
  	beq $v0, 1, cadastrar_livro     # se $v0 for 1, significa que o comando digitado foi o de cadastrar_livro 
  	
  	lw $ra, 0($sp) 		#resgata o $ra original do $sp
    addi $sp, $sp, 4	#devolve a pilha para a posicao original
    
  	jr $ra

verificar_cmd_cadastrar_usuario:
	# Aloca espaco no $sp para salvar o endereco de $ra
    addi $sp, $sp, -4
    sw $ra, 0($sp)
	
  	la $s1, cmd_cadastrar_usuario   # Carrega o endereco de cmd_cadastrar_usuario
  	la $s0, comando                 # Carrega o endereco de comando em S0
  	li $s2, 17                      # Define a quantidade de caracteres de comando que irao ser comparados
  	jal comparar_strings            # Pula para a funcao que ira comparar as strings
  	beq $v0, 1, cadastrar_usuario   # se $v0 for 1, significa que o comando digitado foi o de cadastrar_usuario
	
	lw $ra, 0($sp) 		#resgata o $ra original do $sp
    addi $sp, $sp, 4	#devolve a pilha para a posicao original
	
	jr $ra
	
verificar_cmd_listar_livro:
	# Aloca espaco no $sp para salvar o endereco de $ra
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    
  	la $s1, cmd_listar_livro        # Carrega o endereco de cmd_listar_livro
  	la $s0, comando                 # Carrega o endereco de comando em S0
  	li $s2, 12                      # Define a quantidade de caracteres de comando que irao ser comparados
  	jal comparar_strings            # Pula para a funcao que ira comparar as strings
  	beq $v0, 1, listar_livro        # se $v0 for 1, significa que o comando digitado foi o de listar_livro
  	
  	lw $ra, 0($sp) 		#resgata o $ra original do $sp
    addi $sp, $sp, 4	#devolve a pilha para a posicao original
    
  	jr $ra
  	
verificar_cmd_reg_emprestimo:
	# Aloca espaco no $sp para salvar o endereco de $ra
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    
  	la $s1, cmd_reg_emprestimo      # Carrega o endereco de cmd_reg_emprestimo
  	la $s0, comando                 # Carrega o endereco de comando em S0
  	li $s2, 20                      # Define a quantidade de caracteres de comando que irao ser comparados
  	jal comparar_strings            # Pula para a funcao que ira comparar as strings
  	beq $v0, 1, listar_livro        # se $v0 for 1, significa que o comando digitado foi o de reg_emprestimo
	
	lw $ra, 0($sp) 		#resgata o $ra original do $sp
    addi $sp, $sp, 4	#devolve a pilha para a posicao original
    
	jr $ra
	
verificar_cmd_gerar_relatorio:
	# Aloca espaco no $sp para salvar o endereco de $ra
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    
  	la $s1, cmd_gerar_relatorio     # Carrega o endereco de cmd_gerar_relatorio
  	la $s0, comando                 # Carrega o endereco de comando em S0
  	li $s2, 20                      # Define a quantidade de caracteres de comando que irao ser comparados
  	jal comparar_strings            # Pula para a funcao que ira comparar as strings
  	beq $v0, 1, gerar_relatorio     # se $v0 for 1, significa que o comando digitado foi o de gerar_relatorio
	
	lw $ra, 0($sp) 		#resgata o $ra original do $sp
    addi $sp, $sp, 4	#devolve a pilha para a posicao original
    
	jr $ra
	
verificar_cmd_remover_livro:
	# Aloca espaco no $sp para salvar o endereco de $ra
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    
  	la $s1, cmd_remover_livro       # Carrega o endereco de cmd_remover_livro
  	la $s0, comando                 # Carrega o endereco de comando em S0
  	li $s2, 13                      # Define a quantidade de caracteres de comando que irao ser comparados
  	jal comparar_strings            # Pula para a funcao que ira comparar as strings
  	beq $v0, 1, remover_livro       # se $v0 for 1, significa que o comando digitado foi o de remover_livro
  	
  	lw $ra, 0($sp) 		#resgata o $ra original do $sp
    addi $sp, $sp, 4	#devolve a pilha para a posicao original
    
  	jr $ra
  	
verificar_cmd_remover_usuario:
	# Aloca espaco no $sp para salvar o endereco de $ra
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    
  	la $s1, cmd_remover_usuario     # Carrega o endereco de cmd_remover_usuario
  	la $s0, comando                 # Carrega o endereco de comando em S0
  	li $s2, 15                      # Define a quantidade de caracteres de comando que irao ser comparados
  	jal comparar_strings            # Pula para a funcao que ira comparar as strings
  	beq $v0, 1, remover_usuario     # se $v0 for 1, significa que o comando digitado foi o de remover_usuario
	
	lw $ra, 0($sp) 		#resgata o $ra original do $sp
    addi $sp, $sp, 4	#devolve a pilha para a posicao original
    
	jr $ra

verificar_cmd_salvar_dados:
	# Aloca espaco no $sp para salvar o endereco de $ra
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    
  	la $s1, cmd_salvar_dados        # Carrega o endereco de cmd_savar_dados
    la $s0, comando                 # Carrega o endereco de comando em S0
  	li $s2, 12                      # Define a quantidade de caracteres de comando que irao ser comparados
  	jal comparar_strings            # Pula para a funcao que ira comparar as strings
  	beq $v0, 1, salvar_dados        # se $v0 for 1, significa que o comando digitado foi o de savar_dados
  	
  	lw $ra, 0($sp) 		#resgata o $ra original do $sp
    addi $sp, $sp, 4	#devolve a pilha para a posicao original
    
  	jr $ra
  	
verificar_cmd_formatar_dados:
	# Aloca espaco no $sp para salvar o endereco de $ra
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    
  	la $s1, cmd_formatar_dados      # Carrega o endereco de cmd_formatar_dados
    la $s0, comando                 # Carrega o endereco de comando em S0
  	li $s2, 14                      # Define a quantidade de caracteres de comando que irao ser comparados
  	jal comparar_strings            # Pula para a funcao que ira comparar as strings
  	beq $v0, 1, formatar_dados      # se $v0 for 1, significa que o comando digitado foi o de formatar_dados
  	
  	lw $ra, 0($sp) 		#resgata o $ra original do $sp
    addi $sp, $sp, 4	#devolve a pilha para a posicao original
    
	jr $ra
	
verificar_cmd_data_hora:
	# Aloca espaco no $sp para salvar o endereco de $ra
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    
  	la $s1, cmd_data_hora           # Carrega o endereco de cmd_data_hora
    la $s0, comando                 # Carrega o endereco de comando em S0
  	li $s2, 9                       # Define a quantidade de caracteres de comando que irao ser comparados
  	jal comparar_strings            # Pula para a funcao que ira comparar as strings
  	beq $v0, 1, data_hora           # se $v0 for 1, significa que o comando digitado foi o de data_hora
  	
  	lw $ra, 0($sp) 		#resgata o $ra original do $sp
    addi $sp, $sp, 4	#devolve a pilha para a posicao original
    
  	jr $ra
  	
verificar_ajustar_data:	
	# Aloca espaco no $sp para salvar o endereco de $ra
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    
  	la $s1, cmd_ajustar_data        # Carrega o endereco de ajustar_data
    la $s0, comando                 # Carrega o endereco de comando em S0
  	li $s2, 12                      # Define a quantidade de caracteres de comando que irao ser comparados
  	jal comparar_strings            # Pula para a funcao que ira comparar as strings
  	beq $v0, 1, data_hora           # se $v0 for 1, significa que o comando digitado foi o de ajustar_data
  	
  	lw $ra, 0($sp) 		#resgata o $ra original do $sp
    addi $sp, $sp, 4	#devolve a pilha para a posicao original
    
  	jr $ra
	
guardar_info_buffer:
	# $t1: cont�m qual o buffer a ser usado
	# $s0: cont�m o comando dado pelo usu�rio
	
	lb $t0, 0($s0)           # Carrega o pr�ximo caractere
	li $t2, 34 			   	 # Carrega aspas duplas
    bne $t0, $t2, escrever_comando_invalido_display 	# caso o pr�ximo caracter n�o for de aspas duplas, o comando � inv�lido
    addi $s0, $s0, 1

	# Copia os caracteres at� a segunda aspa dupla
	copy_loop:
    	lb $t0, 0($s0)            # Carrega o pr�ximo caractere
    	beqz $t0, end             # Se for nulo (fim da string), encerra
    	beq $t0, $t2, finalize    # Se for aspas duplas ('"'), finaliza a c�pia
    	sb $t0, 0($t1)            # Copia o caractere para o buffer do t�tulo
    	addi $s0, $s0, 1          # Avan�a para o pr�ximo caractere
    	addi $t1, $t1, 1          # Avan�a no buffer do t�tulo
    	j copy_loop

	# Finaliza o buffer adicionando a v�rgula
	finalize:
		addi $s0, $s0, 1 			#Passa das aspas
    	jr $ra
    end:
    	j escrever_comando_invalido_display 	# Caso haja um caracter nulo e n�o um de aspas duplas, o comando � inv�lido

cadastrar_livro:
	
	# Primeiro, verificamos se o argumento a seguir � o esperado
	la $s1, arg_titulo
	# $s0 j� tem o comando a ser passado
	addi $s0, $s0, 1 	# Passa um caractere para frente, por conta do espa�o entre os comandos
	li $s2, 8           # Define a quantidade de caracteres a ser avaliados
	jal comparar_strings
	beqz $v0, escrever_falta_argumento_titulo_display
	
	addi $s0, $s0, 1 	# Passa um caractere para frente, por conta do espa�o entre os comandos
	# Pega o que est� entre aspas e salva no buffer
	la $t1, titulo
	jal guardar_info_buffer
	# Colocar a v�rgula no fim do buffer
	la $t2, virgula          # Carrega o valor ASCII da v�rgula (',')
    sb $t2, 0($t1)           # Adiciona a v�rgula ao final do t�tulo
	
	# Verificamos se o argumento a seguir � v�lido
	la $s1, arg_autor
	# $s0 j� tem o comando a ser passado
	addi $s0, $s0, 1 	# Passa um caractere para frente, por conta do espa�o entre os comandos
	li $s2, 7
	jal comparar_strings
	beqz $v0, escrever_falta_argumento_autor_display
	
	addi $s0, $s0, 1 	# Passa um caractere para frente, por conta do espa�o entre os comandos
	# Pega o que est� entre aspas e salva no buffer
	la $t1, autor
	jal guardar_info_buffer
	la $t2, virgula          # Carrega o valor ASCII da v�rgula (',')
    sb $t2, 0($t1)           # Adiciona a v�rgula ao final do autor
	
	# Verificamos se o argumento a seguir � v�lido
	la $s1, arg_ISBN
	# $s0 j� tem o comando a ser passado
	addi $s0, $s0, 1 	# Passa um caractere para frente, por conta do espa�o entre os comandos
	li $s2, 6
	jal comparar_strings
	beqz $v0, escrever_falta_argumento_ISBN_display
	
	addi $s0, $s0, 1 	# Passa um caractere para frente, por conta do espa�o entre os comandos
	# Pega o que est� entre aspas e salva no buffer
	la $t1, ISBN
	jal guardar_info_buffer
	la $t2, virgula          # Carrega o valor ASCII da v�rgula (',')
    sb $t2, 0($t1)           # Adiciona a v�rgula ao final do ISBN
    
    # Verificamos se o argumento a seguir � v�lido
	la $s1, arg_quantidade
	# $s0 j� tem o comando a ser passado
	addi $s0, $s0, 1 	# Passa um caractere para frente, por conta do espa�o entre os comandos
	li $s2, 5
	jal comparar_strings
	beqz $v0, escrever_falta_argumento_quantidade_display
	
	addi $s0, $s0, 1 	# Passa um caractere para frente, por conta do espa�o entre os comandos
	# Pega o que est� entre aspas e salva no buffer
	la $t1, quantidade
	jal guardar_info_buffer
	la $t2, barra_n          # Carrega o valor ASCII de \n
    sb $t2, 0($t1)           # Adiciona ao final da quantidade
	
	# Agora vamos salvar no reposit�rio (buffer) de livros
	# Para isso, vamos concatenar todas as informa��es que obtivemos em uma �nica string e coloca-la no repo
	la $s0, repo_livro
	la $s1, titulo
	jal str_concat
	
	jal clear_buffer	# Limpa o buffer de titulo
	
	la $s1, autor
	jal str_concat
	
	jal clear_buffer	# Limpa o buffer de autor
	
	la $s1, ISBN
	jal str_concat
	
	jal clear_buffer	# Limpa o buffer de ISBN
	
	la $s1, quantidade
	jal str_concat
	
	jal clear_buffer	# Limpa o buffer de qtd
	
	# Teste para ver o que est� no reposit�rio
	la $t1, repo_livro
	jal escrever_string_display
	jal escrever_barra_n_display    # pula para a fun��o que ir� imprimir uma quebra de linha no display
	
	# Limpa o buffer de comando
	la $s1, comando
	jal clear_buffer
	
	la $t1, msgC_livro_cadastrado   # Carrega o endere�o de msgC_livro_cadastrado
	j escrever_com_sucesso_display

remover_livro:
	# Em constru��o
	
	# Limpa o buffer de comando
	la $s1, comando
	jal clear_buffer
	
	la $t1, msgC_livro_removido     # Carrega o endere�o de msgC_livro_removido
	j escrever_com_sucesso_display

listar_livro:
	# Em constru��o	
	
	# Limpa o buffer de comando
	la $s1, comando
	jal clear_buffer
	
	j main

cadastrar_usuario:
	# Em constru��o
	
	# Limpa o buffer de comando
	la $s1, comando
	jal clear_buffer
	
	
	la $t1, msgC_usuario_cadastrado # Carrega o endere�o de msgC_usuario_cadastrado 
	j escrever_com_sucesso_display
	
remover_usuario:
	# Em constru��o
	
	# Limpa o buffer de comando
	la $s1, comando
	jal clear_buffer
	
	la $t1, msgC_usuario_removido   # Carrega o endere�o de msgC_usuario_removido
	j escrever_com_sucesso_display
	
registrar_emprestimo:
	# Em constru��o
	
	# Limpa o buffer de comando
	la $s1, comando
	jal clear_buffer
	
	la $t1, msgC_emprestimo_realizado  # Carrega o endere�o de msgC_emprestimo_realizado
	j escrever_com_sucesso_display

gerar_relatorio:
	# Em constru��o
	
	# Limpa o buffer de comando
	la $s1, comando
	jal clear_buffer
	
	j main
repositorio_len:	

	lb $t4, ($t3) # carrega o byte de t3
	addi $t3, $t3, 1 
	addi $t2, $t2, 1
	bnez $t4, repositorio_len # se t4 é diferente de 0 recomeça a função
	subi $t2, $t2, 1 # subtrai 1 de t2 no final da função
	jr $ra #volta para ra
	
salvar_dados:
	# Agr aqui tu faz o L.
#$t0  caminho arquivo de destino
#$t1  endereço do repositiorio
#$t2  usado para contar o tamnho do repositorio, não é necessário informar valor
#$t3  usado na funcao de repositorio_len
#$t4  usado na funcao de repositorio_len
#$s0  usado para salvar descritor
#$s1  usado para armazenar $ra
	li $t2, 0 # inicializa t2 com 0


	li $v0, 13 # abre o arquivo no modo leitura
	move $a0, $t0 # move nome do arquivo output em a0
	li $a1, 1 # mode escrita
	li $a2, 0 # valor padrão
	syscall

	move $s0, $v0 # salva descritor em s0
	move $s1, $ra # salvar o valor atual de ra em s1
	move $t3, $t1 # salva o endereço de t1 em t3
	move $s1, $ra # salva o valor de $ra em $s1
	jal repositorio_len # conta o tamanho do repositorio e salva em t2
	move $ra, $s1 # retorna o valor de $ra, $s1 esta livre

	li $v0, 15 # syscall para escrita
	move $a0, $s0 # move descritor para a0
	move $a1, $t1 # move endereço do repositorio para a1
	move $a2, $t2 # move tamanho do repositorio para a2
	syscall # chama syscall de escrita
	
	
	# Limpa o buffer de comando
	la $s1, comando
	jal clear_buffer
	
	j main
	
formatar_dados:
	# Do your jump, mari
	
	# Limpa o buffer de comando
	la $s1, comando
	jal clear_buffer
	
	j main

data_hora:
    la $t0, data_config_usuario   					# Carrega o endereco de data_config_usuario
    lb $t1, 0($t0)          						# Carrega carrega o 1� byte 
    beqz $t1, gerar_e_imprimir_data_hora_atual  	# Se o 1� byte for 0, pula para a funcao que vai imprimir a data e hora atual
    
    # Caso contr�rio, ent�o o usu�rio armazenou a data e hora da configuradas por ele
    jal imprimir_data_hora_usuario
	
	j main
	
gerar_e_imprimir_data_hora_atual:
	jal gerar_data_atual  # Funcao que armazena o ano no $s0, o m�s no $s1 e o dia no $s2

    move $t0, $s0  # Copia o ano para $t0
    move $t1, $s1  # Copia o mes para $t1
    move $t2, $s2  # Copia o dia para $t2
    
	la $t6, data_atual    # Carrega o endereco de data_atual 

	li $t5, 10            # inicializa $t5 com 10
	
	# Atualiza o $ra para que caso, a condicao abaixo seja verdadeira o fluxo do c�digo
	# por meio do jr $ra do inserir_zero retorne volte para a linha:  move $t7, $t2 (6 linhas abaixo)                    
	addi $ra, $ra, 12
	
	# Verifica se o dia eh menor que 10, se for, pula para a funcao que coloca o 0 primeiro em data_sistema
	blt $t2, $t5, inserir_zero
	
	move $t7, $t2                    # Copia o valor de $t2 em $t7  (o dia)
    jal  converter_int_para_string   # Pula para a funcao que vai converter o inteiro para string e inserir em data_atual 
	
	addi $t6, $t6, 1        # Avanca para a proxima posicao
	la $t4, barra           # Carrega o endereco do caractere de barra
	lb $t4, 0($t4)          # Carrega o caractere de barra em $t4
    sb $t4, 0($t6)         	# Insere o caractere de barra em data_atual
	addi $t6, $t6, 1        # Avanca para a proxima posicao
	
	li $t5, 10              # inicializa $t5 com 10
	
	# Atualiza o $ra para que caso, a condicao abaixo seja verdadeira o fluxo do c�digo
	# por meio do jr $ra do inserir_zero retorne volte para a linha:  move $t7, $t1 (7 linhas abaixo)                    
	addi $ra, $ra, 40 
	
    # Verifica se o m�s � menor que 10 e se for, pula para colocar um zero na frente
    blt $t1, $t5, inserir_zero
    move $t7, $t1                    # Copia o valor de $t1 em $t7 (O mes) 
    jal  converter_int_para_string   # Pula para a funcao que vai converter o inteiro para string e inserir em data_atual 
    
    addi $t6, $t6, 1        # Avanca para a proxima posicao
    la $t4, barra           # Carrega o endereco do caractere de barra
	lb $t4, 0($t4)          # Carrega o caractere de barra em $t4
    sb $t4, 0($t6)         	# Insere o caractere de barra em data_atual
    addi $t6, $t6, 1        # Avanca para a proxima posicao
    
	sb $t4, 0($t6)        			 # Insere o caractere de barra em data_sistema
	move $t7, $t0                    # Copia o valor de $t2 em $t7 (O ano) 
    jal  converter_int_para_string   # Pula para a funcao que vai converter o inteiro para string e inserir em data_atual 
	
	la $t1, string_data
	jal escrever_string_display   # Escreve a string "Data: " no display
	
	la $t1, data_atual				
	jal escrever_string_display   # Escreve a data  no display
	jal escrever_barra_n_display  # Causa uma quebra de linha no display
	
	jal gerar_hora_atual  # Funcao que armazena a hora no $s0 e o minuto no $s1 
	
	move $t0, $s0 		  # Copia a hora para $t0
    move $t1, $s1 		  # Copia o minuto para $t1
	
	la $t6, hora_atual    # Carrega o endereco de hora_Atual
	li $t5, 10            # inicializa $t5 com 10
	
	# Atualiza o $ra para que caso, a condicao abaixo seja verdadeira o fluxo do c�digo
	# por meio do jr $ra do inserir_zero retorne volte para a linha:  move $t7, $t0 (5 linhas abaixo)                    
	addi $ra, $ra, 32
	
	# Verifica se a hora eh menor que 10, se for, pula para a funcao que coloca o 0 primeiro em data_sistema
	blt $t0, $t5, inserir_zero       
	move $t7, $t0                    # Copia o valor de $t1 em $t7 (O mes) 
    jal  converter_int_para_string   # Pula para a funcao que vai converter o inteiro para string e inserir em hora_atual 
	
	addi $t6, $t6, 1        # Avanca para a proxima posicao
    la $t4, dois_pontos     # Carrega o endereco do caractere de barra
	lb $t4, 0($t4)          # Carrega o caractere de barra em $t4
    sb $t4, 0($t6)         	# Insere o caractere de barra em data_atual
    addi $t6, $t6, 1        # Avanca para a proxima posicao
	
	li $t5, 10            # inicializa $t5 com 10
	
	# Atualiza o $ra para que caso, a condicao abaixo seja verdadeira o fluxo do c�digo
	# por meio do jr $ra do inserir_zero retorne volte para a linha:  move $t7, $t1 (4 linhas abaixo)                    
	addi $ra, $ra, 40
	
	blt $t1, $t5, inserir_zero	  # Verifica se o minuto eh menor que 10, se for, pula para a funcao que coloca o 0 primeiro em data_sistema
	move $t7, $t1                     # Copia o valor de $t1 em $t7 (O mes) 
    jal  converter_int_para_string    # Pula para a funcao que vai converter o inteiro para string e inserir em hora_atual 
	
	la $t1, string_hora
	jal escrever_string_display   # Escreve a string "Hora: " no display
	
	la $t1, hora_atual				
	jal escrever_string_display   # Escreve a hora  no display
	jal escrever_barra_n_display  # Causa uma quebra de linha no display
	
	j main

inserir_zero:
	# $t6: reg que possui o endere�o da data_atual onde o 0 ser� inserido
	
	li $t9, 0           # Carrega o valor de 0 em $t8
	addi $t9, $t9, 48   # Converte o valor 0 para o caractere ASCII '0'
	sb $t9, 0($t6)      # Insere o 0 na posicao em data_sistema
	addi $t6, $t6, 1    # Avanca para a proxima posicao
	
	jr $ra
	
converter_int_para_string:
	# $t6: reg que possui espa�o de memoria que ir� ser inserida a string
	# $t7: reg que possui o inteiro a ser convertido para string 
	
    li $t2, 10  # Carrega o valor 10 em t1 
    li $t3, 0   # Carrega $t3 com 0 (reg que servir� como contador de d�gitos do inteiro)
    
    loop_string:
        div $t7, $t2         		    # Opera $t2 / $t1
        mflo $t4 						# Move o quociente para $t4 
        mfhi $t5 						# Move o resto para $t5 
        addi $t5, $t5, 48   			# Converte o resto para caractere
    	addi $sp, $sp, -1  			    # Aloca espaco no $sp para inserir o caractere
    	sb $t5, 0($sp)                  # insere o caractere no sp
    	addi $t3, $t3, 1                # Incrementa $t3 
        move $t7, $t4	    			# Atualiza o $t4 com o quociente
        bne $t7, $zero, loop_string 	# Entra em loop at� que o inteiro seja 0
        
     loop_inserir_string_t0:
     	lb $t2, 0($sp)                   # Carrega o caractere do topo da pilha
     	sb $t2, 0($t6)                   # Armazena o caractere em $t0
     	addi $sp, $sp, 1                 # Incrementa o ponteiro do $sp voltando 1
     	subi $t3, $t3, 1                 # Decrementa $t3
     	beqz $t3, fim_loop_inserir       # Se $t3 for 0, quer dizer que todos os caracteres foram inseridos em $t0
     	addi $t6, $t6, 1                 # Caso contr�rio, incrementa $t6, para a insercao do proximo caractere
     	j loop_inserir_string_t0         # Entra em loop
     	
     fim_loop_inserir:
    	jr $ra
	
gerar_data_atual:
    li $v0, 30           # Syscall 30 para obter o tempo do sistema
    syscall
    
    move $t0, $a0        # Move a parte menos significativa dos milissegundos para $t0
    move $t1, $a1        # Move a parte mais significativa dos milissegundos para $t1

    # Conversao da parte menos significativa dos milissegundos para minutos
    li $t2, 60000      	 # Carrega em $t2 a quantidade de milissegundos em 1 minuto
    div $t0, $t2         # Opera $t0 / 60000 (parte baixa para horas) 
    mflo $t0             # Move para $t0 as horas decorridas da menos significativa
	
    # Conversao da parte mais significativa de milissegundos para horas
    # A conversao eh feita com base na seguinte formula: $t1 * 2^32 / 60000
    li $t2, 71582        # Carrega 71582 em $t2 que eh o resultado aproximado (2^32) / 60000
    mul $t1, $t1, $t2    # Multiplica 71582 com $t1 para obter as minutos decorridos com a parte mais significativa
    
    # Soma $t0 (quantidade de minutos decorridos da parte menos significativa)
    # com $t1 (quantidade de minutos decorridos da parte mais significativa)
    # para obter a quantidade total de minutos decorridos de 01/01/1970 pra ca
    add $t0, $t0, $t1
    
    # O trecho abaixo soma o total de minutos com 138, isso porque a multiplica��o de 71582 * $t1
    # utilizou um valor aproximado, desconsiderando os seis d�gitos depois da virgula, e a ausencia
    # desses valores causa um atraso de 138 minutos para que a data seja atualizada, por isso o 
    # trecho abaixo corrige esse tempo de atraso 
    addi $t0, $t0, 138

    # Conversao do total de horas decorridas para dias
    li $t1, 1440         # Inicializa t7 com 24 (quantidade de minutos em um dia) 
    div $t0, $t1         # opera $t0 / $t1 para obter a quantidade total de dias decorridos
    mflo $t0             # Armazena em $t0 a quantidade total de dias decorridos
	
    # Calculo dos anos decorridos (considerando anos bissextos)
    li $s0, 1970         	# Inicializa $s0 com 1970 (a qual vai ser contantemente incrementado)
	
	ano_loop:
    li $t1, 365          	# Inicializa $t1 com 365 (quantidade de dias em um ano n�o bissexto)
    li $t2, 4            	# Inicializa com $t6 com 4
    rem $t3, $s0, $t2    	# Armazena o resto da divis�o de $s0 com $t2
    beqz $t3, ano_bissexto  # Se resto de $t3 for 0, o ano e bissexto
    j verificar_dias_restantes_ano

	ano_bissexto:
    	addi $t1, $t1, 1     # Incrementa $t7 com 1 para dizer que o ano em $s0 eh um ano que possui 366 dias
    	
	verificar_dias_restantes_ano:
		blt $t0, $t1, calcular_mes      # Se $t8 < $t7 pula para a funcao que calcula o mes
    	sub $t0, $t0, $t1  				# Remove os dias do ano de $s0 do total de dias decorridos
    	addi $s0, $s0, 1                # Incrementa o ano
   		j ano_loop
   		
   	calcular_mes:
   		li $s1, 1       	# Inicializa $s1 com 1 (reg que vai conter o m�s do ano)
   		addi $t0, $t0, 1  	# incrementando $t0 para corrigir a diferen�a de 1 dia menos que tava sendo gerada antes dessa linha de c�digo existir
   		
   		mes_loop:
   			li $t1, 30
   			beq $s1, 1, mes_com_31_dias  			# Se o mes em $s1 for 1, pula para a funcao que ajusta pra 31 dias       
   			beq $s1, 2, verificar_dias_fevereiro    # Se o mes em $s1 for 2, pula para a funcao que verifica a quantidade de dias
   			beq $s1, 3, mes_com_31_dias             # Se o mes em $s1 for 3, pula para a funcao que ajusta pra 31 dias
   			beq $s1, 5, mes_com_31_dias             # Se o mes em $s1 for 5, pula para a funcao que ajusta pra 31 dias
   			beq $s1, 7, mes_com_31_dias             # Se o mes em $s1 for 7, pula para a funcao que ajusta pra 31 dias
   			beq $s1, 8, mes_com_31_dias             # Se o mes em $s1 for 8, pula para a funcao que ajusta pra 31 dias
   			beq $s1, 10, mes_com_31_dias            # Se o mes em $s1 for 10, pula para a funcao que ajusta pra 31 dias
   			j verificar_dias_restantes_mes    
   			    
   		mes_com_31_dias:
   			addi $t1, $t1, 1  # Incrementa $t0 com 1 para indicar que o m�s em $s1 eh um m�s de 31 dias
   			j verificar_dias_restantes_mes
   		
   		mes_com_29_dias:
   			subi $t1, $t1, 1   # Decrementa $t0 com 1 para indicar que o m�s em $s1 eh um m�s de 29 dias
   			j verificar_dias_restantes_mes
   			
   		mes_com_28_dias:
   			subi $t1, $t1, 2   # Decrementa $t0 com 2 para indicar que o m�s em $s1 eh um m�s de 28 dias    
			j verificar_dias_restantes_mes
			
		verificar_dias_fevereiro:
			li $t2, 4 
			rem $t3, $s0, $t2   	   # Armazena o resto da divis�o de $s0 com $t1
    		beqz $t3, mes_com_29_dias  # Se resto de $t2 for 0, significa que o ano eh bissexto 
    		j mes_com_28_dias          # Se o ano nao eh bissexto pula para a funcao que ajusta a qtd de dias para 28
    		
		verificar_dias_restantes_mes:
			blt $t0, $t1, dia_do_mes      # Se $t0 < $t1, pula para a funcao que o dia do mes
    		sub $t0, $t0, $t1  			  # Remove os dias do mes de $s1 do total de dias decorridos
    		addi $s1, $s1, 1              # Incrementa o mes
   			j mes_loop
   			
   	dia_do_mes:
   		move $s2, $t0           # Move os dias que restaram para $s2
   		jr $ra

gerar_hora_atual:
    li $v0, 30           # Syscall 30 para obter o tempo do sistema
    syscall
    
    move $t0, $a0        # Move a parte menos significativa dos milissegundos para $t0
    move $t1, $a1        # Move a parte mais significativa dos milissegundos para $t1

    # Conversao da parte menos significativa dos milissegundos para minutos
    li $t2, 60000      	 # Carrega em $t2 a quantidade de milissegundos em 1 minuto
    div $t0, $t2         # Opera $t0 / 60000 (parte baixa para horas) 
    mflo $t0             # Move para $t0 as horas decorridas da menos significativa
	
    # Conversao da parte mais significativa de milissegundos para horas
    # A conversao eh feita com base na seguinte formula: $t1 * 2^32 / 60000
    li $t2, 71582        # Carrega 71582 em $t2 que eh o resultado aproximado (2^32) / 60000
    mul $t1, $t1, $t2    # Multiplica 71582 com $t1 para obter as minutos decorridos com a parte mais significativa
    
    # Soma $t0 (quantidade de minutos decorridos da parte menos significativa)
    # com $t1 (quantidade de minutos decorridos da parte mais significativa)
    # para obter a quantidade total de minutos decorridos de 01/01/1970 pra ca
    add $t0, $t0, $t1
    
    # O trecho abaixo soma o total de minutos com 138, isso porque a multiplica��o de 71582 * $t1
    # utilizou um valor aproximado, desconsiderando os seis d�gitos depois da virgula, e a ausencia
    # desses valores causa um atraso de 138 minutos para que a data seja atualizada, por isso o 
    # trecho abaixo corrige esse tempo de atraso 
    addi $t0, $t0, 138

    # Obten��o do total de mintos do dia atual
    li $t1, 1440         # Inicializa t1 com 24 (quantidade de minutos em um dia) 
    div $t0, $t1         # opera $t0 / $t1 para obter a quantidade total de dias decorridos
	mfhi $t0
	
    # Separar minutos em horas e minutos
    li $t1, 60             # Minutos por hora
    div $t0, $t1           # Divide para obter horas e resto
    mflo $s0               # $s0 = horas do dia
    mfhi $s1               # $s1 = minutos restantes

    jr $ra                 # Retorna ao chamador

imprimir_data_hora_usuario:
	# Em construcao
	
	j main
	
	
ajustar_data:

	# Em Construcao

	# Fun��o �nica para mensagens de confirma��o
escrever_com_sucesso_display:
	# $t1: reg possui a primeira parte da mensagem de confirma��o

	jal escrever_string_display  # Pula para a fun��o gen�rica que ir� imprimir a string armazenada em $t1
	la $t1, msgC_com_sucesso  # Carrega o ende�o de msgC_com_sucesso
	jal escrever_string_display  # Pula para a fun��o gen�rica que ir� imprimir a string armazenada em $t1
	jal escrever_barra_n_display    # pula para a fun��o que ir� imprimir uma quebra de linha no display
	
	j main

escrever_comando_invalido_display:
	la $t1, msgE_comando_invalido   # Carrega o endereco de msgE_comando_invalido
    jal escrever_string_display     # Pula para a funcao generica que ira imprimir a string armazenada em $t1
    jal escrever_barra_n_display    # pula para a funcao que ira imprimir uma quebra de linha no display   
    j main   
	
escrever_acervo_vazio_display:
    la $t1, msgE_acervo_vazio       # Carrega o endereco de msgE_acervo_vazio
    jal escrever_string_display     # Pula para a funcao generica que ira imprimir a string armazenada em $t1
    jal escrever_barra_n_display    # pula para a funcao que ira imprimir uma quebra de linha no display
    j main   

escrever_esprestimo_indisponivel_display:
    la $t1, msgE_esprestimo_indisponivel   # Carrega o endereco de msgE_comando_invalido
    jal escrever_string_display            # Pula para a funcao generica que ira imprimir a string armazenada em $t1
    jal escrever_barra_n_display           # pula para a funcao que ira imprimir uma quebra de linha no display
    j main   

escrever_relatorio_indisponivel_display:
    la $t1, msgE_relatorio_indisponivel   # Carrega o endereco de msgE_relatorio_indisponivel
    jal escrever_string_display           # Pula para a funcao generica que ira imprimir a string armazenada em $t1
    jal escrever_barra_n_display    	  # pula para a funcao que ira imprimir uma quebra de linha no display
    j main   
    
escrever_livro_nao_encontrado_display:
    la $t1, msgE_livro_nao_encontrado   # Carrega o endereco de msgE_livro_nao_encontrado 
    jal escrever_string_display         # Pula para a funcao generica que ira imprimir a string armazenada em $t1
    jal escrever_barra_n_display    	# pula para a funcao que ira imprimir uma quebra de linha no display
    j main   

escrever_livro_esta_emprestado_display:
    la $t1, msgE_livro_esta_emprestado   # Carrega o endereco de msgE_livro_esta_emprestado
    jal escrever_string_display          # Pula para a funcao generica que ira imprimir a string armazenada em $t1
    jal escrever_barra_n_display    	 # pula para a funcao que ira imprimir uma quebra de linha no display
    j main   
    
escrever_usuario_nao_encontrado_display:
    la $t1, msgE_usuario_nao_encontrado   # Carrega o endereco de msgE_usuario_nao_encontrado
    jal escrever_string_display           # Pula para a funcao generica que ira imprimir a string armazenada em $t1
    jal escrever_barra_n_display    	  # pula para a funcao que ira imprimir uma quebra de linha no display
    j main   
    
escrever_usuario_tem_pendencias_display:
    la $t1, msgE_usuario_tem_pendencias   # Carrega o endereco de msgE_usuario_tem_pendencias
    jal escrever_string_display           # Pula para a funcao generica que ira imprimir a string armazenada em $t1
    jal escrever_barra_n_display    	  # pula para a funcao que ira imprimir uma quebra de linha no display
    j main   

# Funcao generica que imprime a mensagem de falta de qualquer argumento no display
escrever_falta_argumento_obrigatorio_display:
	# $s1: reg que possui o endereco do argumento faltante
	
	# Aloca espaco no $sp para salvar o endereco de $ra
    addi $sp, $sp, -4
    sw $ra, 0($sp)
	
	la $t1, msgE_parte1_falta_argumento_obrigatorio  # Carrega o endereco de msgE_parte1_falta_argumento_obrigatorio
	jal escrever_string_display  # Pula para a funcao generica que ira imprimir a string armazenada em $t1
	
	addi $t1, $s1, 0   # soma $s1 com 0 e armazena em t1 (em outras palavras copia o endereco de $s1 pra $t1)
	jal escrever_string_display   
	
	la $t1, msgE_parte2_falta_argumento_obrigatorio  # Carrega o endereco de msgE_parte2_falta_argumento_obrigatorio
	jal escrever_string_display     
	
	lw $ra, 0($sp) 		#resgata o $ra original do $sp
    addi $sp, $sp, 4	#devolve a pilha para a posicao original

    jr $ra                 
	  
escrever_falta_argumento_titulo_display:
	la $s1, arg_titulo  # Carrega o endereco arg_titulo
	jal escrever_falta_argumento_obrigatorio_display
    jal escrever_barra_n_display    	  # pula para a funcao que ira imprimir uma quebra de linha no display
    j main   
	
escrever_falta_argumento_autor_display:
	la $s1, arg_autor  # Carrega o endereco arg_autor
	jal escrever_falta_argumento_obrigatorio_display
    jal escrever_barra_n_display    	  # pula para a funcao que ira imprimir uma quebra de linha no display
    j main   
	
escrever_falta_argumento_ISBN_display:
	la $s1, arg_ISBN  # Carrega o endereco arg_ISBN
	jal escrever_falta_argumento_obrigatorio_display
    jal escrever_barra_n_display    # pula para a funcao que ira imprimir uma quebra de linha no display
    j main   
	
escrever_falta_argumento_quantidade_display:
	la $s1, arg_quantidade  # Carrega o endereco arg_quantidade 
	jal escrever_falta_argumento_obrigatorio_display
    jal escrever_barra_n_display    # pula para a funcao que ira imprimir uma quebra de linha no display
    j main   
	
escrever_falta_argumento_nome_display:
	la $s1, arg_nome  # Carrega o endereco arg_nome
	jal escrever_falta_argumento_obrigatorio_display
    jal escrever_barra_n_display    # pula para a funcao que ira imprimir uma quebra de linha no display
    j main   
	
escrever_falta_argumento_matricula_display:
	la $s1, arg_matricula  # Carrega o endereco arg_matricula
	jal escrever_falta_argumento_obrigatorio_display
    jal escrever_barra_n_display    # pula para a funcao que ira imprimir uma quebra de linha no display
    j main   
	
escrever_falta_argumento_curso_display:
	la $s1, arg_curso  # Carrega o endereco arg_curso
	jal escrever_falta_argumento_obrigatorio_display
    jal escrever_barra_n_display    # pula para a funcao que ira imprimir uma quebra de linha no display
    j main   
	
escrever_falta_argumento_devolucao_display:
	la $s1, arg_devolucao  # Carrega o endereco arg_devolucao
	jal escrever_falta_argumento_obrigatorio_display
    jal escrever_barra_n_display    # pula para a funcao que ira imprimir uma quebra de linha no display
    j main  
    
escrever_falta_argumento_data_display:
	la $s1, arg_data  # Carrega o endereco arg_data
	jal escrever_falta_argumento_obrigatorio_display
    jal escrever_barra_n_display    # pula para a funcao que ira imprimir uma quebra de linha no display
    j main   
	 	     	            
escrever_falta_argumento_hora_display:
	la $s1, arg_hora  # Carrega o endereco arg_hora
	jal escrever_falta_argumento_obrigatorio_display
    jal escrever_barra_n_display    # pula para a funcao que ira imprimir uma quebra de linha no display
    j main  
