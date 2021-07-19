assume cs:codesg,ss:stacksg,ds:datasg

stacksg segment
	dw 0,0,0,0,0,0,0,0
stacksg ends

datasg segment
	db '1. display      '
	db '2. brows        '
	db '3. replace      '
	db '4. modify       '
datasg ends

codesg segment
start:	mov ax,datasg
	mov ds,ax
	mov ax,stacksg
	mov ss,ax
	mov sp,16
	
	mov bx,0	;4*4
	mov cx,4
	
s0:	push cx
	mov si,0
	mov cx,4

s:	mov al,[bx+si+3];前3个不是字母
	and al,11011111b;注意不是add
	mov [bx+si+3],al
	
	inc si
	loop s
	
	pop cx
	add bx,16
	loop s0
	
	mov ax,4c00h
	int 21h

codesg ends

end start