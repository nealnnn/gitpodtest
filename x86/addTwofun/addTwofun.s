	.file	"addTwofun.c"
	.text
	.globl	addTwofun
	.type	addTwofun, @function
addTwofun:
.LFB0:
	pushq	%rbp			# save the caller's frame pointer
	movq	%rsp, %rbp              # set frame pointer for me (addTwofun)
	movl	%edi, -4(%rbp)          # save first local on stack frame (a)
	movl	%esi, -8(%rbp)          # save the second local on the stack frame (b)
	movl	-4(%rbp), %edx          # load parameter a into %edx
	movl	-8(%rbp), %eax          # load parameter b into %eax
	addl	%edx, %eax              # add the two parameters and put int %eax return register
	popq	%rbp                    # restore caller stack frame
	ret                             # return to caller
.LFE0:
	.size	addTwofun, .-addTwofun
	.section	.rodata
.LC0:
	.string	"The sum of 10 and 7 is: %d\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB1:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	$10, -8(%rbp)
	movl	$7, -4(%rbp)
	movl	-4(%rbp), %edx
	movl	-8(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	addTwofun
	movl	%eax, %esi
	leaq	.LC0(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
