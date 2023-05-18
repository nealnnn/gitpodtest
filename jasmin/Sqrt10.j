; Sqrt10.j call Math.sqrt static method

.class public Sqrt10
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

   ; call the Math.sqrt which takes a double and returns a double
   invokestatic java.lang.Math.sqrt(D)D

   ; call the PrintStream.println() method.
   invokevirtual java/io/PrintStream.println(D)V

   ; done
   return
.end method
