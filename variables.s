.data   // Região de dados do código

// defina aqui constantes
// Endereços
.equ KEY_FIFO, 0xFF200100
.equ KEY_LENGTH, 0xFF200102
.equ FRAME_TIMER_STATUS, 0xFF202000
.equ FRAME_TIMER_CONTROL, 0xFF202004
.equ FRAME_TIMER_START_LOW, 0xFF202008
.equ FRAME_TIMER_START_HIGH, 0xFF20200C
.equ DISPLAY_FRONT_BUFFER, 0xFF203020
.equ DISPLAY_BACK_BUFFER, 0xFF203024
.equ DISPLAY_STATUS, 0xFF20302C


// Valores
.equ WIDTH, 320     // Largura da tela (pixels)
.equ HEIGHT, 240    // Altura da tela (pixels)
.equ PADDLE_SIZE, 30        // Comprimento da raquete dos jogadores (pixels)
.equ PADDLE_SPACING, 15     // Espaçamento dos jogadores em relação a parede (pixels)
.equ POINT_HEIGHT, 10       // Distancia dos pontos em relação ao topo (pixels)
.equ POINT_SPACING, 30      // Espaçamento dos pontos em relação ao centro (pixels)
.equ PLAYER1_UP, 0x1D       // ID do botão para subir raquete do jogador 1
.equ PLAYER1_DOWN, 0x1B     // ID do botão para descer raquete do jogador 1
.equ PLAYER2_UP, 0x43       // ID do botão para subir raquete do jogador 2
.equ PLAYER2_DOWN, 0x42     // ID do botão para descer raquete do jogador 2
.equ COLOR_BLACK, 0x0000    // Preto
.equ COLOR_WHITE, 0xFFFF    // Branco
.equ FRAME_TIME_LOW, 0x4B40
.equ FRAME_TIME_HIGH, 0x004C
.equ SEGMENT_SIZE, 10       // tamanho de cada segmento dos numeros

// Valores de segmentos para mostrar a pontuação
SEG_DECODE:
.byte 0b00111111 // 0
.byte 0b00000110 // 1
.byte 0b01011011 // 2
.byte 0b01001111 // 3
.byte 0b01100110 // 4
.byte 0b01101101 // 5
.byte 0b01111101 // 6
.byte 0b00000111 // 7
.byte 0b01111111 // 8
.byte 0b01101111 // 9
.byte 0b01000000 // 10 (invalido)
.byte 0b01000000 // 11 (invalido)
.byte 0b01000000 // 12 (invalido)
.byte 0b01000000 // 13 (invalido)
.byte 0b01000000 // 14 (invalido)
.byte 0b01000000 // 15 (invalido)

// Coloque aqui variaveis que vão para a RAM
PLAYER1_POS: .word 0      // Posição da raquete do jogador 1
PLAYER2_POS: .word 0      // Posição da raquete do jogador 2
POINTS1: .word 0          // Pontuação do jogador 1
POINTS2: .word 0          // Pontuação do jogador 2


PIXEL_BUFFER_A: .skip 320*240*2 // Buffer de pixels 1
PIXEL_BUFFER_B: .skip 320*240*2 // Buffer de pixels 2
