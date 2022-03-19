    .data
F:      .asciz "Function1: Name\n*****Print Name*****\n"
End:    .asciz "*****End Print*****\n\n"
team:   .asciz "Team46\n"
name:   .asciz "Chen Shou-Lun\n"
name2:  .asciz "Tsai Peng-Ying\n"
name3:  .asciz "Wang You-Chi\n"
    .text
    .globl team
    .globl name
    .globl name2
    .globl name3
    .globl Name
    .globl End
Name:
    stmfd sp!,{lr}
    ldr r0,=F
    bl printf
    ldr r0,=team
    bl printf
    ldr r0,=name
    bl printf
    ldr r0,=name2
    bl printf
    ldr r0,=name3
    bl printf
    ldr r0,=End
    bl printf
    adcs r0,r1,r2
    ldmfd sp!, {lr}
    movhs pc, lr
