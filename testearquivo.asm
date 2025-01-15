.data


registro_tamanho:		.word 0	
filelivro:			.asciiz "livros.txt"
registro:			.asciiz "Dom Casmurro,Machado de Assis,123456789,5\n"
prompt1: 			.asciiz "Arquivo salvo com sucesso"

repositorio_livro: 	.word 0 # local do endereco do espaço alocado
buffer:				.space 1
tamanho_arquivo:	.word 0 # variavel para contar tamanho do arquivo

.text 	
.globl main

main:
#jal cadastrar_livro
jal aloca_rep
jal imprime_rep_livro

li $v0, 10
syscall
	

cadastrar_livro:
	# abre o arquivo com no modo leitura+append
	li $v0, 13
	la $a0, filelivro
	li $a1, 9
	li $a2, 0
	syscall 
	move $s0, $v0 # salva descritor em $s0
	lw $t0, registro_tamanho #tamanho do registro
	la $t1, registro # endereço da string do registro
	j contar_tamanho_registro
	
contar_tamanho_registro:
	lb $t2, ($t1)  
	beqz $t2, salvar_livro
	addi $t0, $t0, 1
	addi $t1, $t1, 1
	j contar_tamanho_registro
	
salvar_livro:
	sw $t0, registro_tamanho
	#escreve o registro no arquivo
	li $v0, 15
	move $a0, $s0
	la $a1, registro
	lw $a2, registro_tamanho
	syscall
	
	
	#fecha o descritor
	li $v0, 16
	move $a0, $s0
	syscall
	
	li $v0, 4
	la $a0, prompt1
	syscall
	
	jr $ra
	
aloca_rep:
	li $v0, 13
	la $a0, filelivro
	li $a1, 0
	li $a2, 0
	syscall
	move $s0, $v0
	j conta_arquivo

	
conta_arquivo:
	li $v0, 14
	move $a0, $s0
	la $a1, buffer
	li $a2, 100
	syscall # salva valor lido no buffer, e número de bytes lido em $v0
	beqz $v0, alocar_espaco
	add $t0, $v0, $t0
	j conta_arquivo 
	
alocar_espaco:
	li $v0, 16
	move $a0, $s0
	syscall # fecha arquivo
	
	sw $t0, tamanho_arquivo
	li $v0, 9
	lw $a0, tamanho_arquivo
	syscall # aloca o espaco do tamanho do arquivo
	
	sw $v0, repositorio_livro # armazena endereço do espaco  alocado em repositorio_livro
	jr $ra
	

imprime_rep_livro:
	# abre o arquivo com no modo leitura
	li $v0, 13 
	la $a0, filelivro
	li $a1, 0
	li $a2, 0
	syscall 
	move $s0, $v0
	
	# le o arquivo e envia dados no repositorio
	li $v0, 14
	move $a0, $s0
	lw $a1, repositorio_livro
	lw $a2, tamanho_arquivo
	syscall
	
	# imprime conteudo do repositorio
	li $v0, 4
	lw $a0, repositorio_livro
	syscall
	
	jr $ra
	
		

	
	
