	org 100h	 ;PRZESUNIECIE
	
	mov	ah,2
	mov	dl,10	;enterv1
	int	21h

	mov	ah,2
	mov	dl,13	;enterv2
	int	21h

	xor	di,di
	mov	dl,[podaji]	;wypisujemy komunikat o imie
	mov	ah,2
	
petla1:
	int	21h
	inc	di
	mov	dl,[podaji+di]
	cmp	dl,36
	jne	petla1

	xor	di,di	;zczytujemy imie
imie:
	mov	ah,1
	int	21h
	mov	[im+di],al
	inc	di

	cmp	al,8		;zeby mozna bylo zmienic znak
	je	przeskok	
	cmp	al,13		;zeby zakonczyc 
	je	przeskok
	cmp	al,65		;mniejsze od A
	jl	blad

	cmp	al,122		;wieksze od z
	jg	blad		;BEZ POLSKICH ZNAKOW
	
	cmp	al,91		;znaki pomiedzy 'Z' a 'a'
	je	blad
	cmp	al,92
	je	blad
	cmp	al,93
	je	blad
	cmp	al,94
	je	blad
	cmp	al,95
	je	blad
	cmp	al,96
	je	blad
przeskok:
	cmp	al,13
	jne	imie	
		
		
	
		

	xor	di,di
	mov	dl,[podajn]
	mov	ah,2

petla2:				;wypisujemy komunikat o nazwisku
	int	21h
	inc	di
	mov	dl,[podajn+di]
	cmp	dl,36
	jne	petla2

	xor	di,di		;zczytujemy nazwisko

naz:	
	mov	ah,1
	int	21h
	mov	[nazw+di],al
	inc	di
	
	cmp	al,8
	je	skok2
	cmp	al,13
	je	skok2
	
	cmp	al,65
	jl	blad
	
	cmp	al,122
	jg	blad

	cmp	al,91
	je	blad
	cmp	al,92
	je	blad
	cmp	al,93
	je	blad
	cmp	al,94
	je	blad
	cmp	al,95
	je	blad
	cmp	al,96
	je	blad
		
skok2:	
	cmp	al,13
	jne	naz





	xor	di,di
	mov	ah,2
	mov	dl,[im]
wysw:					
				;wyswietlamy imie
	int	21h
	inc	di
	mov	dl,[im+di]
	cmp	dl,13
	jne	wysw

	mov	ah,2
	mov	dl,32		;spacja
	int	21h

	xor	di,di
	mov	ah,2
	mov	dl,[nazw]

wysw2:	
				;wyswietlamy nazwisko
	int	21h
	inc	di
	mov	dl,[nazw+di]
	cmp	dl,13
	jne	wysw2	
	cmp	dl,13
	je	koniec		;przeskakujemy blad

blad:				;wyswietlamy komunikat o zlym znaku
	mov	ah,2
	mov	dl,10
	int	21h

	mov	ah,2
	mov	dl,13
	int	21h

	xor	di,di
	mov	ah,2	
	mov	dl,[komun]

petla3:
	int	21H
	inc	di
	mov	dl,[komun+di]
	cmp	dl,36
	jne	petla3


koniec:	
	mov	ax, 4C00h	 ;KONIEC PROGRAMU
        int	21h

podaji	db	'P','o','d','a','j',32,'s','w','o','j','e',32,'i','m','i','e',58,32,36
podajn	db	80,111,100,97,106,32,115,119,111,106,101,32,110,97,122,119,105,115,107,111,58,32,36
im	TIMES	11	db	36	;nie zakladam dluzszego imienia
nazw	TIMES	16	db	36
komun	db	'Z','l','y',32,'z','n','a','k',33,36