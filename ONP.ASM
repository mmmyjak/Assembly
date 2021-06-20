	org 100h	 ;PRZESUNIECIE
	
	mov	ah,9
	mov	dx,ent
	int	21h

	mov	ah,10
	mov	dx,konw
	int	21h	

	mov	ah,9
	mov	dx,ent
	int	21h

	xor 	si,si
	mov	di,2
	xor	dx,dx
	xor	cx,cx
	xor	bx,bx

naonp:
	mov	dl,[konw+di]
	cmp	dl,40		;lewy nawias
	je	lewynaw
	cmp	dl,41		;prawy nawias
	je	prawynaw
	cmp	dl,42		;znak dodawania
	je	plusraz
	cmp	dl,43		;znak mnozenia
	je	plusraz
	cmp	dl,48		;wszystko co nie jest cyfra
	jl	dopet
	cmp	dl,57
	jg	dopet


	mov	[onp+si],dl	
	inc	si
	jmp	dopet


lewynaw:
	mov	cl,dl
	push	cx
	inc	bl		;w bl zapisuje ile symbolijest na stosie
	jmp	dopet

prawynaw:
	pop	cx
	dec	bl
	cmp	cl,40
	jne	zdejmij		;zdejmuje ze stosu wszystko do lewego nawiasa
	jmp	dopet

zdejmij:
	mov	[onp+si],cl
	inc	si
	jmp	prawynaw
	

plusraz:
	mov	cl,dl
	push	cx
	inc	bl
	jmp	dopet
dopet:
	inc	di
	mov	dl,[konw+di]
	cmp	dl,36
	jne	naonp	
reszta:
	cmp	bl,0
	jg	zdejmv2			;zdejmuje reszte
	jmp	pokaz			
	
zdejmv2:	
	pop	cx
	mov	[onp+si],cl
	inc	si
	dec	bl
	jmp	reszta

pokaz:

	mov	ah,9
	mov	dx,onp
	int	21h
	
	mov	ah,9
	mov	dx,ent
	int	21h

	xor	di,di
	xor	dx,dx
	xor	cx,cx
	xor	ax,ax

	
wynik:
	mov	dl,[onp+di]
	cmp	dl,42 		;znak mnozenia
	je	mnoz		;znak dodawania
	cmp	dl,43
	je	dodaj		;w tej tablicy do znaku dolara nie ma juz nic
				;oprocz cyfr, + i *, wiec nie potrzebuje 
				;wiecej warunkow
	mov	al,dl
	sub	al,48		;odejmuje od kazdej liczby 48
	push	ax
	jmp	dopet2

mnoz:
	
	pop	cx
	mov	ah,cl
	pop	cx
	mov	al,cl
	mul	ah
	push	ax
	jmp	dopet2
dodaj:
	pop	ax
	mov	cx,ax
	pop	ax
	add	ax,cx
	push	ax
	jmp	dopet2

dopet2:	
	inc	di
	mov	dl,[onp+di]
	cmp	dl,36
	jne	wynik	
	
	xor	cx,cx
	xor	dx,dx

	pop	ax		;na stosie zostal tylko wynik
	mov	bx,10
wysw:				;wyswietlam wynik
	div	bx
	add	dx,48
	push	dx
	xor	dx,dx
	inc	cx		
	cmp	ax,0
	jg	wysw

	mov	ah,2

wysw2:
	pop	dx
	int	21h
	loop	wysw2


	
	mov	ax, 4C00h	 ;KONIEC PROGRAMU
        int	21h

konw	TIMES	27	db	36
onp	TIMES	27	db	36
ent	db	10,13,36