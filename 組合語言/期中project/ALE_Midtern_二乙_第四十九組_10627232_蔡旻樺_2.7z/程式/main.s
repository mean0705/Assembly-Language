
.data
str1: .asciz "Function1: Name\n"
str2: .asciz "Function1: ID\n"
str3: .asciz "\nMain Function:\n*****Print All*****\n"

outStr1: .asciz "%d  "
outStr2: .asciz "ID Summation = %d\n"
.global ENDP
ENDP: .asciz "*****End Print***** \n\n"
.text
.global main
main:
	stmfd sp!,{lr}  /* push lr onto stack */

	ldr r0, =str1
	bl printf
	bl NAME         /* call NAME function */

	ldr r0, =str2
	bl printf
	bl ID           /* call ID function */

	ldr r0, =str3
	bl printf

	ldr r0, =Team
	bl printf
	ldr r4, =num1    /* load address of num1 to r4 */
	ldr r5, =num2    /* load address of num2 to r5 */
	ldr r6, =num3    /* load address of num3 to r6 */
	ldr r4, [r4]     /* load num1 to r4 */
	ldr r5, [r5]     /* load num2 to r5 */
	ldr r6, [r6]     /* load num3 to r6 */

	/* below is for printing ids and names */
	ldr r0, =outStr1
	mov r1, r4
	bl printf
	ldr r0, =Name1
	bl printf

	ldr r0, =outStr1
	mov r1, r5
	bl printf
	ldr r0, =Name2
	bl printf

	ldr r0, =outStr1
	mov r1, r6
	bl printf
	ldr r0, =Name3
	bl printf
	/* above is for printing ids and names */

	ldr r0, =outStr2
	ldr r7, =sum
	ldr r7, [r7]
	mov r1, r7
	bl printf  /* print out ID summantion */

	ldr r0, =ENDP
	bl printf

    ldr r4, =ENDP      /* no use */
    ldr r5, [r4]!      /* no use */
    ldr r5, [r4], #1   /* no use */

	ldmfd sp!,{lr}     /* pop lr from stack */
	mov pc,lr
