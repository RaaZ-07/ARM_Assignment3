.section .data
array: .byte 1, 2, 3, 4, 5, 0       @ Input array (0 marks the end)
array_len: .word 5                 @ Length of the array (excluding terminator)

.section .text
.global _start

_start:
    ldr r0, =array                 @ Load address of the byte array
    ldr r2, =reversed              @ Load address for the reversed array
    ldr r3, =array_len             @ Load the length of the array
    ldr r3, [r3]                   @ Load the actual length into r3

    @ Push all bytes of the array onto the stack
push_loop:
    ldrb r4, [r0], #1              @ Load the next byte into r4 and increment r0
    cmp r4, #0                     @ Check if the byte is the terminator (0)
    beq pop_elements               @ If 0, start popping bytes
    push {r4}                      @ Push the byte onto the stack
    b push_loop                    @ Repeat for the next byte

pop_elements:
    cmp r3, #0                     @ Check if all bytes have been popped
    beq add_terminator             @ If so, add terminator and finish
    pop {r4}                       @ Pop the top byte from the stack into r4
    strb r4, [r2], #1              @ Store the byte in the reversed array, increment r2
    sub r3, r3, #1                 @ Decrement the counter
    b pop_elements                 @ Repeat for the next byte

add_terminator:
    mov r4, #0                     @ Null terminator
    strb r4, [r2], #1              @ Store the terminator at the end of the reversed array

    @ Exit the program
    mov r7, #1                     @ syscall number (sys_exit)
    svc 0                          @ exit the program

.data
reversed: .space 6                 @ Reserve space for the reversed array (5 bytes + null terminator)
