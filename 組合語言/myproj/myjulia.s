    .data
maxIter:    .word       255
zx:         .word       0
zy:         .word       0
tmp:        .word       0
x:          .word       0
y:          .word       0
i:          .word       0
temp:       .word       0
frame:      .word       0
cX:         .word       0
cY:         .word       0
width:      .word       0
height:     .word       0
formatx:    .asciz     "x: %d  "


    .text
    .globl myjulia


myjulia:
@save frame
    ldr         r4,=frame
    str         sp,[r4]


@save cX argument
    ldr         r4,=cX
    str         r0,[r4]

@save cY argument
    ldr         r4,=cY
    str         r1,[r4]
@save width argument
    ldr         r4,=width
    str         r2,[r4]
@save height argument
    ldr         r4,=height
    str         r3,[r4]

    stmfd       sp!,{lr}
	
@for debugging
ldr r0,=formatx
ldr r1,=cX
ldr r1,[r1]
bl  printf

@go into first loop?
    ldr         r0,=x
    ldr         r0,[r0]
    ldr         r1,=width
    ldr         r1,[r1]
    cmp         r0,r1
    bllt        firstloop


firstloop:

@go into second loop?
    ldr         r0,=y
    ldr         r0,[r0]
    ldr         r1,=height
    ldr         r1,[r1]
    cmp         r0,r1
    bllt        secondloop

secondloop:

@set zx
    ldr         r0,=x
    ldr         r0,[r0]
    ldr         r1,=width
    ldr         r1,[r1]
    mov         r1,r1,lsr #1
    sub         r0,r0,r1
    bl          __aeabi_idiv
    ldr         r1,=1500
    mul         r0,r0,r1
    ldr         r1,=zx
    str         r0,[r1]
@set zy
    ldr         r0,=y
    ldr         r0,[r0]
    ldr         r1,=height
    ldr         r1,[r1]
    mov         r1,r1,lsr #1
    sub         r0,r0,r1
    bl          __aeabi_idiv
    ldr         r1,=1000
    mul         r0,r0,r1
    ldr         r1,=zy
    str         r0,[r1]

@set i
    ldr         r0,=i
    ldr         r1,=maxIter
    ldr         r1,[r1]
    str         r1,[r0]


@go into third loop?
    ldr         r0,=zx
    ldr         r0,[r0]
    ldr         r1,=zy
    ldr         r1,[r1]
    mul         r0,r0,r0
    mul         r1,r1,r1
    add         r0,r0,r1
    ldr         r1,=4000000
    ldr         r2,=i
    ldr         r2,[r2]
    ldr         r3,=0
    cmp         r0,r1
    blge        set_color_and_frame
    cmp         r2,r3
    blle        set_color_and_frame
    bl          thirdloop


thirdloop:
@initilize temp
    ldr         r0,=temp
    ldr         r1,=0
    str         r1,[r0]
@cal temp
    ldr         r0,=zx
    ldr         r0,[r0]
    ldr         r1,=zy
    ldr         r1,[r1]
    mul         r0,r0,r0
    mul         r1,r1,r1
    sub         r0,r0,r1
    ldr         r1,=1000
    bl          __aeabi_idiv
    ldr         r1,=cX
    ldr         r1,[r1]
    add         r0,r0,r1
    ldr         r1,=temp
    str         r0,[r1]
@cal zy
    ldr         r0,=zx
    ldr         r0,[r0]
    ldr         r1,=zy
    ldr         r1,[r1]
    mul         r0,r0,r1
    ldr         r1,=2
    mul         r0,r0,r1
    ldr         r1,=1000
    bl          __aeabi_idiv
    ldr         r1,=cY
    ldr         r1,[r1]
    add         r0,r0,r1
    ldr         r1,=zy
    str         r0,[r1]
@cal zx
    ldr         r0,=temp
    ldr         r0,[r0]
    ldr         r1,=zx
    str         r0,[r1]
@i--
    ldr         r0,=i
    ldr         r0,[r0]
    sub         r0,r0,#1
    ldr         r1,=i
    str         r0,[r1]

@go into third loop?
    ldr         r0,=zx
    ldr         r0,[r0]
    ldr         r1,=zy
    ldr         r1,[r1]
    mul         r0,r0,r0
    mul         r1,r1,r1
    add         r0,r0,r1
    ldr         r1,=4000000
    ldr         r2,=i
    ldr         r2,[r2]
    ldr         r3,=0
    cmp         r0,r1
    blge        set_color_and_frame
    cmp         r2,r3
    blle        set_color_and_frame
    bl          thirdloop

set_color_and_frame :
    ldr         r0,=i
    ldr         r0,[r0]
    and         r0,#0xff
    orr         r0,r0,r0, lsl#8
    mvn         r0,r0

    ldr         r2,=x
    ldr         r2,[r2]
    ldr         r3,=y
    ldr         r3,[r3]

    ldr         r1,=640
    mul         r1,r1,r3
    add         r1,r1,r2
    mov         r1,r1,lsl#1

    ldr         r2,=frame
    ldr         r2,[r2]
    strh        r0,[r2,r1]
@second loop y++
    ldr         r0,=y
    ldr         r0,[r0]
    add         r0,r0,#1
    ldr         r1,=y
    str         r0,[r1]
@go into second loop?
    ldr         r0,=y
    ldr         r0,[r0]
    ldr         r1,=height
    ldr         r1,[r1]
    cmp         r0,r1
    bllt        secondloop

@first loop x++ and y = 0
    ldr         r0,=x
    ldr         r0,[r0]
    add         r0,r0,#1
    ldr         r1,=x
    str         r0,[r1]
    ldr         r0,=y
    mov         r1,#0
    str         r1,[r0]


@go into first loop?
    ldr         r0,=x
    ldr         r0,[r0]
    ldr         r1,=width
    ldr         r1,[r1]
    cmp         r0,r1
    bllt        firstloop

    mov         r0,#0
    ldmfd       sp!,{lr}
    mov         pc,lr


