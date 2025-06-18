.global _start
_start:
// setup inicial do processo


// loop principal
main_loop:

    b main_loop

.include "variables.s"
.include "game_control.s"
.include "rendering.s"