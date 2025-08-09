    .syntax unified
    .cpu cortex-a8
    .text

.global asm_add
asm_add:
    add r0, r0, r1
    bx lr

.global asm_sub
asm_sub:
    sub r0, r0, r1
    bx lr

.global asm_mul
asm_mul:
    mov r2, r0        
    mul r0, r2, r1    
    bx lr

.global asm_div
asm_div:
    cmp r1, #0
    beq .div_by_zero_zero_return

    mov r12, #0
    cmp r0, #0
    movlt r12, #1      
    cmp r1, #0
    eorlt r12, r12, #1 

    mov r2, r0
    cmp r0, #0
    rsblt r2, r0, #0   
    mov r3, r1
    cmp r1, #0
    rsblt r3, r1, #0

    mov r4, #0      
    mov r5, #0      
    mov r6, #32     

.div_loop:
    mov r7, r2, lsr #31
    add r5, r5, r5
    add r5, r5, r7
    cmp r5, r3
    movge r7, #1
    movlt r7, #0
    subge r5, r5, r3

    add r4, r4, r4
    orr r4, r4, r7

    mov r2, r2, lsl #1
    subs r6, r6, #1
    bne .div_loop

    cmp r12, #0
    beq .div_done
    rsb r4, r4, #0    

.div_done:
    mov r0, r4
    bx lr

.div_by_zero_zero_return:
    mov r0, #0
    bx lr
