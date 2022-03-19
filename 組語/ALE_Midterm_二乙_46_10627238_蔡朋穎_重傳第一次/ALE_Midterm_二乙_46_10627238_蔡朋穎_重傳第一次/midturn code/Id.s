    .data
F2:     .asciz "Function2: ID\n*****Input ID*****\n"
ask:    .asciz "**Please Enter Member 1 ID:**\n"
ask2:    .asciz "**Please Enter Member 2 ID:**\n"
ask3:    .asciz "**Please Enter Member 3 ID:**\n"
ask4:   .asciz "**Please Enter Command**\n"
title:  .asciz "*****Print Team Member ID and ID Summation*****\n"
number:    .asciz "%d"
numberjump: .asciz "%d\n"
char:   .word 0
userinput:  .asciz " %c"
num:    .word 0
num2:   .word 0
num3:   .word 0
total:  .word 0
output:  .asciz "ID Summation = %d\n"
    .text
    .global ID
    .global num
    .global num2
    .global num3
    .global number
    .global total
    .global output
ID:
        stmfd sp!,{lr}
        ldr r0,=F2
        bl printf
        ldr r0,=ask
        bl printf
        ldr r0, =number
        ldr r1, =num
        bl scanf

        ldr r0,=ask2
        bl printf
        ldr r0, =number
        ldr r1, =num2
        bl scanf

        ldr r0,=ask3
        bl printf
        ldr r0, =number
        ldr r1, =num3
        bl scanf

loop:
        ldr r0,=ask4
        bl printf
        ldr r0,=userinput
        ldr r1,=char
        bl scanf
        ldr r0,=char
        ldr r0,[r0]
        cmp r0, #'p'
        bne loop



        ldr r0,=title
        bl printf
        ldr r0,=numberjump
        ldr r1,=num
        ldr r1,[r1]
        bl printf
        ldr r0,=numberjump
        ldr r1,=num2
        ldr r1,[r1]
        bl printf
        ldr r0,=numberjump
        ldr r1,=num3
        ldr r1,[r1]
        bl printf
        ldr r0,=output
        ldr r1,=num
        ldr r1,[r1]
        ldr r2,=num2
        ldr r2,[r2]
        ldr r3,=num3
        ldr r3,[r3]
        addal r1, r1, r2
        addvc r1, r1, r3
        ldr r2,=total
        str r1,[r2]
        bl printf
        ldr r0,=End
        bl printf
        ldmfd sp!, {lr}
        mov pc,lr
