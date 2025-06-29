.global _start
.text
_start:
// setup inicial do processo
    bl setup_ball_timer
    bl restart_game
    bl setup_display
// loop principal
main_loop:
    bl game_logic
    bl render

    b main_loop

.include "sound.s"
.include "ball.s"
.include "game_control.s"
.include "rendering.s"
.include "variables.s"

