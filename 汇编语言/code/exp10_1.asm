assume cs:code

data segment
db 'Welcome to masm!',0
data ends

code segment

start:		mov dh,8	;行号
		mov dl,3	;列号
		mov cl,2	;颜色

		mov ax,data
		mov ds,ax
		mov si,0	;数组下标
		call show_str

		mov ax,4c00h
		int 21h

show_str:	push cx
		mov ax,0b800h	;显存的初始段地址，字符从0开头
		mov cl,dh
		mov dh,0
		mov ch,0

s:		add ax,0ah	
		loop s
		mov es,ax	;目的行位置
		pop cx
	
do:		push cx		;保存一下颜色
		mov cl,[si]	
		jcxz ok		;根据字符是不是为0来判断字符串是否结束
				;判断的时候要确保返回前没有压入新东西
				;否则出栈的不是返回的地址
		mov ax,dx
		add ax,ax
		mov di,ax	;第3列，即从第6个字节开始
		mov es:[di],cl	;根据列依次放入
		pop cx
		mov es:[di+1],cl;放置颜色			
		inc si
		inc dx		;列数+1
		jmp do

ok:		pop cx		;将压入的颜色弹出
		ret

code ends

end start