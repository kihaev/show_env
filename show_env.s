.include "defs.h"
.section .bss
envp: .quad 0
.section .text
.global _start
newline: 
.byte '\n'
_start:

	movq (%rsp), %rbx
    	leaq 16(%rsp, %rbx, 8), %rcx 
    	movq %rcx, envp  

loop: 

    	movq envp, %rcx    
    	movq (%rcx), %rsi  
    	movq %rsi, %rdi    
    	movq $0, %rdx      

lenzero:

	cmpb $0, (%rdi)    
	je continue        
	incq %rdi          
	incq %rdx          
	jmp lenzero    

continue:

    	movq $SYS_WRITE, %rax  
    	movq $STDOUT, %rdi     
    	syscall
	addq $8, envp
	movq  envp, %r9
	cmpq $0, (%r9)             	
    	je end                    	
    	movq $SYS_WRITE, %rax	
    	movq $STDOUT, %rdi	
    	movq $newline, %rsi     
    	movq $1, %rdx		
    	syscall			
    	jmp loop			

end:

    	movq $SYS_WRITE, %rax  
    	movq $STDOUT, %rdi
    	movq $newline, %rsi    
    	movq $1, %rdx	       
    	syscall                
    	movq $SYS_EXIT, %rax  
    	movq $0, %rdi	       
    	syscall
		       
