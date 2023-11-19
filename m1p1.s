.text
.align 2
.global m1p1
.type m1p1, %function

m1p1:
@ r0 = buffer address
  mov r4, #0 @ Holds whether last character was a space
  mov r5, r0 @ Copy buffer address to r5
loop:
  ldrb r2, [r5], #0 @ Read next byte from buffer
  stmfd sp!, {r0-r12, lr}@ Save registers
  mov r1, r2
  ldr r0, f_old
  bl printf
  ldmfd sp!, {r0-r12, lr}@ Restore registers
  cmp r2, #0 @ Check if end of string
  bxeq lr @ If end of string, return
@ Check if this character is a letter
  cmp r2, #65
  blt finish_char @ if less than 65, this is not a letter
  cmp r2, #122
  bgt finish_char @ if greater than 122, this is not a letter
@ check if r2 > 90 && r2 < 97
  cmp r2, #90
@store whether grater than 90
@store whether less than 97
@if both are true, this is not a letter
@@@@@@ TODO
  cmp r0, r5 @ Check if this is the first character of the string
  beq uppercase @ If first character, this should be a capital letter
  cmp r2, #32 @ Check if this is a space
  beq whitespace @ If space, go to appropriate label
  cmp r4, #1 @ Check if last character was a space
  beq uppercase @ If last character was a space, this should be a capital letter
  b lowercase @ If none of the above, this is the middle of a word

uppercase:
  mov r4, #0
@transform this to uppercase if it already isnt
  cmp r2, #96
  subgt r2, r2, #32
  strb r2, [r5]
  b finish_char
whitespace:
  mov r4, #1
  b finish_char
lowercase:
  mov r4, #0
@transform this to lowercase if it already isnt
  cmp r2, #91
  addlt r2, r2, #32
  strb r2, [r5]
  b finish_char
finish_char:
  stmfd sp!, {r0-r12, lr}@ Save registers
  mov r1, r2
  ldr r0, f_new
  mov r2, r4
  bl printf
  ldmfd sp!, {r0-r12, lr}@ Restore registers
  add r5, r5, #1 @ Increment buffer address by 1
  b loop @ Go to next character

@ Format string for printf
f_old:      .word format_old
f_new:      .word format_new
format_old: .asciz "Old: %c\n"
format_new: .asciz "New: %c %d\n\n"
