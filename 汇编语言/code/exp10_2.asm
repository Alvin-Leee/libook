assume cs:code

code segment

start:	mov ax,4240H
	mov dx,000FH
	mov cx,0ah
	call divdw

	mov ax,4c00h
	int 21h

divdw:	mov bx,ax	;把最初的低16位保存在bx中
	mov ax,dx
	mov dx,0	;则(dx)=0,ax是之前dx的值
	div cx		;做除法，余数保存在dx中，商在ax中
	
	push ax		;余数dx当做下一次的高16位，ax是最终的高16位，保存下来
	mov ax,bx	;ax拿到之前的低16位
	div cx		;余数在dx中，商在ax中
	mov cx,dx	;将余数放入cx中

	pop dx		;dx得到最终的高16位，ax就是最终的低16位
	ret

code ends

end start