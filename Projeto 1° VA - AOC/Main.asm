# Projeto 1 VA Arquitetura e Organiza��o de Computadores - 2024.2
# Alunos: Heitor Leander Feitosa da silva
#         Jo�o victor Morais Barreto da silva
#         Mariane Elisa dos Santos Souza
#         Samuel Roberto de Carvalho Bezerra

.data

# Constantes
	keyboard_status:	.word 0xFFFF0000 # endereço do status do teclado
	display_status:		.word 0xFFFF0008 # endereço do status do display
	keyboard_buffer:	.word 0xFFFF0004 # endereço do buffer do teclado
	display_buffer:		.word 0xFFFF000C # endereço do buffer do display

	
	banner:  		.asciiz "MIPShelf-shell>>"
	comando: 		.space 100    # Espa�o reservado para o comando digitado pelo usu�rio
	data_sistema:   .space 5  	  # Espa�o reservado para a data do sistema
	hora_sistema: 	.space 5 	  # Espa�o reservado para a hora do sistema
	
	# Caracteres
	barra_n:   		.byte 10      # Valor em ASCII do caractere de quebra de linha '\n'
	espaco:			.byte 32      # Valor em ASCII do caractere de espa�o ' '       
	aspas_duplas:   .byte 34      # Valor em AscII do caractere de aspas duplas ""
	
	# Livro:
	titulo:  	.space 30     # Espa�o reservado para o t�tulo do livro
	autor:    	.space 30     # Espa�o reservado para o nome do autor do livro
	ISBN:       .space 10     # Espa�o reservado para o c�digo de ISBN do livro
	quantidade: .space 5   	  # Espa�o reservado para a quantidade de livros dispon�veis:
	
	# Usu�rio:
	nome:   	.space 30     # Espa�o reservado para o nome do usu�rio
	matricula:	.space 10     # Espa�o reservado para o n�mero de matr�cula do usu�rio
	curso:      .space 15     # Espa�o reservado para o curso do usu�rio
	
	# Empr�stimo:
	matricula_usuario_ass: 	.space 10   # Espa�o reservado para a matr�cula do usu�rio associado ao empr�stimo
	ISBN_livro_ass:         .space 10   # Espa�o reservado para o c�digo de ISBN do livro associado ao empr�stimo
	data_registro:  		.space 10   # Espa�o reservado para a data em que foi registrado o empr�stimo
	data_devolucao: 		.space 10   # Espa�o reservado para a data de devolu��o do empr�stimo
	
	# Comandos:
	cmd_cadastrar_livro: 	.asciiz "cadastrar_livro"
	cmd_cadastrar_usuario:  .asciiz "cadastrar_usuario"
	cmd_listar_livro: 		.asciiz "listar_livro"
	cmd_reg_emprestimo:     .asciiz "registrar_emprestimo"
	cmd_gerar_relatorio:    .asciiz "gerar_relatorio"
	cmd_remover_livro:      .asciiz "remover_livro"
	cmd_remover_usuario: 	.asciiz "remover_usuario"
	cmd_savar_dados: 	    .asciiz "salvar_dados"
	cmd_formatar_dados: 	.asciiz "formatar_dados"
	cmd_data_hora: 			.asciiz "data_hora"
	
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
	msgC_livro_cadastrado: 		.asciiz "Livro cadastrado com sucesso!"
	msgC_usuario_cadastrado: 	.asciiz "Usuario cadastrado com sucesso!"
	msgC_emprestimo_realizado: 	.asciiz "Empr�stimo realizado com sucesso!"
	msgC_livro_removido:        .asciiz "Livro removido com sucesso!"
	msgC_usuario_removido:      .asciiz "usuario removido com sucesso!"
	
	# Mensagens de erro:
	msgE_comando_invalido:         			 .asciiz "Comando inv�lido!"
	msgE_acervo_vazio:						 .asciiz "O acervo est� vazio."
	msgE_esprestimo_indisponivel: 		     .asciiz "Livro indispon�vel para o empr�stimo."
	msgE_relatorio_indisponivel:  			 .asciiz "N�o h� dados dispon�veis para gerar o relat�rio."
	msgE_livro_nao_encontrado:     			 .asciiz "O livro informado n�o foi encontrado no acervo."
	msgE_livro_esta_emprestado:    			 .asciiz "O livro n�o pode ser removido por estar emprestado."
	msgE_usuario_nao_encontrado:    		 .asciiz "O usu�rio informado n�o foi encontrado no acervo."
	msgE_usuario_tem_pendencias:    		 .asciiz "O usu�rio n�o pode ser removido por ter devolu��es pend�ntes."
	msgE_parte1_falta_argumento_obrigatorio: .asciiz "O campo \"" 
	msgE_parte2_falta_argumento_obrigatorio: .asciiz "\" � obrigat�rio, certifique de us�-lo para que a opera��o seja realizada"
	
.text
.globl main

main:
	# Escrever aqui a fun��o que l� os dados do arquivo .txt 
	jal escrever_banner_display
	li $s7, 0 		# inicializa $s7 com 0
	jal esperar_input_teclado

	j main 
	        
esperar_display_carregar:
	li $t0, 0xFFFF0008   		   		  # Endere�o do status do display
    lw $t0, 0($t0)        				  # Carrega o status do display diretamente em $t0
    beqz $t0, esperar_display_carregar    # Se status for 0, entra em loop
    
    jr $ra

escrever_string_display:
	# $t1: reg que possui o endere�o da string a ser digitada no display
	
	# Aloca espa�o no $sp para salvar o endere�o de $ra
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    
    jal esperar_display_carregar 	# Pula para a fun��o que espera o display carregar
    
    lw $ra, 0($sp) 			   		#resgata o $ra original do $sp
    addi $sp, $sp, 4		  		#devolve a pilha para a posicao original
    
    li $t0, 0xFFFF000C         		# Endere�o do Transmiter data do display
	loop_string_display:
		lb $t2, 0($t1)   			# Carrega um caractere da string de $t1 para $t2
    	beqz $t2, fim    			# Se o caractere em $t2 for o caractere de fim de string, sai do loop
    	sw $t2, 0($t0)    			# Caso contr�rio, escreve o caractere no display
    	addi $t1, $t1, 1  			# Avan�a para o pr�ximo caractere
    	j loop_string_display       # Continua com loop
    
    fim:
    jr $ra

esperar_input_teclado:
	# $s7: reg que serve como um apontador para a pr�xima posi��o do caractere a ser inserido em comando 
	
    li $t0, 0xFFFF0000   			 # Endere�o do status do teclado
    lw $t0, 0($t0)        			 # Carrega o status do teclado diretamente em $t0
    beqz $t0, esperar_input_teclado  # Se status for 0, entra em loop
	
	li $t0, 0xFFFF0004       # Endere�o do Receiver data do teclado
   	lw $t1, 0($t0)           # Carrega o caractere digitado em $t1

  	# O trecho seguinte armazena o caractere digitado no espa�o reservado para comando
    la $s0, comando          # Carrega o endere�o de comando em $s0
	li $t3, 0                # inicializa $t3 com 0
	
    loop_armazenar:
        lb $t2, 0($s0)       	 # L� o caractere atual do comando e armazena em $t2
        beq $s7, $t3, armazenar  # Se o caractere atual for nulo, armazena
        addi $s0, $s0, 1     	 # Caso contr�rio avan�a para a pr�xima posi��o
        addi $t3, $t3, 1         # Incrementa $t3
        j loop_armazenar	 	 # entra em loop

    armazenar:
        sb $t1, 0($s0)       # Salva o caractere digitado na posi��o atual do comando
        
    addi $s7, $s7, 1        # Incrementa $s7 para a pr�xima posi��o de inser��o de caracteres em comando
    
    # Verifica se o caractere digitado � barra_n (\n)
	la $t2, barra_n                  # Carrega o endere�o de barra_n
    lb $t2, 0($t2)                   # Carrega o valor de barra_n
    beq $t1, $t2, verificar_comando  # Se for barra_n, chama verificar_comando

    # caso contr�rio, exibe o caractere no display
    jal escrever_caractere_digitado_display
    
    j esperar_input_teclado # entra em loop para esperar o pr�ximo caractere
    
escrever_caractere_digitado_display:
    # Aloca espa�o no $sp para salvar o ende�o de $ra
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    
    jal esperar_display_carregar
    
    lw $ra, 0($sp) 		  #resgata o $ra original do $sp
    addi $sp, $sp, 4      #devolve a pilha para a posicao original
	
    li $t0, 0xFFFF000C    # Endere�o do Receiver data do display
	sw $t1, 0($t0)        # Escreve o caractere no display

	jr $ra	
	
escrever_barra_n_display:
    # Aloca espa�o no $sp para salvar o endere�o de $ra
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    
    jal esperar_display_carregar
    
    lw $ra, 0($sp) 			   #resgata o $ra original do $sp
    addi $sp, $sp, 4		   #devolve a pilha para a posicao original

    la $t1, barra_n            # Carrega o endere�o de barra_n
    lb $t1, 0($t1)             # Carrega o valor de barra_n diretamente em $t1

    li $t0, 0xFFFF000C         # Endere�o do Transmitter data do display
    sw $t1, 0($t0)             # Escreve o caractere \n no display

    jr $ra
    
escrever_banner_display:
	la $t1, banner      # Carrega o endere�o do in�cio da string do banner
	
    # Aloca espa�o no $sp para salvar o endere�o de $ra
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
	#	$s3: reg que servir� como contador de caracteres lidos, a qual � incrementado a cada loop     	         
    
   	li $s3, 1   # inicializa $s3 com 1
   
	comparador_loop:
		lb $t0, 0($s0)                          	# Carrega o caractere em $s0 em $t0
		lb $t1, 0($s1)                          	# Carrega o caractere em $s1 em $t1
		bne $t0, $t1, retorno_strings_diferentes    # se os caracteres s�o diferentes $v0 	
		addi $s0, $s0, 1                            # Incrementa $s0, para seguir com o pr�ximo caractere da string
		addi $s1, $s1, 1                            # Incrementa $s1, para seguir com o pr�ximo caractere da string
		addi $s3, $s3, 1 							# Incrementa $s3
		beq  $s2, $s3, retorno_strings_iguais       # Se $s2 e $s3 s�o iguais significa que os caracteres s�o iguais         
		j comparador_loop
		
	retorno_strings_iguais:
		li $v0, 1         # D� ao reg $v0 valor 1 para sinalizar como flag que as strings s�o iguais
		j fim_loop 		  # pula para o fim do loop 
	
	retorno_strings_diferentes:
		li $v0, 0  		  # D� ao reg $v0 o valor 0 para sinalizar como flag que as strings s�o diferentes

	fim_loop: 
		jr $ra  
		
verificar_comando:
	jal escrever_barra_n_display    # Pula para a fun��o que escreve o caractere de quebra de linha (\n) no display
    sb $zero, 0($s0)       			# Substitui o \n digitado pelo usu�rio pelo caractere nulo (\0)
    
    # Verifica cadastrar_livro
  	la $s1, cmd_cadastrar_livro     # Carrega o endere�o de cmd_cadastrar_livro
  	la $s0, comando                 # Carrega o endere�o de comando em S0
  	li $s2, 15                      # Define a quantidade de caracteres de comando que ir�o ser comparados
  	jal comparar_strings            # Pula para a fun��o que ir� comparar as strings
  	beq $v0, 1, cadastrar_livro     # se $v0 for 1, significa que o comando digitado foi o de cadastrar_livro 
  	
  	# Verifica cadastrar_Usuario
  	la $s1, cmd_cadastrar_usuario   # Carrega o endere�o de cmd_cadastrar_usuario
  	la $s0, comando                 # Carrega o endere�o de comando em S0
  	li $s2, 17                      # Define a quantidade de caracteres de comando que ir�o ser comparados
  	jal comparar_strings            # Pula para a fun��o que ir� comparar as strings
  	beq $v0, 1, cadastrar_usuario   # se $v0 for 1, significa que o comando digitado foi o de cadastrar_usuario
  	
  	# Verifica cmd_listar_livro
  	la $s1, cmd_listar_livro        # Carrega o endere�o de cmd_listar_livro
  	la $s0, comando                 # Carrega o endere�o de comando em S0
  	li $s2, 12                      # Define a quantidade de caracteres de comando que ir�o ser comparados
  	jal comparar_strings            # Pula para a fun��o que ir� comparar as strings
  	beq $v0, 1, listar_livro        # se $v0 for 1, significa que o comando digitado foi o de listar_livro
  	
  	# Verifica cmd_reg_emprestimo
  	la $s1, cmd_reg_emprestimo      # Carrega o endere�o de cmd_reg_emprestimo
  	la $s0, comando                 # Carrega o endere�o de comando em S0
  	li $s2, 20                      # Define a quantidade de caracteres de comando que ir�o ser comparados
  	jal comparar_strings            # Pula para a fun��o que ir� comparar as strings
  	beq $v0, 1, listar_livro        # se $v0 for 1, significa que o comando digitado foi o de reg_emprestimo
  	
  	# Verifica cmd_gerar_relatorio
  	la $s1, cmd_gerar_relatorio     # Carrega o endere�o de cmd_gerar_relatorio
  	la $s0, comando                 # Carrega o endere�o de comando em S0
  	li $s2, 20                      # Define a quantidade de caracteres de comando que ir�o ser comparados
  	jal comparar_strings            # Pula para a fun��o que ir� comparar as strings
  	beq $v0, 1, gerar_relatorio     # se $v0 for 1, significa que o comando digitado foi o de gerar_relatorio
  	
  	# Verifica cmd_remover_livro
  	la $s1, cmd_remover_livro     # Carrega o endere�o de cmd_remover_livro
  	la $s0, comando                 # Carrega o endere�o de comando em S0
  	li $s2, 13                      # Define a quantidade de caracteres de comando que ir�o ser comparados
  	jal comparar_strings            # Pula para a fun��o que ir� comparar as strings
  	beq $v0, 1, remover_livro       # se $v0 for 1, significa que o comando digitado foi o de remover_livro
  	
  	# Verifica cmd_remover_usuario
  	la $s1, cmd_remover_usuario     # Carrega o endere�o de cmd_remover_usuario
  	la $s0, comando                 # Carrega o endere�o de comando em S0
  	li $s2, 15                      # Define a quantidade de caracteres de comando que ir�o ser comparados
  	jal comparar_strings            # Pula para a fun��o que ir� comparar as strings
  	beq $v0, 1, remover_usuario     # se $v0 for 1, significa que o comando digitado foi o de remover_usuario
  	
  	# Verifica cmd_savar_dados
  	la $s1, cmd_savar_dados         # Carrega o endere�o de cmd_savar_dados
    la $s0, comando                 # Carrega o endere�o de comando em S0
  	li $s2, 12                      # Define a quantidade de caracteres de comando que ir�o ser comparados
  	jal comparar_strings            # Pula para a fun��o que ir� comparar as strings
  	beq $v0, 1, savar_dados         # se $v0 for 1, significa que o comando digitado foi o de savar_dados
  	
  	# Verifica cmd_formatar_dados
  	la $s1, cmd_formatar_dados      # Carrega o endere�o de cmd_formatar_dados
    la $s0, comando                 # Carrega o endere�o de comando em S0
  	li $s2, 14                      # Define a quantidade de caracteres de comando que ir�o ser comparados
  	jal comparar_strings            # Pula para a fun��o que ir� comparar as strings
  	beq $v0, 1, formatar_dados      # se $v0 for 1, significa que o comando digitado foi o de formatar_dados
  	
  	# Verifica cmd_data_hora
  	la $s1, cmd_data_hora           # Carrega o endere�o de cmd_data_hora
    la $s0, comando                 # Carrega o endere�o de comando em S0
  	li $s2, 9                       # Define a quantidade de caracteres de comando que ir�o ser comparados
  	jal comparar_strings            # Pula para a fun��o que ir� comparar as strings
  	beq $v0, 1, formatar_dados      # se $v0 for 1, significa que o comando digitado foi o de data_hora
    
    j escrever_comando_invalido_display

cadastrar_livro:
	# Em constru��o
	j escrever_livro_cadastrado_display

remover_livro:
	# Em constru��o
	j escrever_livro_removido_display

listar_livro:
	# Em constru��o	
	j main

cadastrar_usuario:
	# Em constru��o
	j escrever_usuario_cadastrado_display
	
remover_usuario:
	# Em constru��o
	j escrever_usuario_removido_display
	
registrar_emprestimo:
	# Em constru��o
	j escrever_emprestimo_realizado_display

gerar_relatorio:
	# Em constru��o
	j main

savar_dados:
	# Agr aqui tu faz o L aqui, parceira.
	j main
	
formatar_dados:
	# Do your jump, mari
	j main
	
data_hora:
	# Agr aqui tu faz o L aqui, parceira.
	j main
	
escrever_livro_cadastrado_display:
    la $t1, msgC_livro_cadastrado   # Carrega o endere�o de msgC_livro_cadastrado
    jal escrever_string_display     # Pula para a fun��o gen�rica que ir� imprimir a string armazenada em $t1
    jal escrever_barra_n_display    # pula para a fun��o que ir� imprimir uma quebra de linha no display
    j main   
    
escrever_usuario_cadastrado_display:
    la $t1, msgC_usuario_cadastrado # Carrega o endere�o de msgC_usuario_cadastrado 
    jal escrever_string_display     # Pula para a fun��o gen�rica que ir� imprimir a string armazenada em $t1
    jal escrever_barra_n_display    # pula para a fun��o que ir� imprimir uma quebra de linha no display
    j main   
    
escrever_emprestimo_realizado_display:
    la $t1, msgC_emprestimo_realizado  # Carrega o endere�o de msgC_emprestimo_realizado
    jal escrever_string_display        # Pula para a fun��o gen�rica que ir� imprimir a string armazenada em $t1
    jal escrever_barra_n_display       # pula para a fun��o que ir� imprimir uma quebra de linha no display
    j main   
    
escrever_livro_removido_display:
    la $t1, msgC_livro_removido     # Carrega o endere�o de msgC_livro_removido
    jal escrever_string_display     # Pula para a fun��o gen�rica que ir� imprimir a string armazenada em $t1
    jal escrever_barra_n_display    # pula para a fun��o que ir� imprimir uma quebra de linha no display
    j main   
    
escrever_usuario_removido_display:   
    la $t1, msgC_usuario_removido   # Carrega o endere�o de msgC_usuario_removido
    jal escrever_string_display     # Pula para a fun��o gen�rica que ir� imprimir a string armazenada em $t1
    jal escrever_barra_n_display    # pula para a fun��o que ir� imprimir uma quebra de linha no display
    j main   

escrever_comando_invalido_display:
	la $t1, msgE_comando_invalido   # Carrega o endere�o de msgE_comando_invalido
    jal escrever_string_display     # Pula para a fun��o gen�rica que ir� imprimir a string armazenada em $t1
    jal escrever_barra_n_display    # pula para a fun��o que ir� imprimir uma quebra de linha no display   
    j main   
	
escrever_acervo_vazio_display:
    la $t1, msgE_acervo_vazio       # Carrega o endere�o de msgE_acervo_vazio
    jal escrever_string_display     # Pula para a fun��o gen�rica que ir� imprimir a string armazenada em $t1
    jal escrever_barra_n_display    # pula para a fun��o que ir� imprimir uma quebra de linha no display
    j main   

escrever_esprestimo_indisponivel_display:
    la $t1, msgE_esprestimo_indisponivel   # Carrega o endere�o de msgE_comando_invalido
    jal escrever_string_display            # Pula para a fun��o gen�rica que ir� imprimir a string armazenada em $t1
    jal escrever_barra_n_display           # pula para a fun��o que ir� imprimir uma quebra de linha no display
    j main   

escrever_relatorio_indisponivel_display:
    la $t1, msgE_relatorio_indisponivel   # Carrega o endere�o de msgE_relatorio_indisponivel
    jal escrever_string_display           # Pula para a fun��o gen�rica que ir� imprimir a string armazenada em $t1
    jal escrever_barra_n_display    	  # pula para a fun��o que ir� imprimir uma quebra de linha no display
    j main   
    
escrever_livro_nao_encontrado_display:
    la $t1, msgE_livro_nao_encontrado   # Carrega o endere�o de msgE_livro_nao_encontrado 
    jal escrever_string_display         # Pula para a fun��o gen�rica que ir� imprimir a string armazenada em $t1
    jal escrever_barra_n_display    	# pula para a fun��o que ir� imprimir uma quebra de linha no display
    j main   

escrever_livro_esta_emprestado_display:
    la $t1, msgE_livro_esta_emprestado   # Carrega o endere�o de msgE_livro_esta_emprestado
    jal escrever_string_display          # Pula para a fun��o gen�rica que ir� imprimir a string armazenada em $t1
    jal escrever_barra_n_display    	 # pula para a fun��o que ir� imprimir uma quebra de linha no display
    j main   
    
escrever_usuario_nao_encontrado_display:
    la $t1, msgE_usuario_nao_encontrado   # Carrega o endere�o de msgE_usuario_nao_encontrado
    jal escrever_string_display           # Pula para a fun��o gen�rica que ir� imprimir a string armazenada em $t1
    jal escrever_barra_n_display    	  # pula para a fun��o que ir� imprimir uma quebra de linha no display
    j main   
    
escrever_usuario_tem_pendencias_display:
    la $t1, msgE_usuario_tem_pendencias   # Carrega o endere�o de msgE_usuario_tem_pendencias
    jal escrever_string_display           # Pula para a fun��o gen�rica que ir� imprimir a string armazenada em $t1
    jal escrever_barra_n_display    	  # pula para a fun��o que ir� imprimir uma quebra de linha no display
    j main   

# Fun��o gen�rica que imprime a mensagem de falta de qualquer argumento no display
escrever_falta_argumento_obrigatorio_display:
	# $s1: reg que possui o endere�o do argumento faltante
	
	# Aloca espa�o no $sp para salvar o endere�o de $ra
    addi $sp, $sp, -4
    sw $ra, 0($sp)
	
	la $t1, msgE_parte1_falta_argumento_obrigatorio  # Carrega o ende�o de msgE_parte1_falta_argumento_obrigatorio
	jal escrever_string_display  # Pula para a fun��o gen�rica que ir� imprimir a string armazenada em $t1
	
	addi $t1, $s1, 0   # soma $s1 com 0 e armazena em t1 (em outras palavras copia o endere�o de $s1 pra $t1)
	jal escrever_string_display   
	
	la $t1, msgE_parte2_falta_argumento_obrigatorio  # Carrega o ende�o de msgE_parte2_falta_argumento_obrigatorio
	jal escrever_string_display     
	
	lw $ra, 0($sp) 		#resgata o $ra original do $sp
    addi $sp, $sp, 4	#devolve a pilha para a posicao original

    jr $ra                 
	  
escrever_falta_argumento_titulo_display:
	la $s1, arg_titulo  # Carrega o endere�o arg_titulo
	jal escrever_falta_argumento_obrigatorio_display
    jal escrever_barra_n_display    	  # pula para a fun��o que ir� imprimir uma quebra de linha no display
    j main   
	
escrever_falta_argumento_autor_display:
	la $s1, arg_autor  # Carrega o endere�o arg_autor
	jal escrever_falta_argumento_obrigatorio_display
    jal escrever_barra_n_display    	  # pula para a fun��o que ir� imprimir uma quebra de linha no display
    j main   
	
escrever_falta_argumento_ISBN_display:
	la $s1, arg_ISBN  # Carrega o endere�o arg_ISBN
	jal escrever_falta_argumento_obrigatorio_display
    jal escrever_barra_n_display    # pula para a fun��o que ir� imprimir uma quebra de linha no display
    j main   
	
escrever_falta_argumento_quantidade_display:
	la $s1, arg_quantidade  # Carrega o endere�o arg_quantidade 
	jal escrever_falta_argumento_obrigatorio_display
    jal escrever_barra_n_display    # pula para a fun��o que ir� imprimir uma quebra de linha no display
    j main   
	
escrever_falta_argumento_nome_display:
	la $s1, arg_nome  # Carrega o endere�o arg_nome
	jal escrever_falta_argumento_obrigatorio_display
    jal escrever_barra_n_display    # pula para a fun��o que ir� imprimir uma quebra de linha no display
    j main   
	
escrever_falta_argumento_matricula_display:
	la $s1, arg_matricula  # Carrega o endere�o arg_matricula
	jal escrever_falta_argumento_obrigatorio_display
    jal escrever_barra_n_display    # pula para a fun��o que ir� imprimir uma quebra de linha no display
    j main   
	
escrever_falta_argumento_curso_display:
	la $s1, arg_curso  # Carrega o endere�o arg_curso
	jal escrever_falta_argumento_obrigatorio_display
    jal escrever_barra_n_display    # pula para a fun��o que ir� imprimir uma quebra de linha no display
    j main   
	
escrever_falta_argumento_devolucao_display:
	la $s1, arg_devolucao  # Carrega o endere�o arg_devolucao
	jal escrever_falta_argumento_obrigatorio_display
    jal escrever_barra_n_display    # pula para a fun��o que ir� imprimir uma quebra de linha no display
    j main  
    
escrever_falta_argumento_data_display:
	la $s1, arg_data  # Carrega o endere�o arg_data
	jal escrever_falta_argumento_obrigatorio_display
    jal escrever_barra_n_display    # pula para a fun��o que ir� imprimir uma quebra de linha no display
    j main   
	 	     	            
escrever_falta_argumento_hora_display:
	la $s1, arg_hora  # Carrega o endere�o arg_hora
	jal escrever_falta_argumento_obrigatorio_display
    jal escrever_barra_n_display    # pula para a fun��o que ir� imprimir uma quebra de linha no display
    j main  

incrementar_s0:
	addi $s0, $s0, 1
    jr $ra	      
               	         

