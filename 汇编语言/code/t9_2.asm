assume cs:code

code segment

start:	mov ax,2000H
	mov ds,ax
	mov bx,0
s:	mov ch,0
	mov cl,[bx]
	jcxz ok
	inc bx

	jmp short s
ok:	mov dx,bx
	mov ax,4c00h
	int 21h

code ends


end start