.data
str0I: .asciz "*****Input ID*****\n"
str1I: .asciz "** Please Enter Member 1 ID:** \n"
str2I: .asciz "** Please Enter Member 2 ID:** \n"
str3I: .asciz "** Please Enter Member 3 ID:** \n"
str4I: .asciz "** Please Enter Command [q]:exit**\n"
str5I: .asciz "*****Print Team Member ID and ID Summation*****\n"

error: .asciz "command does not exit !\n"

scanInt: .asciz "%d"
scanStr: .asciz "%s"
Summation: .asciz "\nID Summation = %d\n"
IDs: .asciz "%d\n%d\n%d\n"

buffer: .space 128
.globl num1
.globl num2
.globl num3
.globl sum
num1: .word 0
num2: .word 0
num3: .word 0
sum: .word 0

.equ p, 'p'
.equ q, 'q'

.text
.global ID
ID:
	stmfd sp!,{lr}	    /* push lr onto stack */
    ldr r0, =str0I
    bl printf           /* calling printf */

	ldr r0, =str1I
	bl printf

    ldr r0, =scanInt     /* loading first parameter of scanf */
    ldr r1, =num1        /* location to write data from input */
    bl scanf             /* calling scanf */

	ldr r0, =str2I
	bl printf

    ldr r0, =scanInt     /* loading first parameter of scanf */
    ldr r1, =num2        /* location to write data from input */
    bl scanf             /* calling scanf */

	ldr r0, =str3I
	bl printf

	ldr r0, =scanInt     /*loading first parameter of scanf*/
    ldr r1, =num3        /* location to write data from input */
    bl scanf             /*calling scanf*/

	ldr r4, =num1    /* load address of num1 to r4 */
	ldr r5, =num2    /* load address of num2 to r5 */
	ldr r6, =num3    /* load address of num3 to r6 */
	ldr r4, [r4]     /* load num1 to r4 */
	ldr r5, [r5]     /* load num2 to r5 */
	ldr r6, [r6]     /* load num3 to r6 */

	addhs r7, r4, r5    /* if c flag was set (hs) , r7 = r4 + r5 + carry */
	adclos r7, r4, r5   /* if c flag was not set (lo) , r7 = r4 + r5 + carry, and change CPSR*/
	add r7, r7, r6      /* r7 = r4 + r6 */
	ldr r8, =sum        /* load the address of sum to r8 */
	str r7, [r8]        /* store sum (r7) in memory */
input:
    ldr r0, =str4I
    bl printf

	ldr r0, =scanStr     /* loading first parameter of scanf */
    ldr r1, =buffer      /* location to write data from input */
    bl scanf             /* calling scanf */

	ldr r8, =buffer     /* load the address of buffer to r8*/
	ldr r8, [r8]        /* load the content of buffer to r8*/

	cmp r8, #p          /* compare r8 to 'p' */
	bne notP     /* if z not set (ne), than skip the following */
	/* if command == p, do below */
	ldr r0, =IDs
	mov r1, r4
	mov r2, r5
	mov r3, r6
    bl printf

	ldr r0, =Summation
	mov r1, r7
    bl printf

	ldr r0, =ENDP
	bl printf
	b end
    /* if not p do below */
notP:
	cmp r8, #q          /* compare r8 to 'q' */
	bne notQ    @ not q
	b end       @ is q
notQ:
    ldr r0, =error
	bl printf
	b input
end:
	ldmfd sp!,{lr}   /* push lr from stack */
    mov pc,lr

