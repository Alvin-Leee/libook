assume cs:code,ss:stack,ds:data

data segment
	db '1975','1976','1977','1978','1979','1980','1981','1982','1983'
	db '1984','1985','1986','1987','1988','1989','1990','1991','1992'
	db '1993','1994','1995'
	;以上是表示21年的21个字符串
	
	dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
	dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000
	;以上是表示21年公司总收入的21个dword型数据

	dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
	dw 11542,14430,15257,17800
	;以上是表示21年公司雇员人数的21个word型数据
data ends

table segment
	db 21 dup ('year summ ne ?? ')
table ends

stack segment
	dw 0,0,0,0,0,0,0,0
stack ends

code segment

start:	mov ax,data
	mov ds,ax
	
	mov ax,table
	mov es,ax
	
	mov ax,stack
	mov ss,ax
	mov sp,16

	mov bx,0	;年份和收入公用bx，因为每次都是加4
	mov di,0	;雇员数用di，从0开始，每次加2
	mov cx,21

s:	push cx

	mov cx,4	;循环4个字节
	mov si,0
s0:	mov al,[bx+si]
	mov es:[si],al
	inc si
	loop s0
	
	mov ax,[bx+84]	;先取低16位
	mov dx,[bx+86]	;再取高16位
	mov es:[5],ax
	mov es:[7],dx
	
	push bx		;先保存一下，除法要用
	mov bx,[di+168]	;168是42个4字节
	mov es:[0ah],bx	;dx放除数，2字节
	add di,2
	
	div bx
	mov es:[0dh],ax	;保存商
		
	pop bx		;弹出保存的bx

	pop cx
	add bx,4	;bx后移4个字节
	mov ax,es
	inc ax
	mov es,ax	;es加1,就是整体加10h，在table中就是下一行
	loop s

	mov ax,4c00h
	int 21h
	
code ends

end start