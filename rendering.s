.text

// Escritor de pixel
// Faz um pixel ficar branco
// Parametro: R0 - X | R1 - Y
// Retorno: Nenhum
draw_pixel:
push {r0, r1, r2, r3, lr}
ldr r2, =COLOR_WHITE        // Carrega a cor branca
ldr r3, =PIXEL_BUFFER       // Carrega o endereço do buffer de pixels
add r3, r3, r0, LSL #1      // Calcula endereço do pixel
add r3, r3, r1, LSL #10 
strh r2, [r3]               // Escreve o valor do pixel

pop {r0, r1, r2, r3, lr}
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
ldr r5, =PIXEL_BUFFER           // Recarrega o ponteiro do buffer de pixels
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
