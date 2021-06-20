	org 100h	 ;PRZESUNIECIE
	
	mov	ah,9
	mov	dx,ent
	int	21h

	mov	ah,10
	mov	dx,wpis
	int	21h	

	mov	ah,9
	mov	dx,ent
	int	21h
	

	
	xor	di,di
cezar:
	
	mov	dl,[wpis+di]
	cmp	dl,65
	jl	spacja	;JESLI OD 0 DO 64 TO ZAMIEN NA SPACJE
	cmp	dl,122
	jg	spacja	;JESLI WIEKSZE OD 122 ZAMIEN NA SPACJE
	cmp	dl,91
	jl	dnam	;JESLI OD 65 DO 90 TO PRZESUWAM I ZAMIENIAM NA MALE
	cmp	dl,96
	jg	mnad	;JESLI OD 97 DO 122 TO PRZESUWAM I ZAMIENIAM NA DUZE
	jmp	inacz

spacja:
	mov	dl,32
	mov	[wpis+di],dl
	jmp	dopet

dnam:
	add	dl,34		;ZAMIENIAM NA MALE I DODAJE 2 np. z A na c
	cmp	dl,122
	jg	zapet1	;ZAPET1 = JESLI PO PRZESUNIECIU JEST WIEKSZE NIZ Z
			;ZAPETLAM ALFABET np z Z na b
	jmp	przyp1
zapet1:	
	sub	dl,26
przyp1:
	mov	[wpis+di],dl
	jmp	dopet	

mnad:
	sub	dl,30	;zamieniam na duze i dodaje 2 np. z a na C
	cmp	dl,90
	jg	zapet2	;zapet2 = tak samo jak zapet1
	jmp	przyp2
zapet2:
	sub	dl,26
przyp2:
	mov	[wpis+di],dl
	jmp	dopet
inacz:				;inaczej = od 91 do 96
	mov	dl,32
	mov	[wpis+di],dl
	jmp	dopet
dopet:
	inc	di
	mov	dl,[wpis+di]	;sprawdzam czy kolejny jest znakiem dolara
	cmp	dl,36		;jesli tak koncze petle
	jne	cezar		
	
	
	

	MOV	AH,9
	mov	dx,wpis+2
	int	21h

	mov	ax, 4C00h	 ;KONIEC PROGRAMU
        int	21h

wpis	TIMES	27	db	36
ent	db	10,13,36