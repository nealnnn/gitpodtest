	.file	"adder2.c"
	.text
	.globl	adder2
	.type	adder2, @function
adder2:
.LFB0:
	pushq	%rbp				# save frame pointer
	movq	%rsp, %rbp			# load up new frame pointer for me (adder2)
	movl	%edi, -4(%rbp)			# move parameter into stack frame
	movl	-4(%rbp), %eax			# get the parameter back again into return reg
	addl	$2, %eax			# add 2 to the incomming parameter
	popq	%rbp				# restore the frame pointer for caller
	ret					# return (pop the stack register)
.LFE0:
	.size	adder2, .-adder2
	.section	.rodata
.LC0:
	.string	"x is: %d\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB1:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp
	movl	$40, -4(%rbp)
	movl	-4(%rbp), %eax
	movl	%eax, %edi
	call	adder2
	movl	%eax, -4(%rbp)
	movl	-4(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC0(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, %eax
	leave
	ret
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
