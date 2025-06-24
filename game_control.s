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
    mov r0, #0          // Desconsidera a leitura (evita double click indesejado)
read_key_exit:
    pop {r1, lr}
    mov pc, lr


// Pega as entradas do teclado e age de acordo com o comando
// Parametro: nenhum
// Retorno: Nenhum
// TODO: Melhorar essa função, ta bemmmmm mal feita
// Deus me perdoe por ter feito tais males para a humanidade
get_controls:
    push {r0, r1, r2, lr}

    bl read_key
    ldr r1, =PLAYER1_UP
    cmp r0, r1
    beq get_controls_sub1
    ldr r1, =PLAYER1_DOWN
    cmp r0, r1
    beq get_controls_add1
get_controls_player2:
    ldr r1, =PLAYER2_UP
    cmp r0, r1
    beq get_controls_sub2
    ldr r1, =PLAYER2_DOWN
    cmp r0, r1
    beq get_controls_add2
    b get_controls_exit

get_controls_add1:
    ldr r1, =PLAYER1_POS
    ldr r2, [r1]
    cmp r2, #(HEIGHT-PADDLE_SIZE-5)
    addlt r2, r2, #8
    str r2, [r1]
    b get_controls_player2
get_controls_sub1:
    ldr r1, =PLAYER1_POS
    ldr r2, [r1]
    cmp r2, #(5)
    subgt r2, r2, #8
    str r2, [r1]
     b get_controls_player2
get_controls_add2:
    ldr r1, =PLAYER2_POS
    ldr r2, [r1]
    cmp r2, #(HEIGHT-PADDLE_SIZE-5)
    addlt r2, r2, #8
    str r2, [r1]
    b get_controls_player2
get_controls_sub2:
    ldr r1, =PLAYER2_POS
    ldr r2, [r1]
    cmp r2, #5
    subgt r2, r2, #8
    str r2, [r1]

get_controls_exit:
    pop {r0, r1, r2, lr}
    mov pc, lr


// Coloca o jogo em um estado inicial padrão
// Parametro: nenhum
// Retorno: Nenhum
restart_game:
    push {r0, r1, lr}
    ldr r0, =HEIGHT         // Coloca as raquetes no centro do tabuleiro
    lsr r0, r0, #1
    ldr r1, =PADDLE_SIZE    // Pos_inicial = Altura/2 - Tam_raquete/2
    sub r0, r0, r1, LSR #1
    ldr r1, =PLAYER1_POS
    str r0, [r1]
    ldr r1, =PLAYER2_POS
    str r0, [r1]
    mov r0, #0              // Zera a pontuação dos jogadores
    ldr r1, =POINTS1
    str r0, [r1]
    ldr r1, =POINTS2
    str r0, [r1]

    // TODO: Colocar a bolinha em uma posição inicial padrão

    pop {r0, r1, lr}
    mov pc, lr


// Roda toda a logica de jogo
// *Colocar no loop*
// Parametro: nenhum
// Retorno: Nenhum
game_logic:
    push {r0, r1, lr}

    bl get_controls

    pop {r0, r1, lr}
    mov pc, lr
    