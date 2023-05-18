; Print the 6th character of the Hello World message using charAt method of String

.class public CharAtHello
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
   ldc "Hello World from Jasmin!"

   ; get the sixth character of the Hello World string
   ldc 6
   invokevirtual java.lang.String.charAt(I)C

   ; print out the resulting character
   invokevirtual java/io/PrintStream.println(C)V

   ; done
   return
.end method
