## 预备知识

- p命令: 第二次遇到loop时，自动重复执行循环中的指令，知道(cx)=0为止
- g命令: "g xxxx"，一直运行到xxxx位置处后暂停



## 实验开始

### 任务1：编程

---

- 向内存0:200~0:23F 依次传送数据 0~63(3F)
- 化简为0200:0~0200:3F

```c++
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
```



### 任务2：编程

---

- 任务1中只能使用9条指令，9条指令包括"mov ax,4c00h"和"int 21h"
- 将任务1的代码进行优化
```c
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
```



### 任务3：补全程序

---

- 将"mov ax,4c00h"之前的指令复制到内存0:200处
- 主要就是得出要复制的长度，可以先预估一个值，然后程序导入后进行反编译再修改
```c
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
```