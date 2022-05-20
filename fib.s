global  _start
extern  printf, scanf
 
section .data
    message db "Please input max Fn:", 0x0a
    outFormat db  "%lld", 0x0a, 0x00
    inFormat db  "%d", 0x00

section .bss
    num    resd 1
    buffer resb 10
    userInput resb 1

section .text

_start:
  call printHello
  call getInput	
  call initFirstFibVal
  call loopFib
  call exitSystemCall

getInput:
    mov rdi, inFormat   ; set 1st parameter (inFormat)
    mov rsi, userInput  ; set 2nd parameter (userInputi)
    sub rsp, 8
    call scanf
    add rsp, 8
    ret

printFib:
    push rax            ; push registers to stack
    push rbx
    mov rdi, outFormat  ; set 1st argument (Print Format)
    mov rsi, rbx        ; set 2nd argument (Fib Number)
    call printf         ; printf(outFormat, rbx)
    pop rbx             ; restore registers from stack
    pop rax
    ret

printHello:
    mov rax, 1       ; rax: syscall number 1
    mov rdi, 1      ; rdi: fd 1 for stdout
    mov rsi,message ; rsi: pointer to message
    mov rdx, 20      ; rdx: print length of 20 bytes
    syscall         ; call write syscall to the intro message	 	

initFirstFibVal:    
    xor rax, rax    ; initialize rax to 0
    xor rbx, rbx    ; initialize rbx to 0
    inc rbx         ; increment rbx to 1
    ret

loopFib:
    call printFib 
    add rax, rbx    ; get the next number
    xchg rax, rbx   ; swap values	
    cmp rbx, [userInput] ; do rbx - userInput
    js loopFib		; jump if result is <0
    ret	   

exitSystemCall:
    mov rax, 60
    mov rdi, 0
    syscall
    ret
	
