assume cs:code

code segment
start:	;设置中断程序,复制中断处理程序到0000:0020h处
	mov ax,cs
	mov ds,ax
	mov si,offset do0;ds:si源地址
	mov ax,0
	mov es,ax
	mov di,0200h	;es:di目的地址
	cld		;设置df=0,递增
	;设置循环长度，即中断处理程序的长度
	mov cx,offset doEnd-offset do0
	rep movsb 	;开始循环

	;设置中断向量,放到0200h
	mov ax,0
	mov es,ax
	;用word ptr时，前后都是常数，就要指定段寄存器
	mov word ptr es:[0],200h;中断向量的ip
	mov word ptr es:[2],0	;中断向量的cs

	mov ax,4c00h
	int 21h

;编写中断程序,功能将字符串输入到屏幕
do0:	jmp doStart	;2个字节
	db 'divide error!'

doStart:mov ax,cs 	;此处的cs:ip已经是中断向量了
	mov ds,ax	;源地址
	mov si,0202h	;do0是0200h,则数据放在0202h
	
	mov ax,0800h
	mov es,ax
	mov di,12*160+36*2;目的地址
	
	mov cx,13
s:	mov al,ds:[si]
	mov es:[di],al
	loop s

doEnd:	nop

code ends

end start