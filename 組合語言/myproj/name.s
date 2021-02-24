    .data
end_print: .asciz      "*****End Print*****\n"
name_title: .asciz      "*****Print Name*****\n"
group:      .asciz      "Team handsome\n"
name1:      .asciz      "Kuanyu Chen\n"
name2:      .asciz      "Chinrong Chen\n"
name3:      .asciz      "Ian Hong\n"
    .globl name
    .globl name1
    .globl name2
    .globl name3
    .globl group
    .text
name:
    stmfd       sp!,{lr}
@print title
    ldr         r0,=name_title
    bl          printf
@print group
    ldr         r0,=group
    bl          printf
@print name1
    ldr         r0,=name1
    bl          printf
@print name2
    ldr         r0,=name2
    bl          printf
@print name3
    ldr         r0,=name3
    bl          printf
@end print
    ldr         r0,=end_print
    bl          printf
@adcs
    adcs        r0,r1,r2

    @bl          return1
    mov         r0,#0
    ldmfd       sp!,{lr}
    mov         pc,lr


