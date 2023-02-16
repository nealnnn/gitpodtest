	.file	"adder2.c"
	.text
	.globl	adder2
	.type	adder2, @function
adder2:
	endbr64
	pushq	%rbp
	movq	%rsp, %rbp
	movl	%edi, -4(%rbp)
	movl	-4(%rbp), %eax
	addl	$2, %eax
	popq	%rbp
	ret
.LC0:
	.string	"x is: %d\n"
	.text
	.globl	main
	.type	main, @function
main:
	endbr64
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
	leaq	.LC0(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, %eax
	#leave
	addq	$16, %rsp
	popq	%rbp
	ret
