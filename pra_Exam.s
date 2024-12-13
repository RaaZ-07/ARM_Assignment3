.section .data
array:      .byte 5, 3, 5, 7, 9  /* Example array */
array_size: .byte 5              /* Number of elements in the array */
target:     .byte 5              /* Target integer to remove */
new_size:   .byte 0              /* Placeholder for the new size */

.section .text
.global _start

_start:
    /* Load base address of the array into r0 */
    ldr r0, =array

    /* Load the number of elements into r1 */
    ldrb r1, =array_size
    ldrb r1, [r1]

    /* Load the target integer to remove into r2 */
    ldrb r2, =target
    ldrb r2, [r2]

    /* Initialize r3 (write index) to 0 */
    mov r3, #0

    /* Loop through the array */
loop:
    /* Check if we've reached the end of the array */
    cmp r3, r1
    beq end_loop

    /* Load the current element into r4 */
    ldrb r4, [r0, r3]

    /* Compare the current element with the target */
    cmp r4, r2
    beq remove_element

    /* If not equal, move to the next element */
    add r3, r3, #1
    b loop

remove_element:
    /* Shift elements to the left to remove the target */
    mov r5, r3
shift_loop:
    /* Check if we've reached the last element */
    cmp r5, r1
    beq decrement_size

    /* Load the next element */
    ldrb r6, [r0, r5, #1]

    /* Store it in the current position */
    strb r6, [r0, r5]

    /* Move to the next element */
    add r5, r5, #1
    b shift_loop

decrement_size:
    /* Decrease the size of the array */
    sub r1, r1, #1
    b loop

end_loop:
    /* Store the new size at memory address 0x1000 */
    ldr r7, =0x1000
    strb r1, [r7]

    /* Exit the program */
    mov r7, #1
    swi 0

    END
