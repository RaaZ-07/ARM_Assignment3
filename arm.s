    ; Assignmet-3 A00290323
    AREA myData, DATA, READWRITE  
    
    AREA myCode, CODE, READONLY
    ENTRY
    LDR R0, =myNum1       ; Load address
    LDR R0, [R0]          ; Load the value
    LDR R1, =myNum2       ; Load address of the second number
    LDR R1, [R1]          ; Load the value  in R1
    LDR R5, =myNum3       ; Load address of 15
    LDR R5, [R5]          ; Load the value of R5
    
    CMP R0, R1            ; Compare R0 and R1
    BGT greater           ; Branch to 'greater' if R0 > R1
    BLT lesser            ; Branch to 'lesser' if R0 < R1
    BEQ equal             ; Branch to 'equal' if R0 == R1
    
greater
    LSL R5, R5, #2        ; Logical shift left by 2
    B terminate           ; Branch to terminate

lesser
    LSR R5, R5, #1        ; Logical shift right by 1
    B terminate           ; Branch to terminate

equal
    ROR R5, R5, #1        ; Rotate right by 1

terminate
    B terminate           ; Infinite loop to end the program

    END
