assume cs:code

code segment

    mov ax,cs
    mov ds,ax		;源程序存储的段地址
	
    mov ax,0020h
    mov es,ax		;目的地的段地址

    mov cx,17h		;复制的长度，先预估一个值，导入后再修改
	
    mov bx,0

s:  mov al,[bx]		;对每个字节复制，需要中间寄存器
    mov es:[bx],al
    inc bx
    loop s

    mov ax,4c00h
    int 21h

code ends

end