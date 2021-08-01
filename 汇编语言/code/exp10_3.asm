assume cs:code

data segment
dw 123,12666,1,8,3,38
db 16 dup (0)
data ends

code segment

start:		mov bx,data
		mov ds,bx	;ds段保存原始数据
		add bx,1h	;段号+1，即加16个字节	
		mov es,bx	;es段保存转换后的字符串
	
		mov si,0	;ds那段
		mov di,0	;es那段
		call dtoc	;调用格式转换函数

		mov dh,8
		mov dl,3
		mov cl,2

		mov ax,es	
		mov ds,ax	;将ds设置到字符串es那段
		mov si,0
		call show_str	;调用字符串输出函数

		mov ax,4c00h
		int 21h

;将ds段的数据转化为十进制字符串，保存到es段中
dtoc:		push cx
		mov cx,6	;知道个数，就不用判断零了
				;因为如果是16个字节，就不能判断零了
dtocs:		mov ax,[si]	;取一个数
		push cx
		mov dx,0	;dx之前没用过，当做计数器
dtocd:		mov ch,0
		mov cl,0ah
		call divdw

		add cl,30h	;将得到的余数+30h得到字符
		inc dx
		push cx		;得到的是反的，所以先放入栈中
		mov cx,ax
		jcxz dtok	;商是零，就结束
		jmp dtocd	;不是零，就继续除
				
dtok:		mov cx,dx	;位的个数
dtoput:		pop dx
		mov es:[di],dl	;字符是单字节的，虽然保存的是双字节的
		inc di
		loop dtoput
		add si,2
		pop cx
		loop dtocs
		pop cx
		ret


;修改一下之前的函数，支持8位除法
divdw:		mov bl,al	;把最初的低8位保存在bl中
		mov al,ah
		mov ah,0	;则(ah)=0,al是之前ah的值
		div cl		;做8位除法，余数保存在ah中，商在al中
		
		mov ch,al	;余数ah当做下一次的高8位，al是最终的高8位，保存下来
		mov al,bl	;ax拿到之前的低8位
		div cl		;余数在ah中，商在al中
		mov cl,ah	;将余数放入cl中

		mov ah,ch	;ah得到最终的高8位，al就是最终的低8位，cl保存余数
		ret
		

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