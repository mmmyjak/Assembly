	org 100h	 ;PRZESUNIECIE
poczat:	
	call	ent
	call	ent

	mov	ah,9		;komunikat o podanie 1 ciagu
	mov	dx,wiad1
	int	21h

	mov	ah,10
	mov	dx,ciag1	;pobieram 1 ciag znakow
	int	21h
	
	call	ent

	mov	ah,9
	mov	dx,wiad2	;komunikat o podanie 2 ciagu
	int	21h

	mov	ah,10
	mov	dx,ciag2	;pobieram 2 ciag znakow
	int	21h
	
	call	ent
	call	czyrow		;procedura, ktora sprawdza czy suma kodow 
	call	ent		;ascii jest rowna
	call	ent
		
	mov	ah,9
	mov	dx,wiad3	;pytanie czy uzytkownik chce zakonczyc program
	int	21h
	
	mov	ah,1		;pobranie 1 znaku
	int	21h	

	cmp	al,13		;jesli to enter to koniec programu
	jne	poczat

koniec:
	mov	ax, 4C00h	 ;KONIEC PROGRAMU
        int	21h

ciag1	db 254,0 
	TIMES	255	db	36
ciag2	db 254,0
   	 TIMES	255	db	36
wiad1   db	'Podaj pierwszy ciag znakow: ',36
wiad2	db	'Podaj drugi ciag znakow: ',36
wiad3	db	'Czy chcesz zakonczyc program?',10,'[TAK - Enter, NIE - inny znak]',36
wiadp	db	'Suma kodow ASCII tych ciagow jest rowna',36
wiadf	db	'Suma kodow ASCII tych ciagow nie jest rowna',36
entt	db	10,13,36

ent:
	push	ax
	push	dx

	mov	ah,9
	mov	dx,entt
	int	21h

	pop	dx
	pop	ax
ret

czyrow:
	pusha

	xor	dx,dx
	xor	ax,ax
	mov	si,2
cg1:
	mov	dl,[ciag1+si]
	cmp	dl,13	;sprawdzam tylko do entera, dzieki temu nie musze
	je	pocg1	;czyscic tablicy
	add	ax,dx	;dodaje do ax kody ascii
	inc	si
	jmp	cg1
pocg1:
	push	ax	;wrzucam ax na stos

	xor	dx,dx
	xor	ax,ax
	mov	si,2
cg2:
	mov	dl,[ciag2+si]
	cmp	dl,13
	je	pocg2
	add	ax,dx
	inc	si
	jmp	cg2
pocg2:
	pop	cx	;zdejmuje ze stosu sume kodow ascii 1 ciagu na cx
	cmp	ax,cx	;porownuje sumy
	je	komp	;jesli rowne wyswietlam komunikat, ze rowne

	mov	ah,9		;w innym przypadku komunikat, ze nierowne
	mov	dx,wiadf
	int	21h
	jmp	kon
komp:
	mov	ah,9
	mov	dx,wiadp
	int	21h
kon:
	popa
ret
