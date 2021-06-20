	org 100h	 ;PRZESUNIECIE

	MOV	AH,1      ;POBIERAM ZNAK
	INT	21H

	SUB	AL,48    ;ODEJMUJE 48
	MOV	[a],AL   ;PRZYPISUJE DO ZMIENNEJ 'A'
	XOR	AL,AL    ;CZYSZCZE AL

	MOV	AH,1	;POBIERAM ZNAK
	INT	21H

	SUB	AL,48	;ODEJMUJE 48
	MOV	[b],AL	;PRZYPISUJE DO ZMIENNEJ 'B'

	ADD	AL,[a]
	MOV	[plus],AL ;PLUS=A+B
	
	MOV	AL,[a]
	SUB	AL,[b]
	MOV	[minus],AL	;MINUS=A-B

	MOV	AH,[a]
	MOV	AL,[b]
	MUL	AH 	;AX=AH*AL
	MOV	[mnoz],AX ;MNOZ = A*B



	MOV	AH,2
	MOV	DL,10	;enter
	INT	21H

	MOV	AH,2
	MOV	DL,13	;enterv2
	INT	21H
	
	MOV	AH,2
	MOV	DL,[plus]	;wynik dodawania
	INT	21H

	MOV	AH,2
	MOV	DL,32	;spacja
	INT	21H

	MOV	AH,2
	MOV	DL,[minus]	;wynik odejmowania
	INT	21H

	MOV	AH,2
	MOV	DL,32	;spacja
	INT	21H
	
	MOV	AH,2
	MOV	DL,[mnoz]	;wynik mnozenia
	INT	21H	
	
	MOV	AH,2
	MOV	DL,32	;spacja
	INT	21H
	
	MOV	AL,[b]
	CMP	AL,0	;porownanie zmiennej b z 0
	JE	CANT	;rowne 0 - przeskakujemy dzielenie

	XOR	AX,AX	;czyszcze ax
	MOV	AL,[a]  ;zmienna 8bitowa, wiec wrzucam do al, a nie do ax
	MOV	BH,[b]
	DIV	BH		;AL=AX/BH
	MOV	[dziel],AL	;DZIEL = A / B


	MOV	AH,2
	MOV	DL,[dziel] ;podloga wyniku dzielenia
	INT	21H
	
	MOV	AL,[b]	
	CMP	AL,0	;porowanie zmiennej b z 0
	JNE	KONIEC	

CANT:
	MOV	AH,2
	MOV	DL,33
	INT	21H
KONIEC:	
	mov	ax, 4C00h	 ;KONIEC PROGRAMU
        int	21h

a	db	0
b	db	0
plus	db	0
minus	db	0
mnoz	db	0
dziel	db	0