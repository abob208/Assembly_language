    .data
Main:   .asciz "Main Function:\n"
Print:  .asciz "*****Print All*****\n"
    .text
    .global main
main:
    stmfd sp!,{lr}
    bl Name
    bl ID
    ldr r0,=Main
    bl printf
    ldr r0,=Print
    bl printf
    ldr r0,=team
    bl printf
    ldr r0,=number
    ldr r1,=num
    ldr r1,[r1]
    bl printf
    ldr r0,=name
    bl printf

    ldr r0,=number
    ldr r1,=num2
    ldr r1,[r1],#0
    bl printf
    ldr r0,=name2
    bl printf


    ldr r0,=number
    ldr r1,=num3
    ldr r1,[r1,#0]
    bl printf
    ldr r0,=name3
    bl printf

    ldr r0,=output
    ldr r1,=total
    ldr r1,[r1]!
    bl printf
    ldr r0,=End
    bl printf
    ldmfd sp!, {lr}
    mov pc,lr
