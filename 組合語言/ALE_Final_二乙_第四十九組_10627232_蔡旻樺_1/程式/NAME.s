	.data
str1N: .asciz "*****Print Name*****\n"
.global Team
.global Name1
.global Name2
.global Name3
Team: .asciz "Team 49\n"
Name1:.asciz "Mean Tsai\n"
Name2:.asciz "Green Wu\n"
Name3:.asciz "Will Tsai\n"

	.text
	.global NAME

NAME:
	stmfd sp!,{lr}  /* push lr onto stack */
	ldr r0, =str1N
	bl printf

	ldr r0, =Team
	bl printf

	ldr r0, =Name1
	bl printf

	ldr r0, =Name2
	bl printf

	ldr r0, =Name3
	bl printf

	ldr r0, =ENDP
	bl printf

	ldmfd sp!,{pc}  /* push lr from stack */
