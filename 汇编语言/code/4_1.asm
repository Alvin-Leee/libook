assume cs:code

code segment
    mov ax,2000h
    mov ds,ax	;初始化数据段寄存器
    
    mov ch,0
    mov cl,3fh  ;初始化计数器
	
    mov bh,0
s:  mov bl,cl	;p命令，一次执行完循环指令，也用于退出程序
    
    mov [bx],cl	;寄存器间接寻址只能使用基址寄存器BP/BX
		;和变址寄存器SI/DI
    loop s

    mov ds:[0],cl ;处理最后一个单元，最后的bx没有减1

    mov ax,4c00h
    int 21h

code ends

end