assume cs:code

code segment

	dw 0123h,0456h,0789h,0abch,0defh,0fedh,0cbah,0987h 
	;字母要以0开头
	;不加h就会当成10进制

	dw 0,0,0,0,0,0,0,0,0,0	;10个子单元用作栈空间
	
start:	mov ax,cs
	mov ss,ax
	mov sp,36		;或者24h,也是ip的值
				;尽量空间选最后的空间
				;否则初始化会对原来值有影响
	
	mov ax,0
	mov ds,ax
	mov bx,0
	mov cx,8
s:	push [bx]

	pop cs:[bx]

	add bx,2
	loop s

	mov ax,4c00h
	int 21h

code ends

end start