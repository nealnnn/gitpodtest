; Average the ints 25, 18, 5, 8, 22 and print the result

.class public AverageConsts
.super java/lang/Object

; standard initializer
.method public <init>()V
aload_0
invokespecial java/lang/Object/<init>()V
return
.end method

.method public static main([Ljava/lang/String;)V
.limit stack 6
.limit locals 1

; push System.out onto the stack
getstatic java/lang/System.out Ljava/io/PrintStream;


; push and add 5 in two values on the stack
ldc 25
ldc 18
iadd
ldc 5
iadd
ldc 8
iadd
ldc 22
iadd
i2f

; call the PrintStream.println() method with the sum of five ints (converted)
invokevirtual java/io/PrintStream.println(F)V

; Try a right associative version of the sum
getstatic java/lang/System.out Ljava/io/PrintStream;

ldc 25
ldc 18
ldc 5
ldc 8
ldc 22
iadd
iadd
iadd
iadd 
i2f

; call the PrintStream.println() method with the sum of five ints (converted)
invokevirtual java/io/PrintStream.println(F)V

; done
return
.end method
