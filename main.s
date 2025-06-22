.global _start
.text
_start:
// setup inicial do processo
    bl restart_game
    bl setup_display
// loop principal
main_loop:
    bl game_logic
    bl render

.include "game_control.s"
.include "rendering.s"
.include "variables.s"
