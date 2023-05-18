; Print the length of the args array
; 
.class public ArgsArrayLength
.super java/lang/Object

; standard initializer
.method public <init>()V
   aload_0
 
   invokespecial java/lang/Object/<init>()V
   return
.end method

.method public static main([Ljava/lang/String;)V
   .limit stack 2
   .limit locals 1

   ; push System.out onto the stack
   getstatic java/lang/System.out Ljava/io/PrintStream;

   ; get the args array reference
   aload 0
   arraylength

   ; print the arraylength
   invokevirtual java/io/PrintStream.println(I)V

   ; done
   return
.end method
