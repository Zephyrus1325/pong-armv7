.text

// Reseta bola pro centro com velocidade regular
// Parametros: Nenhum
// Return: Nenhum
reset_ball:
    push {r0, r1, lr}
    // Coloca bola no centro
    ldr r0, = WIDTH
    lsr r0, r0, #1          // R0 = WIDTH/2
    ldr r1, = BALL_X
    str r0, [r1]
    ldr r0, = HEIGHT
    lsr r0, r0, #1          // r0 = HEIGHT/2
    ldr r1, = BALL_Y
    str r0, [r1]
    
    // Bola fica com velocidade inicial "default" (pra direita e pra baixo)
    //(se achar uma forma, fazer isso ficar aleatório pra ficar menos similar os jogos :D)
    mov r0, #1
    ldr r1, = BALL_DX
    str r0, [r1]
    ldr r1, = BALL_DY
    str r0, [r1]
    
    pop {r0, r1, lr}
    mov pc, lr

// Desenha a bola no (BALL_X,BALL_Y)
// Parametro: Nenhum
// Return: Nenhum
draw_ball:
    push {r0, r1, lr}
    ldr r0, = BALL_X
    ldr r0, [r0]    // r0 = Posição x
    ldr r1, = BALL_Y
    ldr r1, [r1]    // r1 = Posição y
    bl draw_pixel   // Usa a função draw_pixel (x, y, color)
    pop {r0, r1, lr}
    mov pc, lr

// Atualiza posição da bola e faz check de colisão
// Usado no game_logic
// Parametro: Nenhum
// Return: Nenhum
update_ball_physics:
    push {r0, r1, r2, r3, r4, r5, r6, r7, r8, lr}   //Meu deus do ceu tentar achar uma forma de usar menos registradores
    
    // Carregar posição da bola atual
    ldr r0, = BALL_X
    ldr r1, [r0]           // r1 = BALL_X
    ldr r0, = BALL_DX
    ldr r2, [r0]           // r2 = BALL_DX
    
    ldr r3, = BALL_Y
    ldr r4, [r3]           // r4 = BALL_Y
    ldr r3, = BALL_DY
    ldr r5, [r3]           // r5 = BALL_DY
    
    // Calcula nova posição
    add r1, r1, r2         // new_x = BALL_X + BALL_DX
    add r4, r4, r5         // new_y = BALL_Y + BALL_DY
    
    // Checa colisão do teto
    cmp r4, #0
    bgt check_bottom_wall
    mov r4, #0             // Impede de ultrapassar o teto
    neg r5, r5             // Inverte direção y
    b check_paddle_left

check_bottom_wall:
    ldr r6, =HEIGHT
    sub r6, r6, #1         // HEIGHT - 1 pra não dar overflow
    cmp r4, r6
    blt check_paddle_left
    mov r4, r6             // Impede de ultrapassar o chão
    neg r5, r5             // Inverte direção y

check_paddle_left:
    // Checa se a bola ta se movendo pra esquerda na raquete do player 1
    cmp r2, #0
    bge check_paddle_right
    
    ldr r6, =PADDLE_SPACING
    cmp r1, r6
    bne check_paddle_right
    
    // Checa se a bola bate na raquete do player 1
    ldr r7, =PLAYER1_POS
    ldr r7, [r7]           // Ponto mais alto da raquete do player 1
    cmp r4, r7
    blt check_paddle_right
    add r7, r7, #PADDLE_SIZE
    cmp r4, r7
    bgt check_paddle_right  //Se colisão com a raquete
    
    neg r2, r2             // Inverte direção x
    b check_scoring //Se não, player 1 pontua

check_paddle_right:
    // Checa se a bola ta se movendo pra direita na raquede do player 2
    cmp r2, #0
    ble check_scoring
    
    ldr r6, =WIDTH
    ldr r7, =PADDLE_SPACING
    sub r6, r6, r7         // WIDTH - PADDLE_SPACING, pq é a posição da raquete
    cmp r1, r6
    bne check_scoring
    
    // Checa se a bola bate na raquete do player 2
    ldr r7, =PLAYER2_POS
    ldr r7, [r7]           // Ponto mais alto da raquete do player 2
    cmp r4, r7
    blt check_scoring
    add r7, r7, #PADDLE_SIZE
    cmp r4, r7
    bgt check_scoring
    
    // Colisão com raquete direita
    neg r2, r2             // Inverte direção x

check_scoring:
    // Verifica se alguém já ganhou antes de dar o ponto
    ldr r8, =RESTART_FLAG
    ldr r8, [r8]
    cmp r8, #0
    bne update_ball_exit  // Se jogo terminou, não processa ponto
    
    // Checa pontuação do player 2
    cmp r1, #0
    bge check_right_scoring
    
    // Player 2 pontua
    ldr r6, =POINTS2
    ldr r7, [r6]
    add r7, r7, #1
    str r7, [r6]
    
    // Verifica se player 2 ganhou (>=10 pontos)
    cmp r7, #10
    bge set_player2_wins
    bl reset_ball
    b update_ball_exit

check_right_scoring:
    ldr r6, =WIDTH
    cmp r1, r6
    blt update_position
    
    // Player 1 pontua
    ldr r6, =POINTS1
    ldr r7, [r6]
    add r7, r7, #1
    str r7, [r6]
    
    // Verifica se player 1 ganhou (>=10 pontos)
    cmp r7, #10
    bge set_player1_wins
    bl reset_ball
    b update_ball_exit

set_player1_wins:
    ldr r6, =RESTART_FLAG
    mov r7, #1
    str r7, [r6]
    b update_ball_exit

set_player2_wins:
    ldr r6, =RESTART_FLAG
    mov r7, #2
    str r7, [r6]
    b update_ball_exit

update_position:
    // Atualiza posição da bola
    ldr r0, =BALL_X
    str r1, [r0]
    ldr r0, =BALL_Y
    str r4, [r0]
    
    // Atualiza velocidade
    ldr r0, =BALL_DX
    str r2, [r0]
    ldr r0, =BALL_DY
    str r5, [r0]

update_ball_exit:
    pop {r0, r1, r2, r3, r4, r5, r6, r7, r8, lr}
    mov pc, lr


