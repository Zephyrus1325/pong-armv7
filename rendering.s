.text

// Configura o display com o double buffering
// *Chamar apenas uma vez no inicio do programa*
// Parametro: Nenhum
// Retorno: Nenhum
setup_display:
    push {r0, r1, lr}
    ldr r0, =PIXEL_BUFFER_A         // Escreve o endereço de memoria do primeiro buffer
    ldr r1, =DISPLAY_BACK_BUFFER    // No registrador do display
    str r0, [r1]

    ldr r1, =DISPLAY_FRONT_BUFFER   // Troca o buffer frontal com o backbuffer
    mov r0, #1
    str r0, [r1]

    ldr r0, =PIXEL_BUFFER_B         // Escreve o endereço de memoria do segundo buffer
    ldr r1, =DISPLAY_BACK_BUFFER    // No registrador do display
    str r0, [r1]

    pop {r0, r1, lr}
    mov pc, lr

// Escritor de pixel
// Faz um pixel ficar branco
// Parametro: R0 - X | R1 - Y
// Retorno: Nenhum
draw_pixel:
    push {r0, r1, r2, r3, lr}
    ldr r2, =COLOR_WHITE            // Carrega a cor branca
    ldr r3, =DISPLAY_BACK_BUFFER    // Carrega o endereço do buffer de pixels
    ldr r3, [r3]
    add r3, r3, r0, LSL #1          // Calcula endereço do pixel
    add r3, r3, r1, LSL #10 
    strh r2, [r3]                   // Escreve o valor do pixel

    pop {r0, r1, r2, r3, lr}
    mov pc, lr

// Escritor de numero
// Parametro: R0 - X | R1 - Y | R2 - Numero
// Retorno: Nenhum
// Notas: r3 = resultado temp mascara
draw_number:
    push {r0, r1, r2, r3, r4, r5, lr}
    ldr r4, =SEG_DECODE             // Pega o endereço base dos segmentos
    ldrb r4, [r4, r2]                // Carrega a mascara em relação ao numero selecionado 

    ldr r2, =SEGMENT_SIZE           // Coloca o valor do segmento no r2 para facilitar chamadas de função
    
                    // Segmento A
    ands r3, r4, #0b00000001        // Faz um and com a mascara, e salva flags
    beq draw_number_f               // Se for zero, faz o proximo segmento
    bl draw_lineh

draw_number_f:      // Segmento F
    ands r3, r4, #0b00100000        // Faz um and com a mascara, e salva flags
    beq draw_number_b               // Se for zero, faz o proximo segmento
    bl draw_linev

draw_number_b:      // Segmento B
    add r0, r0, r2                  // Soma X em number_size
    ands r3, r4, #0b00000010        // Faz um and com a mascara, e salva flags
    beq draw_number_c               // Se for zero, faz o proximo segmento
    bl draw_linev


draw_number_c:      // Segmento C 
    add r1, r1, r2                  // Soma Y em number_size
    ands r3, r4, #0b00000100        // Faz um and com a mascara, e salva flags
    beq draw_number_e               // Se for zero, faz o proximo segmento
    bl draw_linev

draw_number_e:      // Segmento E
    sub r0, r0, r2                  // subtrai X em number_size
    ands r3, r4, #0b01000000        // Faz um and com a mascara, e salva flags
    beq draw_number_g               // Se for zero, faz o proximo segmento
    bl draw_lineh

draw_number_g:      // Segmento G  
    ands r3, r4, #0b00010000        // Faz um and com a mascara, e salva flags
    beq draw_number_d               // Se for zero, faz o proximo segmento
    bl draw_linev


draw_number_d:      // Segmento D
    add r1, r1, r2                  // Soma X em number_size
    ands r3, r4, #0b00001000        // Faz um and com a mascara, e salva flags
    beq draw_number_exit            // Se for zero, faz o proximo segmento
    bl draw_lineh


draw_number_exit:   

    pop {r0, r1, r2, r3, r4, r5, lr}
    mov pc, lr




// Desenha uma linha na vertical uma determinada distancia
// Parametro: R0 - X | R1 - Y | R2 - comprimento
// Retorno: Nenhum
draw_linev:
    push {r0, r1, r2, lr}
draw_linev_loop:
    cmp r2, #0
    beq draw_linev_exit
    bl draw_pixel
    add r1, r1, #1
    sub r2, r2, #1
    b draw_linev_loop
draw_linev_exit:
    pop {r0, r1, r2, lr}
    mov pc, lr




// Desenha uma linha na horizontal uma determinada distancia
// Parametro: R0 - X | R1 - Y | R2 - comprimento
// Retorno: Nenhum
draw_lineh:
    push {r0, r1, r2, lr}
draw_lineh_loop:
    cmp r2, #0
    beq draw_lineh_exit
    bl draw_pixel
    add r0, r0, #1
    sub r2, r2, #1
    b draw_lineh_loop
draw_lineh_exit:
    pop {r0, r1, r2, lr}
    mov pc, lr


// Preenche o fundo com preto
// Parametro: Nenhum
// Retorno: Nenhum
fill_background:
    push {r0, r1, r2, r3, r4, r5, lr}
    ldr r2, =WIDTH                  // Carrega a largura da tela
    ldr r3, =HEIGHT                 // Carrega a altura da tela
    ldr r4, =COLOR_BLACK            // Carrega a cor preta
    mov r1, #0                      // X = 0
fill_background_loop_line:
    mov r0, #0                      // Y = 0
fill_background_loop:
    ldr r5, =DISPLAY_BACK_BUFFER    // Recarrega o ponteiro do buffer de pixels
    ldr r5, [r5]
    add r5, r5, r0, LSL #1          // Calcula o endereço do pixel
    add r5, r5, r1, LSL #10
    strh r4, [r5]                   // Escreve o valor

    add r0, r0, #1                  // x = x + 1
    cmp r0, r2                      // x = width ?
    bne fill_background_loop        // Se não, continua loop
    add r1, r1, #1                  // caso contrario, y = y + 1
    cmp r1, r3                      // y = height ?
    bne fill_background_loop_line   // Se não, continua loop
                                    // caso contrário, sai do loop
    pop {r0, r1, r2, r3, r4, r5, lr}
    mov pc, lr

// Função que desenha uma raquete
// Parametro: R0 - X | R1 - Y
// Retorno: Nenhum
draw_paddle:
    push {r0, r1, r2, lr}
    ldr r2, =PADDLE_SIZE
draw_paddle_loop:
    bl draw_pixel
    add r1, r1, #1
    sub r2, r2, #1
    cmp r2, #0
    bne draw_paddle_loop

    pop {r0, r1, r2, lr}
    mov pc, lr  

// Função que desenha as raquetes dos jogadores
// Parametro: Nenhum
// Retorno: Nenhum
draw_players:
    push {r0, r1, r2, lr}
    // Renderizar jogador 1
    ldr r0, =PADDLE_SPACING
    ldr r1, =PLAYER1_POS
    ldr r1, [r1]
    bl draw_paddle

    // Renderizar jogador 2
    ldr r2, =WIDTH
    sub r0, r2, r0
    ldr r1, =PLAYER2_POS
    ldr r1, [r1]
    bl draw_paddle

    pop {r0, r1, r2, lr}
    mov pc, lr  

// Função que desenha as pontuações dos jogadores
// Parametro: Nenhum
// Retorno: Nenhum
draw_points:
    push {r0, r1, r2, r3, r4, r5, lr}
    ldr r1, =POINT_HEIGHT       // Altura dos pontos
    ldr r3, =POINT_SPACING
    ldr r4, =WIDTH
    lsr r4, r4, #1              // width/2 (centro da tela)

    // Renderizar pontos do jogador 1
    sub r0, r4, r3              // Pos_x = width/2 - spacing
    ldr r2, =POINTS1            // Pega os pontos do jogador 1
    ldr r2, [r2]
    bl draw_number              // Desenha o numero

    // Renderizar jogador 2
    add r0, r4, r3              // Pos_x = width/2 + spacing
    ldr r4, =SEGMENT_SIZE       
    sub r0, r0, r4              // Pos_x = pos_x - segment_size
    ldr r2, =POINTS2            // Carrega os pontos do jogador 2
    ldr r2, [r2]
    bl draw_number              // Desenha o numero

    pop {r0, r1, r2, r3, r4, r5, lr}
    mov pc, lr  




// Função principal de renderização
// Vai tentar renderizar um novo frame a cada final de frame swap
// *Chamar no loop*
// Parametro: Nenhum
// Retorno: Nenhum
render:
    push {r0, r1, r2, r3, r4, lr}
    ldr r1, =DISPLAY_STATUS         // Carrega o Status do display
    ldr r0, [r1]
    and r0, r0, #1                  // Checa o bit 0 (Status)
    cmp r0, #1                      // Se não tiver completado a transferencia de buffer
    beq render_exit                 // Ignora a tentativa de renderização
                                    // Caso contrario, renderize a cena
    
    // Colocar o codigo de renderização aqui em baixo
    bl fill_background              // Limpar o frame anterior
    bl draw_players                 // Desenha as raquetes
    bl draw_points                  // Desenha as pontuações
    bl draw_ball                    // Desenha a bolinha

    ldr r0, =WIDTH
    asr r0, r0, #1                  // Width/2
    mov r1, #0
    ldr r3, =HEIGHT
    mov r2, #5                      // Variação entre as coisas
center_line_loop:

    bl draw_linev
    add r1, r1, r2, lsl #1                  // y = y + valor_constante
    cmp r1, r3                      // y < height ?
    blt center_line_loop
center_line_exit:
    ldr r1, =DISPLAY_FRONT_BUFFER   // Troca o buffer frontal com o backbuffer
    mov r0, #1
    str r0, [r1]

render_exit:
    pop {r0, r1, r2, r3, r4, lr}
    mov pc, lr




