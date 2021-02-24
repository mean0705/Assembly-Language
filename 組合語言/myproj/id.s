    .data
end_print: .asciz      "*****End Print*****\n"
title0:     .asciz      "*****Input ID*****\n"
title1:     .asciz      "**Please Enter Member 1 ID:**\n"
title2:     .asciz      "**Please Enter Member 2 ID:**\n"
title3:     .asciz      "**Please Enter Member 3 ID:**\n"
title4:     .asciz      "*****Print Team Member ID and ID Summation*****\n"
title5:     .asciz      "** Please Enter Command **\n"
format_d:   .asciz      "%d"
format_c:   .asciz      "%c"
outputID:   .asciz      "ID: %d\n"
outputSUM:  .asciz      "ID Summation: %d\n"
NO1:        .word       0
NO2:        .word       0
NO3:        .word       0
SUM:        .word       0
COMMAND:    .word       0

    .text
    .globl id
    .globl NO1
    .globl NO2
    .globl NO3
    .globl SUM
    .globl outputSUM

id:
    stmfd       sp!,{lr}
@print title
    ldr         r0,=title0
    bl          printf
@first info prompt
    ldr         r0,=title1
    bl          printf
@first info scanf
    ldr         r0,=format_d
    ldr         r1,=NO1
    bl          scanf
@second info prompt
    ldr         r0,=title2
    bl          printf
@second info scanf
    ldr         r0,=format_d
    ldr         r1,=NO2
    bl          scanf
@third info prompt
    ldr         r0,=title3
    bl          printf
@third info scanf
    ldr         r0,=format_d
    ldr         r1,=NO3
    bl          scanf
@title before print
    ldr         r0,=title4
    bl          printf
@print input command prompt
    ldr         r0,=title5
    bl          printf

scan_cmd:
@scanf for command
    ldr         r0,=format_c
    ldr         r1,=COMMAND
    bl          scanf
@if
    ldr         r0,=COMMAND
    ldr         r0,[r0]
    cmp         r0,#'p'
    bne         scan_cmd
@first info printf
    ldr         r0,=outputID
    ldr         r1,=NO1
    ldr         r1,[r1]
    bl          printf
@second info printf
    ldr         r0,=outputID
    ldr         r1,=NO2
    ldr         r1,[r1]
    bl          printf
@third info printf
    ldr         r0,=outputID
    ldr         r1,=NO3
    ldr         r1,[r1]
    bl          printf
@add
    ldr         r0,=outputSUM
    ldral       r1,=NO1
    ldral       r1,[r1]
    ldrhs       r2,=NO2
    ldrhs       r2,[r2]
    addpl       r1,r1,r2
    ldr         r2,=NO3
    ldr         r2,[r2]
    addpl       r1,r1,r2
    ldrvc       r3,=SUM
    strvc       r1,[r3]
    blvc        printf
@end print
    ldr         r0,=end_print
    bl          printf

    @bl          return2
    mov         r0,#0
    ldmfd       sp!,{lr}
    mov         pc,lr

