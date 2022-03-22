.syntax unified
.global main

.type main, %function
main:
@ ============ Change DIR Register =============

@ Set output direction for P0.21 and P0.28
@ load r1 with the base address of P0
ldr r1, =0x50000000

@ load r2 with the value of P0 DIR
@ (note the 0x514 offset from the P0 base address)
ldr r2, [r1, 0x514]

@ set bit 21 of this register by doing a logical or with 0b1 left-shifted by 21
@ think: why does this work?
orr r2, r2, 1 << 21
orr r2, r2, 1 << 28

orr r2, r2, 1 << 11
orr r2, r2, 1 << 24

@ store the modified result back into P0 DIR
str r2, [r1, 0x514]

@ ============ Change OUT Register =============

ledON:
  ldr r2, [r1, 0x504]
  orr r2, r2, 1 << 21
  orr r2, r2, 1 << 24
  str r2, [r1, 0x504]

ledOFF:
  ldr r4, [r1, 0x504]
  bic r4, r4, 1 << 21
  str r4, [r1, 0x504]

loop:
  nop
  b loop