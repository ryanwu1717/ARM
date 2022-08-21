        GLOBAL	Reset_Handler
		AREA 	Reset, CODE, READONLY
        ENTRY
		
Reset_Handler		
        MOV  	r0,  #0x11          ; MOV (Move), load initial value into r0
        LSL		r1,  r0,  #1         ; LSL (Logical Shift Left) , r0 shift left 1 bit into r1
		LSL		r2,  r1,  #1         ; r1 shift left 1 bit into r2
stop    B       stop                  ; branch, stop program
        END