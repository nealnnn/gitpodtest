	.globl	_main                   ## -- Begin function main
_main:                                  ## @main
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp
	leaq	L_.str(%rip), %rdi
	movb	$0, %al
	callq	_printf
	xorl	%ecx, %ecx
	movl	%eax, -4(%rbp)          ## 4-byte Spill
	movl	%ecx, %eax
	addq	$16, %rsp
	popq	%rbp
	retq
                                        ## -- End function
L_.str:                                 ## @.str
	.asciz	"Hello World!\n"
