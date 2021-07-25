assume cs:code,ds:data,ss:stack

data segment 
db 'welcome to masm!'	;一个字符一个字节
db 02h,24h,71h 		;三种颜色
data ends

stack segment 
dw 0,0,0,0,0,0,0,0
stack ends

code segment
	
start:	mov ax,data
	mov ds,ax
	mov ax,stack
	mov ss,ax
	mov si,16

	mov cx,3
	mov bx,0
	mov ax,0b86eh	;页中间的段号,b开头前面加0
	push ax
s0:	pop ax		;方便下次增加段号
	add ax,0ah	;一行是0ah个字节
	push ax
	mov es,ax
	mov di,0040h	;行中间的偏移
	mov si,0	;数据段中的字符偏移

	push cx

	mov cx,16
s:	mov al,[si]	;先把字符串拷贝进去
	mov es:[di],al
	mov al,[bx+16]
	mov es:[di+1],al

	add di,2
	add si,1
	loop s	

	pop cx
	inc bx
	loop s0
	
	mov ax,4c00h
	int 21

code ends

end start