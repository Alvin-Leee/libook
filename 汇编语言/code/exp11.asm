assume cs:codesg

datasg segment
db "Beginner's All-purpose Symbolic Instruction Code.",0
datasg ends

codesg segment
begin:	mov ax,datasg
	mov ds,ax
	mov si,0
	call letterc

	mov ax,4c00h
	int 21h

;a-z小写转大写(97-122)
;首先应该判断是否在a-z中
;a的ASCII码是97,61h
;z的ASCII码是122,7ah
letterc:	mov ch,0
		mov cl,[si]
		jcxz ok
		cmp cl,97;条件不成立就跳出去，进行下一个
		jb next
		cmp cl,122
		ja next
		and byte ptr [si],11011111b
		
next:		inc si
		jmp letterc
		
ok:		ret

codesg ends

end begin
