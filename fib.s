global  _start

section .data
    message db "Fibonacci Sequence:", 0x0a
    nline db 0x0a
section .bss
    num    resd 1
    buffer resb 10

section .text
_start:

call printHello
call initFirstFibVal
call loopFib
call exitSystemCall

int_to_string:
  add esi,9
  mov ebx,10
.next_digit:
  xor edx,edx         ; Clear edx prior to dividing edx:eax by ebx
  div ebx             ; eax /= 10
  add dl,'0'         ; Convert the remainder to ASCII 
  dec esi             ; store characters in reverse order
  mov [esi],dl
  test eax,eax            
  jnz .next_digit     ; Repeat until eax==0

  ; return a pointer to the first digit (not necessarily the start of the provided buffer)
  mov eax,esi
  ret
printHello:
    mov rax, 1       ; rax: syscall number 1
    mov rdi, 1      ; rdi: fd 1 for stdout
    mov rsi,message ; rsi: pointer to message
    mov rdx, 20      ; rdx: print length of 20 bytes
    syscall         ; call write syscall to the intro message
    
printNewLine:
    mov rax, 1
    mov rdi, 1
    mov rsi, nline
    mov rdx, 1
    syscall
    ret		 	
initFirstFibVal:    
    xor rax, rax    ; initialize rax to 0
    xor rbx, rbx    ; initialize rbx to 0
    inc rbx         ; increment rbx to 1
    ret
loopFib:
    add rax, rbx    ; get the next number
    xchg rax, rbx   ; swap values
    push rax
    push rbx	
    ; print number
    mov    [num],rax
    
    mov    eax,[num]       ; function args using our own private calling convention
    mov    esi,buffer
    call   int_to_string		
    mov rax, 1
    mov rdi, 1      ; print fib number 
    syscall
    call printNewLine	
    pop rbx
    pop rax          ;	
    cmp rbx, 10		; do rbx - 10
    js loopFib		; jump if result is <0
    ret	   
exitSystemCall:
    mov rax, 60
    mov rdi, 0
    syscall
    ret
	
