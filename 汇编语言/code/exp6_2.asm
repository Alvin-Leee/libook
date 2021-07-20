assume cs:codesg,ds:datasg,ss:stack;保存到栈中，就是保存在内存中

datasg segment		;4*3，dx+si
	db 'ibm             '
	db 'dec             '
	db 'dos             '
	db 'vax             '
datasg ends

stack segment
	dw 0,0,0,0,0,0,0,0
stack ends

codesg segment
start:	mov ax,datasg
	mov ds,ax
	mov ax,stack
	mov ss,ax
	mov sp,16
	
	mov bx,0
	mov cx,4	;4次大循环
	
s0:	push cx		;这里有一个分析过程
			;先是放在其余的寄存器中，但是没有一般性，因为其余寄存器会被用到
			;然后是放在内存中，如果放入很多就需要记住每个对应的内存地址，很麻烦
			;最后最优的方法是压入栈中
	mov si,0
	mov cx,3	;3次小循环

s:	mov al,[bx+si]
	and al,11011111b
	mov [bx+si],al
	
	inc si
	loop s
	
	pop cx
	add bx,16
	loop s0
	
	mov ax,4c00h
	int 21h
	
codesg ends

end start