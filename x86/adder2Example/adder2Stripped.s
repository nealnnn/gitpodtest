	.globl	_adder2                 ## -- Begin function adder2
_adder2:                                ## @adder2
	pushq	%rbp
	movq	%rsp, %rbp
	movl	%edi, -4(%rbp)
	movl	-4(%rbp), %edi
	addl	$2, %edi
	movl	%edi, %eax
	popq	%rbp
	retq
                                        ## -- End function

	.globl	_main                   ## -- Begin function main
_main:                                  ## @main
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp
	movl	$0, -4(%rbp)
	movl	$40, -8(%rbp)
	movl	-8(%rbp), %edi
	callq	_adder2
	leaq	L_.str(%rip), %rdi
	movl	%eax, -8(%rbp)
	movl	-8(%rbp), %esi
	movb	$0, %al
	callq	_printf
	xorl	%esi, %esi
	movl	%eax, -12(%rbp)         ## 4-byte Spill
	movl	%esi, %eax
	addq	$16, %rsp
	popq	%rbp
	retq
                                        ## -- End function

L_.str:                                 ## @.str
	.asciz	"x is: %d\n"
