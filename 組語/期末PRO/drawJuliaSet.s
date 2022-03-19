    .data
cX:      .word 0
cY:      .word 0
width:   .word 0
height:   .word 0
color:   .word 0
maxIter: .word 255
zx:      .word 0
zy:      .word 0
tmp:     .word 0
i:       .word 0
x:       .word 0
y:       .word 0
z:       .word 0
frame:   .word 0
test:    .asciz "%d\n"
    .text
    .globl drawJuliaSet
    .globl __aeabi_idiv
drawJuliaSet :

    ldr r4,=cX
    str r0,[r4] @cX

    ldr r4,=cY
    str r1,[r4] @cY

    ldr r4,=width   @width
    str r2,[r4]

    ldr r4,=height
    str r3,[r4] @height

    ldr r4,=frame
    str sp,[r4] @frame
    stmfd sp!,{lr,fp}

    mov r2,#0
    ldr r0,=x
    str r2,[r0] @x=0
loop:
    ldr r0,=x
    ldr r0,[r0]
    ldr r1,=width
    ldr r1,[r1]
    cmp r0,r1
    bge donex

    mov r2,#0
    ldr r0,=y
    str r2,[r0] @y=0

loop2:
    ldr r0,=y
    ldr r0,[r0]
    ldr r1,=height
    ldr r1,[r1]
    cmp r0,r1
    bge doney


    ldrlt r0,=x
    ldr r0,[r0]
    ldr r1,=width
    ldr r1,[r1]
    sublt r0,r0,r1,lsr #1    @x - width>>1
    ldr r2,=1500
    mul r0,r0,r2        @1500*x-width>>1
    ldr r1,=width
    ldr r1,[r1]
    ldr r2,=0
    add r1,r2,r1,lsr #1 @width>>1
    bl __aeabi_idiv @1500*x-width>>1 / width>>1
    ldr r1,=zx
    str r0,[r1] @zx = answer


    ldr r0,=y
    ldr r0,[r0]
    ldr r1,=height
    ldr r1,[r1]
    sub r0,r0,r1,asr #1
    ldr r2,=1000
    mul r0,r0,r2
    ldr r1,=height
    ldr r1,[r1]
    ldr r2,=0
    add r1,r2,r1,lsr #1
    bl __aeabi_idiv
    ldr r1,=zy
    str r0,[r1]


    ldr r0,=i
    ldr r0,[r0]
    ldr r1,=maxIter
    ldr r1,[r1]
    mov r0,r1
    ldr r1,=i
    str r0,[r1] @i = maxIter

loop3:
    ldr r0,=zx
    ldr r0,[r0]
    ldr r1,=zy
    ldr r1,[r1]
    mul r0,r0,r0
    mul r1,r1,r1
    add r0,r0,r1
    ldr r1,=i
    ldr r1,[r1]
    ldr r2,=4000000
    cmp r0,r2
    bge colorfuk
    cmplt r1,#0
    ble colorfuk


    ldr r0,=zx
    ldr r0,[r0]
    ldr r1,=zy
    ldr r1,[r1]
    mul r0,r0,r0    @zx*zx
    mul r1,r1,r1    @zy*zy
    sub r0,r0,r1    @zx*zx-zy*zy
    ldr r1,=1000
    bl __aeabi_idiv @zx*zx-zy*zy/1000
    ldr r1,=cX
    ldr r1,[r1]
    add r0,r0,r1    @zx*zx-zy*zy/1000 + cX
    ldr r1,=tmp
    str r0,[r1]     @tmp = zx*zx-zy*zy/1000 + cX

    ldr r0,=zx
    ldr r0,[r0]
    ldr r1,=zy
    ldr r1,[r1]
    mul r0,r0,r1    @zx * zy
    ldr r2,=2
    mul r0,r0,r2
    ldr r1,=1000    @2*zx*zy
    bl __aeabi_idiv     @2*zx*zy/1000
    ldr r1,=cY
    ldr r1,[r1]
    add r0,r0,r1    @2*zx*zy/1000 + cY
    ldr r1,=zy
    str r0,[r1]     @zy = 2*zx*zy/1000 + cY


    ldr r0,=zx
    ldr r1,=tmp
    ldr r1,[r1]
    str r1,[r0]     @zx = tmp


    ldr r0,=i
    ldr r0,[r0]
    sub r0,r0,#1
    ldr r1,=i
    str r0,[r1]     @i--

    b loop3


colorfuk:
    ldr r0,=i
    ldr r0,[r0]
    ldr r1,=0xff
    and r0,r0,r1
    orr r0,r0,r0,lsl #8
    ldr r1,=color
    str r0,[r1]    @color = ((i&0xff)<<8|i&0xff

    ldr r0,=color
    ldr r0,[r0]
    mvn r0,r0
    ldr r1,=0xffff
    and r0,r0,r1
    ldr r1,=color
    str r0,[r1]    @color = (~color)&0xffff

    ldr r0,=frame
    ldr r0,[r0]
    ldr r0,[r0]
    ldr r1,=y
    ldr r1,[r1]
    ldr r4,=1280
    mul r1,r1,r4
    add r0,r0,r1
    ldr r2,=x
    ldr r2,[r2]
    ldr r4,=2
    mul r2,r2,r4
    add r0,r0,r2
    ldr r4,=color
    ldr r4,[r4]
    strh r4,[r0]    @frame[y][x] = color


    ldr r0,=y
    ldr r0,[r0]
    add r0,r0,#1
    ldr r1,=y
    str r0,[r1]

    b loop2    @y<width ; y++

doney:
    ldr r2,=x
    ldr r2,[r2]
    add r2,r2,#1
    ldr r4,=x
    str r2,[r4]

    b loop   @x < height ; x++

donex:
    sbcs r11,r0,r1
    ldmfd sp!, {lr,fp}
    mov pc, lr
