.text
// Leitor de teclas PS/2
// Parametro: nenhum
// Retorno: Tecla lida em R0
read_key:
    push {r1, lr}
    ldr r1, =KEY_LENGTH   // Carrega o pointer para o contador de tamanho do buffer
    ldrb r0, [r1]       // Lê quantas teclas tem no buffer
    cmp r0, #0          // Se estiver vazio, sai da subrotina
    beq read_key_exit
    ldr r1, =KEY_FIFO   // Carrega o pointer para o buffer fifo de teclas
    ldrb r0, [r1]       // Lê a tecla
    cmp r0, #0xF0       // Compara com o caracter terminador de tecla (sla o nome)
    bne read_key_exit
    ldrb r0, [r1]       // Lê mais uma tecla, de novo
read_key_exit:
    pop {r1, lr}
    mov pc, lr
