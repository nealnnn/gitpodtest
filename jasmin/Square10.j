; Square10.j - create and call a static method square on constant 10.0

.class public Square10
.super java/lang/Object

; standard initializer
.method public <init>()V
   aload_0
 
   invokespecial java/lang/Object/<init>()V
   return
.end method

.method public static main([Ljava/lang/String;)V
   .limit stack 3
   .limit locals 1

   ; push System.out onto the stack
   getstatic java/lang/System.out Ljava/io/PrintStream;

   ; push a string onto the stack
   ldc 10.0
   f2d

   ; call our square method - it works on doubles
   invokestatic Square10.square(D)D

   ; output the resulting square
   invokevirtual java/io/PrintStream.println(D)V

   ; done
   return
.end method

.method public static square(D)D
  .limit stack 4
  .limit locals 2

  dload 0
  dload 0
  dmul

  dreturn
  .end method
