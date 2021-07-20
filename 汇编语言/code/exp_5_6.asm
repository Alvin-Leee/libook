assume cs:code

a segment
	dw 1,2,3,4,5,6,7,8,9,0ah,0bh,0ch,0dh,0eh,0fh,0ffh
a ends

b segment
	dw 0,0,0,0,0,0,0,0
b ends

code segment

start:	mov cx,8	;cx为了循环
	mov bx,0	;bx为了寄存器寻址
	
	mov ax,a	;绑定源数据
	mov ds,ax

	mov ax,b
	mov ss,ax	;绑定目的位置
	mov sp,16	;等价于10h

s:	push ds:[bx]
	add bx,2
	
	loop s
	
	mov ax,4c00h
	int 21h

code ends 

end start