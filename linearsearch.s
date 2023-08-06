.section .data
NotFound:
    .asciz "Not Found\n"
Found:
    .asciz "Found\n"

.section .text
.global _start
_start:
    mov $10, %rdi               # size of the array
    lea array(%rip), %rsi       # pointer to the array
    mov $3, %rdx                # the number to be found

    call linear_search

    test %eax, %eax             # if return value (eax) is 0, print "Not Found"
    jz print_not_found
    lea Found(%rip), %rsi       # else print "Found"
    mov $6, %rdx                # length of string
    jmp print

print_not_found:
    lea NotFound(%rip), %rsi
    mov $10, %rdx                # length of string


print:
    mov $1, %rax                 # write syscall number
    mov $1, %rdi                 # file descriptor (stdout)
    syscall
    mov $60, %rax                # exit syscall number
    xor %rdi, %rdi               # exit status code
    syscall

linear_search:
    push %rbp
    mov %rsp, %rbp
    mov %rdi, %rcx
    mov %rsi, %rbx
    mov %rdx, %r8

loop:
    cmp (%rbx), %r8
    jz found
    add $8, %rbx
    dec %rcx
    jnz loop
    mov $0, %eax
    jmp end

found:
    mov $1, %eax

end:
    pop %rbp
    ret

.section .data
array:
    .quad 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
