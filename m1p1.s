.align 2
@ r0 = buffer address
ldr r4, #0 @ Holds whether last character was a space
loop:
  mov r1, r0 @ Copy buffer address to r1
  ldrb r2, [r1], #1 @ Read next byte from buffer
  cmp r2, #0 @ Check if end of string
  beq lr @ If end of string, return
  @ Check if this character is a letter
  cmp r2, #65
  blt loop @ if less than 65, this is not a letter
  cmp r2, #122 
  bgt loop @ if greater than 122, this is not a letter
  @ check if r2 > 90 && r2 < 97
  cmp r2, #90
  @store whether grater than 90
  @store whether less than 97
  @if both are true, this is not a letter
  @@@@@@ TODO
  cmp r0, r1 @ Check if this is the first character of the string
  beq uppercase @ If first character, this should be a capital letter
  cmp r2, #32 @ Check if this is a space
  beq whitespace @ If space, go to appropriate label
  cmp r4, #1 @ Check if last character was a space
  beq uppercase @ If last character was a space, this should be a capital letter
  b lowercase @ If none of the above, this is the middle of a word

uppercase:
  ldr r4, #0
  @transform this to uppercase if it already isnt
  cmp r2, #96
  subgt r2, r2, #32
  strb r2, [r1]
  b loop
whitespace:
  mov r4, #1
  b loop
lowercase:
  mov r4, #0
  @transform this to lowercase if it already isnt
  cmp r2, #91
  addlt r2, r2, #32
  strb r2, [r1]
  b loop
