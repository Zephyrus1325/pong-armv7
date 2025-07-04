.data   // Região de dados do código

// defina aqui constantes
// Endereços
.equ KEY_FIFO, 0xFF200100
.equ KEY_LENGTH, 0xFF200102
.equ BALL_TIMER_STATUS, 0xFF202000
.equ BALL_TIMER_CONTROL, 0xFF202004
.equ BALL_TIMER_START_LOW, 0xFF202008
.equ BALL_TIMER_START_HIGH, 0xFF20200C
.equ AI_TIMER_STATUS, 0xFF202020
.equ AI_TIMER_CONTROL, 0xFF202024
.equ AI_TIMER_START_LOW, 0xFF202028
.equ AI_TIMER_START_HIGH, 0xFF20202C
.equ DISPLAY_FRONT_BUFFER, 0xFF203020
.equ DISPLAY_BACK_BUFFER, 0xFF203024
.equ DISPLAY_STATUS, 0xFF20302C
.equ CHAR_BUFFER, 0xC9000000
.equ AUDIO_CONTROL, 0xFF203040
.equ AUDIO_FIFOSPACE, 0xFF203044
.equ AUDIO_LEFT, 0xFF203048
.equ AUDIO_RIGHT, 0xFF20303C


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
.equ MOVE_INCREMENT, 8      // Quantos pixels cada player se move por vez
.equ COLOR_BLACK, 0x0000    // Preto
.equ COLOR_WHITE, 0xFFFF    // Branco
.equ BALL_TIME_LOW, 0x4B40
.equ BALL_TIME_HIGH, 0x004C
.equ AI_TIME_LOW, 0xF080       
.equ AI_TIME_HIGH, 0x008A
.equ SEGMENT_SIZE, 10       // tamanho de cada segmento dos numeros
.equ SAMPLE_RATE, 48000     // Taxa de amostragem do hardware de audio

TEXT_TITLE:
.ascii "PONG"
.byte 0
TEXT_PLAY1:
.ascii "Aperte 1 para jogar com um jogador"
.byte 0
TEXT_PLAY2:
.ascii "Aperte 2 para jogar com dois jogadores"
.byte 0
TEXT_AUTHORS:
.ascii "Feito por: Bernardo Ferri e Marco Aurelio"
.byte 0
TEXT_COPYRIGHT:
.ascii "ACSE IFES 2025"
.byte 0

.align 2
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
BALL_X: .word 0          // Posição X da bola
BALL_Y: .word 0          // Posição Y da bola
BALL_DX: .word 0         // Velocidade X da bola
BALL_DY: .word 0         // Velocidade Y da bola
GAME_MODE: .word 0        // Modo de jogo (0 para 1 jogador, e 1 para 2 jogadores)
RESTART_FLAG: .word 0
RANDOM_ADDRESS: .word 0x327083FB    //Endereco qualquer pra a aleatoriedade de comeco da bola

PIXEL_BUFFER_A: .skip 320*240*4 // Buffer de pixels 1
PIXEL_BUFFER_B: .skip 320*240*4 // Buffer de pixels 2


