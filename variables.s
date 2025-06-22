.data   // Região de dados do código

// defina aqui constantes
// Endereços
.equ KEY_FIFO, 0xff200100
.equ KEY_LENGTH, 0xff200102
.equ PIXEL_BUFFER, 0xc8000000
// Valores
.equ WIDTH, 320         // Largura da tela (pixels)
.equ HEIGHT, 240        // Altura da tela (pixels)
.equ PLAYER1_UP, 0x1D     // ID do botão para subir raquete do jogador 1
.equ PLAYER1_DOWN, 0x1B   // ID do botão para descer raquete do jogador 1
.equ PLAYER2_UP, 0x43     // ID do botão para subir raquete do jogador 2
.equ PLAYER2_DOWN, 0x42   // ID do botão para descer raquete do jogador 2
.equ COLOR_BLACK, 0x0000  // Preto
.equ COLOR_WHITE, 0xFFFF  // Branco

// Coloque aqui variaveis que vão para a RAM
player1_pos: .word 0      // Posição da raquete do jogador 1
player2_pos: .word 0      // Posição da raquete do jogador 2
points1: .word 0          // Pontuação do jogador 1
points2: .word 0          // Pontuação do jogador 2
