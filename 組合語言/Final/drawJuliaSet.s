.data

cX: .word 0
cY: .word 0
width0: .word 0
height0: .word 0
ptrToframe: .word 0

@---------arguments--------

@
@color: .short 0 @ short = hword
.equ maxIter, 255
.equ width, 640
.equ height, 480
out: .asciz "%p %p %p\n"

@---------variables---------

.global __aeabi_idiv
.text
.global drawJuliaSet @( int cX, int cY, int width, int height, int16_t (*frame)[FRAME_WIDTH] )
@ int16_t (*frame)[FRAME_WIDTH] ## (*frame) = frame[0]

drawJuliaSet:
    ldr r4, =cX
    ldr r5, =cY
    ldr r6, =width0
    ldr r7, =height0
    ldr r8, =ptrToframe

    str r0, [r4] @ cX
    str r1, [r5] @ cY
    str r2, [r6] @ width
    str r3, [r7] @ height
    str sp, [r8] @ frame
    sub sp, sp, #4 @???

    /* storing arguments */

    stmfd sp!, {lr}

    @ r4 for x, r5 for y, r6 for zx, r7 for zy

    mov r4, #0      @ x = 0
loop1:
    cmp r4, #width  @ cmp x with width
    bge end1        @ if r4(x) >= (width), for 1 end

    /* below are loop 2. */
    mov r5, #0      @ y = 0
loop2:
    cmp r5, #height @ cmp y with height
    bge end2        @ if r5(y) >= (height), for 2 end

  @ zx = 1500 * (x - (width>>1)) / (width>>1);
  
    mov r1, #width      @ r1 = width
    mov r1, r1, lsr #1  @ r1 = width>>1
    sub r0, r4, r1      @ r0 = x - (width>>1)
    ldr r2, =0x5dc      @ r2 = 0x5dc = 1500
    mul r0, r0, r2      @ r0 = 1500 * (x - (width>>1))
    bl __aeabi_idiv     @ r0(zx) = r0 / r1
    mov r6, r0          @ r6(zx) = 1500 * (x - (width>>1)) / (width>>1)

  @ zy = 1000 * (y - (height>>1)) / (height>>1);
    mov r1, #height     @ r1 = height
    mov r1, r1, lsr #1  @ r1 = height>>1
    sub r0, r5, r1      @ r0 = y - (height>>1)
    ldr r2, =0x3e8      @ r2 = 0x3e8 = 1000
    mul r0, r0, r2      @ r0 = 1000 * (y - (height>>1))
    bl __aeabi_idiv     @ r0 = r0 / r1
    mov r7, r0          @ r7(zy) = 1000 * (y - (height>>1)) / (height>>1)

    mov r8, #maxIter    @ r8(i) = 255

    /* below are loop3 */
loop3:
  @ loop3s conditions
  @ while ( zx * zx + zy * zy < 4000000 && i > 0 )
    mul r0, r7, r7
    mla r0, r6, r6, r0
    ldr r1, =4000000
    cmp r0, r1
    bge end3     @ if ge( r0 >= 4000000 ), end

    cmp r8, #0
    ble end3     @ if le( i <= 0 ), end

    /* if ( zx * zx + zy * zy < 4000000 && i > 0 ) do below */

  @ int tmp = (zx * zx - zy * zy)/1000 + cX;
    mul r0, r6, r6    @ r0 = r6(zx) * r6(zx)
    mul r1, r7, r7    @ r1 = r7(zy) * r7(zy)
    sub r0, r0, r1    @ r0 = r0(zx*zx) - r1(zy*zy)
    ldr r1, =1000
    bl __aeabi_idiv   @ r0 = r0(zx * zx - zy * zy) / r1(1000)
    ldr r1, =cX
    ldr r1, [r1]
    add r9, r0, r1    @ r9(tmp) = (zx * zx - zy * zy)/1000 + cX

  @ zy = (2 * zx * zy)/1000 + cY;
    mul r0, r6, r7      @ r0 = r6(zx) * r7(zy)
    mov r0, r0, lsl #1  @ r0 = r0(zx*zy) * 2
    ldr r1, =1000
    bl __aeabi_idiv     @ r0 = r0(2 * zx * zy) / r1(1000)
    ldr r1, =cY
    ldr r1, [r1]
    add r7, r0, r1      @ r7(zy) = (2 * zx * zy)/1000 + cY

    mov r6, r9      @ r6(zx) = r9(tmp)

    sub r8, r8, #1  @ i--
    b loop3

    /* above are loop 3 */
end3:

  @ color = ((i&0xff)<<8) | (i&0xff);
    ldr r0, =0xff
    and r0, r8, r0      @ r0 = r8(i) & 0xff
    mov r1, r0, lsl #8  @ r1 = (i&0xff)<<8
    orr r0, r0, r1      @ r0(color) = ((i&0xff)<<8) | (i&0xff)

  @ color = (~color)&0xffff;
    ldr r1, =0xffff
    mvn r0, r0          @ r0 = ~r0(color)
    and r0, r0, r1      @ r0(color) = (~color)&0xffff;

  @ frame[y][x] = color;
  @ int16_t (*frame)[FRAME_WIDTH] ## (*frame) = frame[0]
    ldr r1, =ptrToframe
    ldr r1, [r1]
	
    ldr r1, [r1]
    ldr r2, =1280         @ 2 (int16_t) * 640 (width)
    mul r2, r5, r2        @ y = y * 1280
    add r1, r1, r2        @ r1(frame[y]) , *(frame+y)
    mov r2, r4, lsl #1    @ x = x * 2
    strh r0, [r1, r2]     @ r1(frame[y][x]) = r0(color) ## a half word

    add r5, r5, #1   @ y++
    b loop2

    /* above are loop 2 */
end2:
    add r4, r4, #1   @ x++
    b loop1

    /* above are loop 1 */
end1:

    movge r0, r1
    addlt r0, r0, r1
    subne r0, r0, r2
    @sbcs r11, r0, r1 @ no use
    ldmfd sp!, {pc}  @ return
