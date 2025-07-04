.text
// Note to self: Eventualmente permitir multiplos canais de audio e varios tipos de onda


// Toca um uma onda quadrada 
// Parametro: R0 - Periodo | R1 - Samples
// (Samples = tempo_intended(s) * 48000) <- depende do parametro do simulador
// Retorno: Nenhum
play_tone:
    push {r0, r1, r2, r3, r4, lr}
    ldr r2, =AUDIO_LEFT
    mov r3, #0                      // Counter
    mov r4, #0
play_tone_loop:
    str r4, [r2]                    // Escreve no canal esquerdo
    str r4, [r2, #4]                // Escreve no canal direito
    subs r1, r1, #1
    beq play_tone_exit
    add r3, r3, #1
    cmp r0, r3
    bne play_tone_loop
    cmp r4, #0
    ldreq r4, =0xFF000000
    ldrne r4, =0x0
    mov r3, #0
    b play_tone_loop
play_tone_exit:
    pop {r0, r1, r2, r3, r4, lr}
    mov pc, lr



// Toca um uma onda quadrada a um tempo e frequencia determinada, para cada vez que a bolinha vier a bater em algo
// Parametro: Nenhum
// Retorno: Nenhum
play_hit_fx:
    push {r0, r1, lr}
    ldr r0, =#100
    ldr r1, =#2000
    bl play_tone
    pop {r0, r1, lr}
    mov pc, lr


// Toca um uma onda quadrada a um tempo e frequencia determinada, para cada vez que alguem pontuar
// Parametro: Nenhum
// Retorno: Nenhum
play_point_fx:
    push {r0, r1, lr}
    ldr r0, =#100
    ldr r1, =#4000
    bl play_tone
    ldr r0, =#50
    ldr r1, =#4000
    bl play_tone
    pop {r0, r1, lr}
    mov pc, lr


