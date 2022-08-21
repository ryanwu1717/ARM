        GLOBAL	Reset_Handler
		AREA 	Reset, CODE, READONLY
        ENTRY	
Reset_Handler	
		MOV  	r0,  #0x40000000
		MOV  	r7,  #0x40000010
		MOV  	r10,  #3
		LDR 	r1, [r0],#4		;load halfword into r11
		LDR 	r2, [r0],#4
		LDR 	r3, [r0],#4
		LDR 	r4, [r0],#4

		
		MOV 	r2,r2,ROR 24
		MOV 	r2,r2,ROR 24
		MOV 	r2,r2,ROR 24
		
		MOV 	r3,r3,ROR 24
		MOV 	r3,r3,ROR 24
		
		MOV 	r4,r4,ROR 24
		
		
		STR	r1, [r7]
		STR	r2, [r7,#4]
		STR	r3, [r7,#8]
		STR	r4, [r7,#12]



stop    B       stop            ; branch, stop program
        END