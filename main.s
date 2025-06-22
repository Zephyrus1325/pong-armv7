.global _start
.text
_start:
// setup inicial do processo

// loop principal
main_loop:
    b main_loop

.include "game_control.s"
.include "rendering.s"
.include "variables.s"
