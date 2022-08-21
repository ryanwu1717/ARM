        GLOBAL	Reset_Handler
		AREA 	Reset, CODE, READONLY
Reset_Handler
Rcnt	RN		10         ; assign r0 to Rcnt
Ra		RN		4        	; A
Rb		RN		5         ; MOD B
Rc		RN		11         ; quotient
Rg		RN		12         ; mod result

RXx		RN		6         ; X'
RX		RN		3         ; X
Rt		RN		2         ; T
Rn		RN		1         ; N
RXX		RN		7         ; X result
Rq		RN		0         ; Q
Rr		RN		8         ; R

Rstep4	RN		9			;temp for step4

ENTRY
		LDR		Ra,	=373
		LDR		Rb, =479
		LDR		Rt, =17
		SUB		Ra, Ra, 1
		SUB		Rb, Rb, 1
		MUL		Rn, Ra, Rb

STEP1	
		MOV		Ra, Rn
		MOV	 	Rb, Rt
		LDR		RXx, =0
		LDR		RX,  =1

STEP2
		
MOD	

		MOV		Rcnt, #1     		; bit to control the division

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
		
MODdone	MOV 	Rg, Ra
		MOV		Rq, Rc
		MOV		Rr, Rg

STEP3
		CMP		Rr, #0
		BNE		STEP4
		
		CMP		RX, #0
		BLT		done1
		
		B		done2
		
STEP4

		MOV		Ra,Rb
		MOV		Rb,Rr
		MOV		Rstep4 ,RXx;temp X'
		MOV		RXx,RX
		MUL		RXX,RX,Rq		;QxX, borrow RXX
		SUB		RX,Rstep4,RXX
		
		B		STEP2

done1
		ADD		RX,RX,Rn
		
done2   
		MOV		RXX,RX

donedone B 		donedone
		
		END
