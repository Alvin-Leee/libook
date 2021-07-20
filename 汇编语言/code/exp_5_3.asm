assume cs:code,ds:data,ss:stack

code segment

start:	mov ax,stack
	mov ss,ax
	mov sp,16	;等价于10h

	mov ax,data
	mov ds,ax

	push ds:[0]
	push ds:[2]
	pop ds:[2]
	pop ds:[0]
	
	mov ax,04c0h
	int 21h

code ends 

data segment
	dw 0123h,0456h
data ends

stack segment
	dw 0,0
stack ends

end start