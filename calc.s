    .syntax unified
    .cpu cortex-a8
    .text

    /* int asm_add(int a, int b) */
    .global asm_add
asm_add:
    add r0, r0, r1
    bx lr

    /* int asm_sub(int a, int b) */
    .global asm_sub
asm_sub:
    sub r0, r0, r1
    bx lr

    /* int asm_mul(int a, int b)  -- ensure Rd and Rm are different */
    .global asm_mul
asm_mul:
    mov r2, r0        /* temp = a */
    mul r0, r2, r1    /* r0 = temp * b */
    bx lr

    /* int asm_div(int a, int b) - software signed division
       Inputs: r0 = dividend (signed), r1 = divisor (signed)
       Output: r0 = quotient (signed)
       Note: Caller should check division by zero if desired.
    */
    .global asm_div
asm_div:
    /* Check divisor == 0 -> return 0 (caller can detect) */
    cmp r1, #0
    beq .div_by_zero_zero_return

    /* Compute sign = (a < 0) XOR (b < 0) in r12 (0 or 1) */
    mov r12, #0
    cmp r0, #0
    movlt r12, #1      /* r12 = 1 if a < 0 */
    cmp r1, #0
    eorlt r12, r12, #1 /* if b<0 then r12 ^= 1  (conditional eor) */

    /* Get absolute values into r2 (dividend) and r3 (divisor) */
    /* abs dividend -> r2 */
    mov r2, r0
    cmp r0, #0
    rsblt r2, r0, #0   /* if negative: r2 = -r0  (rsb with cond) */
    /* abs divisor -> r3 */
    mov r3, r1
    cmp r1, #0
    rsblt r3, r1, #0

    /* Now unsigned divide: compute q = r2 / r3 (both >=0) using shift-subtract.
       We'll implement classic restoring division:
       rem = 0
       for i = 31 downto 0:
         rem = rem << 1
         rem |= (r2 >> 31)
         r2 <<= 1
         if rem >= r3:
             rem -= r3
             q = (q << 1) | 1
         else
             q = (q << 1)
    */
    mov r4, #0      /* quotient */
    mov r5, #0      /* remainder */
    mov r6, #32     /* loop counter */

.div_loop:
    /* extract MSB of dividend (r2 >> 31) into r7 */
    mov r7, r2, lsr #31

    /* rem <<= 1 */
    add r5, r5, r5

    /* rem |= msb */
    add r5, r5, r7

    /* compare rem and divisor */
    cmp r5, r3
    /* if rem >= r3, subtract and set bit = 1 */
    movge r7, #1
    movlt r7, #0
    subge r5, r5, r3   /* rem -= r3 when rem >= r3 */

    /* q <<= 1 */
    add r4, r4, r4
    /* q |= bit */
    orr r4, r4, r7

    /* shift dividend left by 1 for next bit */
    mov r2, r2, lsl #1

    /* decrement loop counter */
    subs r6, r6, #1
    bne .div_loop

    /* Apply sign if needed */
    cmp r12, #0
    beq .div_done
    rsb r4, r4, #0     /* negate quotient if sign==1 */

.div_done:
    mov r0, r4
    bx lr

.div_by_zero_zero_return:
    mov r0, #0
    bx lr
