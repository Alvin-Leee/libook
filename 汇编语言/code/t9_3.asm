assume cs:code

code segment

start: 	mov ax,2000h
	mov ds,ax
	mov bx,0

s:	mov cl,[bx]
	mov ch,0
	inc cl		;如果是零,这步后就是判断cx是不是1了
	inc bx
	loop s
ok:	dec bx		;bx=bx-1
	mov dx,bx
	mov ax,4c00h
	int 21h

code ends

end start