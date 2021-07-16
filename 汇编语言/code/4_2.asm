assume cs:code

code segment
    mov ax,2000h
    mov ds,ax	;初始化数据段寄存器
   
    mov cx,003fh  ;初始化计数器
	
s:  mov bx,cx	;使用字寄存器就不用初始化高位，省去一条指令
    
    mov [bx],cl	;寄存器间接寻址只能使用基址寄存器BP/BX
		;和变址寄存器SI/DI
    loop s

    mov ds:[0],cl ;处理最后一个单元，最后的bx没有减1

    mov ax,4c00h
    int 21h

code ends

end