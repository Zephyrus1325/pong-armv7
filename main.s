// main.s
// Arquivo principal, contém o fluxo geral do jogo (renderização e logica de jogo)
// Autores:
// Bernardo Ferri Schirmer
// Marco Aurélio Tiago Filho

.global _start
.text
_start:
// setup inicial do processo
    bl setup_ball_timer
    bl setup_ai_timer
    bl setup_display
reset_menu:
    bl fill_background
    ldr r1, =DISPLAY_FRONT_BUFFER   // Troca o buffer frontal com o backbuffer
    mov r0, #1
    str r0, [r1]
    bl clear_text
    bl write_texts
    bl wait_for_mode_selection
    bl restart_game
    bl clear_text
    ldr r1, =RESTART_FLAG      
// loop principal
main_loop:
    bl game_logic
    bl render
    ldr r0, [r1]
    cmp r0, #0
    beq main_loop
    b reset_menu


.include "sound.s"
.include "ball.s"
.include "game_control.s"
.include "rendering.s"
.include "variables.s"

