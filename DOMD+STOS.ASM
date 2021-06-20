		org 100h	 ;PRZESUNIECIE

	call	ent
	
	mov	ah,1
	int	21h
	sub	al,48
	mov	[a],al

	call	spacja	

	mov	ah,1
	int	21h
	sub	al,48
	mov	[b],al

	call	ent
	call	dodaj
	call	spacja
	call 	minus
	call	spacja
	call	mnoz
	call	spacja

	mov	dl,[b]
	cmp	dl,0
	je	blad

	call 	dziel
	
	jmp    koniec
	

blad:
	mov	ah,2
	mov	dl,33
	int	21h
	int	21h	
	int	21h
koniec:

	mov	ax, 4C00h	 ;KONIEC PROGRAMU
        int	21h

a	db	0
b	db	0

ent:
	push	ax
	push	dx
	mov	ah,2
	mov	dl,10
	int	21h

	mov	ah,2
	mov	dl,13
	int	21h
	pop	dx
	pop	ax
ret

dodaj:
	pusha	
	xor	dx,dx
	mov	dl,[a]
	add	dl,[b]
	mov	ah,2
	int	21h
	popa
	
ret

spacja:
	push	ax
	push	dx
	mov	ah,2
	mov	dl,32
	int	21h
	pop	dx
	pop	ax
ret

minus:
	pusha
	xor	dx,dx
	mov	dl,[a]
	sub	dl,[b]
	mov	ah,2
	int	21h
	popa
ret

mnoz:
	pusha
	xor	ax,ax
	mov	ah,[a]
	mov	al,[b]
	mul	ah
	mov	dx,ax
	mov	ah,2
	int	21h
	popa
	
ret

dziel:
	pusha
	xor	ax,ax
	mov	al,[a]
	mov	bh,[b]
	div	bh
	mov	dl,al
	mov	ah,2
	int	21h
	popa
ret





