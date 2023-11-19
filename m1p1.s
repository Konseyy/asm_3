.text
.align 2
.global m1p1
.type m1p1, %function

m1p1:
@ r0 = buffer address
  mov r4, #0 @ Holds whether last character was a seperator
  mov r5, r0 @ Copy buffer address to r5
loop:
  ldrb r2, [r5], #0 @ Read next byte from buffer
  cmp r2, #0 @ Check if end of string
  bxeq lr @ If end of string, return
  cmp r2, #32 @ Check if this is a space
  beq seperator @ If space, go to appropriate label
  cmp r2, #9 @ Check if this is a tab
  beq seperator @ If tab, go to appropriate label
  cmp r2, #10 @ Check if this is a newline
  beq seperator @ If newline, go to appropriate label
  cmp r2, #13 @ Check if this is a carriage return
  beq seperator @ If carriage return, go to appropriate label
@ Check if this character is a letter
  cmp r2, #65
  blt not_letter @ if less than 65, this is not a letter
  cmp r2, #122
  bgt not_letter @ if greater than 122, this is not a letter
@ check if r2 > 90 && r2 < 97
  cmp r2, #90
@store whether grater than 90
@store whether less than 97
@if both are true, this is not a letter
@@@@@@ TODO
  cmp r0, r5 @ Check if this is the first character of the string
  beq uppercase @ If first character, this should be a capital letter
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
seperator:
  mov r4, #1
  b finish_char
lowercase:
  mov r4, #0
@transform this to lowercase if it already isnt
  cmp r2, #91
  addlt r2, r2, #32
  strb r2, [r5]
  b finish_char
not_letter:
  mov r4, #0
  b finish_char
finish_char:
  add r5, r5, #1 @ Increment buffer address by 1
  b loop @ Go to next character
