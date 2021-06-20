	org 100h	 ;PRZESUNIECIE

	

	xor	ax,ax
	mov	ah,1
	int	21h	
	sub	ax,48
	mov	[a],al

	mov	ah,2	;enterv1
	mov	dl,10
	int	21h
	
	mov	ah,2	;enterv2
	mov	dl,13
	int	21h

	mov	al,[a]
	cmp	al,0
	je	jeden	;silnia 0 to 1

	cmp	al,8    ;dla 9 pokazuje wykrzyknik
	jg	maxejt


	call	silnia
	call	pok	
	jmp	koniec	
jeden:
	mov	ah,2
	mov	dl,49
	int	21h
	jmp koniec

maxejt:
	mov	ah,2
	mov	dl,33
	int	21h

koniec:
	mov	ax, 4C00h	 ;KONIEC PROGRAMU
        int	21h

a	db	0
b	dw	1
pom	dw	0

silnia:
	pusha
	xor	cx,cx
	mov	cl,[a]
	mov	ax,[b]
petla:
	mov	bx,cx
	mul	bx
	loop	petla

	mov	[b],ax

		
	popa
ret

pok:
	pusha
	mov	bx,10000
	mov	ax,[b]	
pet:
	xor	dx,dx
	div	bx
	mov	[pom],dx
	add	ax,48

	mov	ah,2
	mov	dl,al
	int	21h

	xor	dx,dx
	mov	ax,bx
	mov	bx,10
	div	bx	;dziele przez 10
	mov	bx,ax
	mov	ax,[pom]
	cmp	bx,1	; 1/10 !>=1 - zakonczenie pokazywania
	jae	pet

	popa		
	
ret