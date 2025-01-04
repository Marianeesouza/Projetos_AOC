.data

.text
.globl main

main:
    # Loop infinito para leitura do teclado e escrita no display
echo_loop:
    # Lê o status do teclado (Keyboard Control - 0xFFFF0004)
    li $t0, 0xFFFF0004        # Endereço do Keyboard Control
    lw $t1, 0($t0)            # Lê o valor do Keyboard Control
    andi $t1, $t1, 0x1        # Verifica se o bit de disponibilidade está ativo (bit 0)
    beqz $t1, echo_loop       # Se não estiver ativo, volta ao início do loop

    # Lê o caractere do teclado (Keyboard Data - 0xFFFF0000)
    li $t0, 0xFFFF0000        # Endereço do Keyboard Data
    lw $t2, 0($t0)            # Lê o caractere digitado

    # Aguarda o display estar pronto (Display Control - 0xFFFF0008)
wait_display:
    li $t0, 0xFFFF0008        # Endereço do Display Control
    lw $t3, 0($t0)            # Lê o valor do Display Control
    andi $t3, $t3, 0x1        # Verifica se o bit de disponibilidade está ativo (bit 0)
    beqz $t3, wait_display    # Se não estiver ativo, espera

    # Escreve o caractere no display (Display Data - 0xFFFF000C)
    li $t0, 0xFFFF000C        # Endereço do Display Data
    sw $t2, 0($t0)            # Escreve o caractere lido no display

    # Retorna ao início do loop para continuar o Echo
    j echo_loop
