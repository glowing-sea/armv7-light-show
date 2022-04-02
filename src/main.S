.syntax unified
.global main

.type main, %function
main:

@======================== ENCODINGS ========================@

  ldr r1, =0x4000D000
  ldr r2, [r1]
  mov r2, 1
  str r2, [r1] @ Open Random Number Generator (RNG)


  @ SCENE 1: Twinkling Heart
  ldr r1, =0b01010101011000101010001000001111
  ldr r2, =0b01010101011000101010001001111110
  mov r3, 4
  bl twinkling


  @ SCENE 2: Jupiter Arrows
  ldr r0, =0b00000000000000000000000000000101 @ Arrow 1 starts
  bl display
  ldr r0, =0b00000000001000000000000000000101
  bl display
  ldr r0, =0b00000100001100010000000000000101
  bl display
  ldr r0, =0b00000010001110001000000000000101
  bl display
  ldr r0, =0b00000001001111000100000000000101
  bl display
  ldr r0, =0b00000000101111100010000000000101
  bl display
  ldr r0, =0b00000000010111100001000000000101
  bl display
  ldr r0, =0b00000000000011100000000000000101
  bl display
  ldr r0, =0b00000000000001100000000000000101
  bl display
  ldr r0, =0b00000000000000100000000000000101
  bl display
  ldr r0, =0b00000000000000000000000000000101 @ Arrow 1 ends
  bl display
  ldr r0, =0b00000000000000000000000000000101 @ Arrow 2 starts
  bl display
  ldr r0, =0b00001000000000000000000000000101
  bl display
  ldr r0, =0b00011000110000000000000000000101
  bl display
  ldr r0, =0b00001001100011000000000000000101
  bl display
  ldr r0, =0b00001000100110001100000000000101
  bl display
  ldr r0, =0b00001000100010011000110000000101
  bl display
  ldr r0, =0b00000000100010001000100000000101
  bl display
  ldr r0, =0b00000000000010001000100000000101
  bl display
  ldr r0, =0b00000000000000001000100000000101
  bl display
  ldr r0, =0b00000000000000000000100000000101
  bl display
  ldr r0, =0b00000000000000000000000000010001 @ Arrow 2 ends
  bl display
  ldr r0, =0b01010101011000101010001000011111 @ Arrow 3 starts
  bl display
  ldr r0, =0b11010101011000101010001000000101
  bl display
  ldr r0, =0b11010111011000101010001000000101
  bl display
  ldr r0, =0b11010111011110101010001000000101
  bl display
  ldr r0, =0b11010111011011101110001000000101
  bl display
  ldr r0, =0b11010111011010101011001110000101
  bl display
  ldr r0, =0b01010111011010101010001010000101
  bl display
  ldr r0, =0b01010101011010101010001010000101
  bl display
  ldr r0, =0b01010101011000101010001010000101
  bl display
  ldr r0, =0b01010101011000101010001010000101
  bl display
  ldr r0, =0b01010101011000101010001000000101 @ Arrow 3 ends
  bl display


  @ SCENE 3: Blinking Heart (4 times)
  ldr r1, =0b01010101011000101010001000011110
  ldr r2, =0b00000000000000000000000000011110
  mov r3, 8
  bl twinkling
  mov r4, 0x300000 @ Set delay time to roughly 1s
  bl delay


  @ SCENE 4: A Greeting Couple (4 times)
  begin_for_2:
    movs r5, 2
  loop_2:
    beq rest_of_program_2

    @ Top Right
    ldr r1, =0b00011000010000000000000000011110
    ldr r2, =0b00000000000000000000000000011110
    mov r3, 8
    bl twinkling
    bl delay

    @ Bottom Left
    ldr r1, =0b00000000000000010000110000011110
    ldr r2, =0b00000000000000000000000000011110
    mov r3, 8
    bl twinkling
    bl delay

    subs r5, 1
    b loop_2
  rest_of_program_2:


  @ SCENE 5: A Couple walks together
  ldr r0, =0b00011000010000000000000000001111
  bl display
  ldr r0, =0b00011000010000010000110000001111
  bl display
  ldr r0, =0b00000001100001010000110000001111
  bl display
  ldr r0, =0b00000001100101001100000000001111
  bl display
  ldr r0, =0b00000000000110001100000000001111
  bl display
  ldr r0, =0b00000000000010000000000000001111
  bl display
  ldr r0, =0b00000001000101000100000000000111
  bl display
  ldr r0, =0b00100010101000101010001000000111
  bl display
  ldr r0, =0b01010100010000010001010100000111
  bl display
  ldr r0, =0b10001000000000000000100010000111
  bl display
  ldr r0, =0b00000000000000000000000000001111
  bl display
  bl delay


  @ SCENE 6: Meteors (Compressed Encoding)
  begin_for_1:
    movs r5, 4
  loop_1:
    beq rest_of_program_1
    ldr r1, =0x4000D000
    ldr r1, [r1, 0x508] @ get a random number
    mov r2, 5 @ set divisor
    bl modulus @ get r1 % 5
    @ r1 saves a random number between 0 and 4

    case_expression:
      tbb [pc, r1]
    branchtable:
      .byte (case0 - branchtable) /2
      .byte (case1 - branchtable) /2
      .byte (case2 - branchtable) /2
      .byte (case3 - branchtable) /2
      .byte (case4 - branchtable) /2
      .align
    case0:
      @ Meteor 1
      mov r0, 5
      bl display
      bl display
      orr r0, 1 << 29
      bl display
      orr r0, 1 << 25
      bl display
      orr r0, 1 << 21
      bl display
      bic r0, 1 << 29
      bl display
      bic r0, 1 << 25
      bl display
      bic r0, 1 << 21
      bl display
      bl display
      b exit_case
    case1:
      @ Meteor 2
      mov r0, 5
      bl display
      bl display
      orr r0, 1 << 28
      bl display
      orr r0, 1 << 24
      bl display
      orr r0, 1 << 20
      bl display
      orr r0, 1 << 16
      bic r0, 1 << 28
      bl display
      bic r0, 1 << 24
      bl display
      bic r0, 1 << 20
      bl display
      bic r0, 1 << 16
      bl display
      b exit_case
    case2:
      @ Meteor 3
      mov r0, 5
      bl display
      orr r0, 1 << 27
      bl display
      orr r0, 1 << 23
      bl display
      orr r0, 1 << 19
      bl display
      orr r0, 1 << 15
      bic r0, 1 << 27
      bl display
      orr r0, 1 << 11
      bic r0, 1 << 23
      bl display
      bic r0, 1 << 19
      bl display
      bic r0, 1 << 15
      bl display
      bic r0, 1 << 11
      bl display
      b exit_case
    case3:
      @ Meteor 4
      mov r0, 5
      bl display
      bl display
      orr r0, 1 << 22
      bl display
      orr r0, 1 << 18
      bl display
      orr r0, 1 << 14
      bl display
      orr r0, 1 << 10
      bic r0, 1 << 22
      bl display
      bic r0, 1 << 18
      bl display
      bic r0, 1 << 14
      bl display
      bic r0, 1 << 10
      bl display
      b exit_case
    case4:
      @ Meteor 5
      mov r0, 5
      bl display
      bl display
      orr r0, 1 << 17
      bl display
      orr r0, 1 << 13
      bl display
      orr r0, 1 << 9
      bl display
      bic r0, 1 << 17
      bl display
      bic r0, 1 << 13
      bl display
      bic r0, 1 << 9
      bl display
      bl display
      b exit_case
    exit_case:

    mov r4, 0x1000000
    bl delay
    subs r5, 1
    b loop_1
  rest_of_program_1:


  @ SCENE 7: Shining Stars (Generated)
  begin_for_3:
    ldr r1, =0x4000D000
    ldr r1, [r1, 0x508] @ get a real random number as a seed
    movs r5, 12 @ counter
    movs r7, 3 @ sub-counter
  loop_3:
    beq rest_of_program_3
    ldr r0, =0b00000000000000000000000001111110
    @ set up a Linear Congruential Generator, parameters a, c, and m by (Sinclair Research 1981)
    ldr r2, =65537 @ m
    ldr r3, =75 @ a
    ldr r4, =74 @ c
    mul r1, r3
    add r1, r4
    bl modulus @ x = (a * x + c) % m
    mov r8, r1 @ make a copy of x as modulus will overwrite r1
    mov r2, 25
    bl modulus @ r1 is now a random number between 0 - 24
    push {r1} @ push r1 into the stack
    mov r1, r8 @ restore x
    subs r7, 1
    beq show_stars
    subs r5, 1
    b loop_3
  show_stars:
    ldr r6, =0b10000000
    pop {r7}
    lsl r6, r7
    orr r0, r6 @ randomly light one of the 25 LEDs
    ldr r6, =0b10000000
    pop {r7}
    lsl r6, r7
    orr r0, r6 @ randomly light one of the 25 LEDs
    ldr r6, =0b10000000
    pop {r7}
    lsl r6, r7
    orr r0, r6 @ randomly light one of the 25 LEDs
    bl display
    bic r0, 0b1101010 @ change speed
    orr r0, 1 @ bright
    bl display
    bic r0, 1 @ dim
    orr r0, 0b1101010 @ change speed
    bl display
    push {r4}
    mov r4, 0x300000 @ Set delay time to roughly 1s
    bl delay
    pop {r4}
    movs r7, 3
    subs r5, 1
    b loop_3
  rest_of_program_3:


  @ SCENE 8: Spiral (Compressed Encoding)
  mov r0, 5
  bl display
  orr r0, 1 << 11
  bl display
  orr r0, 1 << 16
  bl display
  orr r0, 1 << 21
  bl display
  orr r0, 1 << 26
  bl display
  orr r0, 1 << 31
  bl display
  orr r0, 1 << 30
  bl display
  orr r0, 1 << 29
  bl display
  orr r0, 1 << 28
  bl display
  orr r0, 1 << 27
  bl display
  orr r0, 1 << 22
  bl display
  orr r0, 1 << 17
  bl display
  orr r0, 1 << 12
  bl display
  orr r0, 1 << 7
  bl display
  orr r0, 1 << 8
  bl display
  orr r0, 1 << 9
  bl display
  orr r0, 1 << 10
  bl display
  orr r0, 1 << 15
  bl display
  orr r0, 1 << 20
  bl display
  orr r0, 1 << 25
  bl display
  orr r0, 1 << 24
  bl display
  orr r0, 1 << 23
  bl display
  orr r0, 1 << 18
  bl display
  orr r0, 1 << 13
  bl display
  orr r0, 1 << 14
  bl display
  orr r0, 1 << 19
  orr r0, 0b011110 @ change display time
  bl display

  begin_for_4:
    movs r1, 50
  loop_4:
    beq rest_of_program_4
    ldr r0, =0b01010101011000101010001000000011
    bl display
    ldr r0, =0b10001011100111010101110110000010
    bl display
    subs r1, 1
    b loop_4
  rest_of_program_4:

  ldr r0, =0b11111111111111111111111110000101
  bl display
  bic r0, 1 << 27
  bl display
  bic r0, 1 << 22
  bl display
  bic r0, 1 << 17
  bl display
  bic r0, 1 << 12
  bl display
  bic r0, 1 << 7
  bl display
  bic r0, 1 << 8
  bl display
  bic r0, 1 << 9
  bl display
  bic r0, 1 << 10
  bl display
  bic r0, 1 << 11
  bl display
  bic r0, 1 << 16
  bl display
  bic r0, 1 << 21
  bl display
  bic r0, 1 << 26
  bl display
  bic r0, 1 << 31
  bl display
  bic r0, 1 << 30
  bl display
  bic r0, 1 << 29
  bl display
  bic r0, 1 << 28
  bl display
  bic r0, 1 << 23
  bl display
  bic r0, 1 << 18
  bl display
  bic r0, 1 << 13
  bl display
  bic r0, 1 << 14
  bl display
  bic r0, 1 << 15
  bl display
  bic r0, 1 << 20
  bl display
  bic r0, 1 << 25
  bl display
  bic r0, 1 << 24
  bl display
  bic r0, 1 << 19
  bl display

  b main
.size main, .-main


@======================== DISPLAY FUNCTIONS ========================@


@ Take a 32-bit picture encoding from r0 and display it
display:
  push {r0-r11, lr} @ r0 on the top, lr on the bottom of the stack.

  @ adjust brightness
  mov r1, r0 @ make a copy of r0
  mov r4, 0 @ default LED brightness (dim)
  lsls r1, 31 @ left-shift r1 31 bits.
  beq skip @ if result in 0, i.e the last bit of r0 is 0, do not increase brightness
    mov r4, 0x300 @ make LED bright
  skip:
  lsr r0, r0, #1 @ delete the right most bit of r0 by right-shifting r0 1 bit.

  @ adjust display time
  mov r1, r0 @ make a copy of r0
  lsl r5, r1, #26 @ extract the display time information from r0 and save it into r5
  lsr r5, #19
  lsr r0, r0, #6 @ delete the right most 6 bits of r0 by right-shifting r0 1 bit.

  @ show a image for a set time
  mov r6, r0 @ make a copy of r0 into r6 as r0 will be deleted in every display loop.
  begin_while_1:
    cmp r5, 0
    beq end_while_1
    @ display rows one by one
    mov r3, 19 @ row 5
    bl display_row @ row 5
    mov r3, 24 @ row 4
    bl display_row @ row 4
    mov r3, 15 @ row 3
    bl display_row @ row 3
    mov r3, 22 @ row 2
    bl display_row @ row 3
    mov r3, 21 @ row 1
    bl display_row @ row 1
    sub r5, r5, 1
    mov r0, r6 @ restore r0
    b begin_while_1
  end_while_1:

  pop {r0-r11, lr}
  bx lr



@ Read the last 5 bits of r0 and display it on a row. After that, right-shift r0 5 digits.
@ r3: bit index of the rows
@ r4: brightness
display_row:
  push {r1-r11, lr}
  mov r2, r3 @ row 5
  bl set_row @ row 5
  ldr r1, =0x50000000
  mov r2, 30 @ col 5
  bl set_col @ col 5
  ldr r1, =0x50000300
  mov r2, 5 @ col 4
  bl set_col @ col 4
  ldr r1, =0x50000000
  mov r2, 31 @ col 3
  bl set_col @ col 3
  mov r2, 11 @ col 2
  bl set_col @ col 2
  mov r2, 28 @ col 1
  bl set_col @ col 1
  mov r2, r3
  bl row_on
  bl delay @ create time delay between on and off to change the brightness
  bl row_off
  bl clear_all_col
  bl clear_row
  pop {r1-r11, lr}
  bx lr



@ Set a column if the last bit of r0 is 1. After that, right-shift r0 1 digits.
@ r0: whether or not to set a column
@ r1: base address
@ r2: bit index
set_col:
  push {r1-r11, lr}
  mov r5, r0 @ make a copy of r0 and save it into r5.

  lsls r5, 31 @ left-shift r5 31 digit.
  beq jump @ if result in 0, i.e the last bit of r0 is 0, do not turn on the LED
    ldr r3, [r1, 0x514] @ get the value of DIR register at address [r1 + 0x514] and save it into r3.
    mov r4, 1
    lsl r4, r4, r2
    orr r3, r3, r4 @ set the corresponding pin
    str r3, [r1, 0x514] @ store the new value of DIR register back at address [r1 + 0x514].
  
  jump:
  pop {r1-r11, lr}
  lsr r0, r0, #1 @ delete the right most bit of r0 by right-shifting r0 1 bit.
  bx lr


@ Clear all columns
clear_all_col:
  push {r0-r11, lr}
  ldr r1, =0x50000000 @ base address of P0
  ldr r2, =0x50000300 @ base address of P1
  ldr r3, [r1, 0x514] @ get the value of DIR register at address [r0 + 0x514] and save it into r3.
  ldr r4, [r2, 0x514] @ get the value of DIR register at address [r1 + 0x514] and save it into r4.
  mov r5, 1
  bic r3, r3, r5, lsl 28 @ clear col 1
  bic r3, r3, r5, lsl 11 @ clear col 2
  bic r3, r3, r5, lsl 31 @ clear col 3
  bic r4, r4, r5, lsl 5 @ clear col 4
  bic r3, r3, r5, lsl 30 @ clear col 5
  str r3, [r1, 0x514] @ store the new value of DIR register back at address [0x50000000 + 0x514].
  str r4, [r2, 0x514] @ store the new value of DIR register back at address [0x50000300 + 0x514].
  pop {r0-r11, lr}
  bx lr



@ Set a row
@ r2: bit index
set_row:
  push {r0-r11, lr}
  ldr r1, =0x50000000
  ldr r3, [r1, 0x514] @ get the value of DIR register at address [0x50000000 + 0x514] and save it into r3.
  mov r4, 1
  lsl r4, r4, r2
  orr r3, r3, r4 @ set the corresponding pin
  str r3, [r1, 0x514] @ store the new value of DIR register back at address [0x50000000 + 0x514].
  pop {r0-r11, lr}
  bx lr


@ Clear a row
@ r2: bit index
clear_row:
  push {r0-r11, lr}
  ldr r1, =0x50000000
  ldr r3, [r1, 0x514] @ get the value of DIR register at address [0x50000000 + 0x514] and save it into r3.
  mov r4, 1
  lsl r4, r4, r2
  bic r3, r3, r4 @ clear the corresponding pin
  str r3, [r1, 0x514] @ store the new value of DIR register back at address [0x50000000 + 0x514].
  pop {r0-r11, lr}
  bx lr


@ Turn on a row of LEDs
@ r2: bit index
row_on:
  push {r0-r11, lr}
  ldr r1, =0x50000000
  ldr r3, [r1, 0x504] @ get the value of DIR register at address [0x50000000 + 0x504] and save it into r3.
  mov r4, 1
  lsl r4, r4, r2
  orr r3, r3, r4 @ set the corresponding pin
  str r3, [r1, 0x504] @ store the new value of DIR register back at address [0x50000000 + 0x504].
  pop {r0-r11, lr}
  bx lr


@ Turn off a row of LEDs
@ r2: bit index
row_off:
  push {r0-r11, lr}
  ldr r1, =0x50000000
  ldr r3, [r1, 0x504] @ get the value of DIR register at address [0x50000000 + 0x504] and save it into r3.
  mov r4, 1
  lsl r4, r4, r2
  bic r3, r3, r4 @ clear the corresponding pin
  str r3, [r1, 0x504] @ store the new value of DIR register back at address [0x50000000 + 0x504].
  pop {r0-r11, lr}
  bx lr


@======================== HELPER FUNCTIONS ========================@


@ Takes two images and altenatively shows them
@ r1: image 1
@ r2: image 2
@ r3: repeated times
twinkling:
  push {r0-r11, lr}
  movs r2, r2 @ update flags
  @ begin_for_lopp
  loop:
    beq rest_of_program
    mov r0, r1
    bl display
    mov r0, r2
    bl display
    subs r3, 1
    b loop
  rest_of_program:
  pop {r0-r11, lr}
  bx lr


@ Create time delay
@ r4: time delay
delay:
  push {r0-r11, lr}
  begin_while:
    cmp r4, 0
    beq end_while
    sub r4, r4, 1
    b begin_while
  end_while:
  pop {r0-r11, lr}
  bx lr


@ r1: number
@ r2: divisor
@ r1: return value
modulus:
  push {r0, r2-r11, lr}
  udiv r3, r1, r2
  mul r4, r2, r3
  sub r1, r1, r4
  pop {r0, r2-r11, lr}
  bx lr