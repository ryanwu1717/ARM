        GLOBAL	Reset_Handler
		AREA 	Reset, CODE, READONLY
Reset_Handler
Rcnt	RN		0         ; assign r0 to Rcnt
Ra		RN		1         ; assign r1 to Ra, dividend
Rb		RN		2         ; assign r2 to Rb, divisor
Rc		RN		3         ; assign r3 to Rc, quotient
Rd		RN		4         ; assign r4 to Rd, A
Re		RN		5         ; assign r5 to Re, B
Rf		RN		6         ; assign r6 to Rf, mod
Rg		RN		7         ; assign r7 to Rg, result

ENTRY

		LDR     Rb,  =0x00100000			; test data for mod
		LDR 	Ra,  =0x003a2b3c
		LDR 	Rd,  =5
		LDR 	Re,  =0
		LDR 	Rf,  =0
		LDR 	Rg,  =16
		MOV		Rcnt, #1     		; bit to control the division
	


MOD	
Div1	CMP		Rb, #0x80000000		; move Rb until greater than Ra
		CMPCC	Rb, Ra
		LSLCC	Rb, Rb, #1
		LSLCC	Rcnt, Rcnt, #1
		BCC		Div1
;		
		MOV		Rc, #0
Div2	CMP		Ra, Rb				; test for possible subtraction
		SUBCS	Ra, Ra, Rb			; subtract if OK
		ADDCS	Rc, Rc, Rcnt		; put relevant bit into result
		LSRS	Rcnt, Rcnt, #1		; shift control bit
		LSRNE	Rb, Rb, #1			; halve unless finished
		BNE		Div2				; divide result in Rc remainder in Ra

STEP2
		MUL		Re,	Rc, Rg
		DA      Re
		
done    B		done
		
		END
