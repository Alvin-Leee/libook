assume cs:code

a segment
	db 1,2,3,4,5,6,7,8
a ends

b segment
	db 1,2,3,4,5,6,7,8
b ends

c segment
	db 0,0,0,0,0,0,0,0
c ends

code segment

start:	mov cx,8	;cx为了循环
	mov bx,0	;bx为了寄存器寻址

s:	mov dl,0	;dl为了累加，单字节

	mov ax,a
	mov ds,ax
	mov dl,[bx]

	mov ax,b
	mov ds,ax
	add dl,[bx]

	mov ax,c
	mov ds,ax
	mov [bx],dl
	
	inc bx
	
	loop s
	
	mov ax,4c00h
	int 21h

code ends 

end start