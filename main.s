.global _start
.text
_start:
// setup inicial do processo
    bl setup_ball_timer
    bl setup_display
reset_menu:
    bl fill_background
    bl clear_text
    bl write_texts
    bl wait_for_mode_selection
    bl restart_game
    bl clear_text
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

