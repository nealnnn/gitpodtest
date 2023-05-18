; Convert the Hello World message to upper case and print it

.class public ToUpperHello
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

   ; push a string onto the stack
   ldc "Hello World from Jasmin!"

   ; convert the String to upper case using toUpperCase method of the String class
   invokevirtual java.lang.String.toUpperCase()Ljava.lang.String;

   ; print out the resulting upper case string
   invokevirtual java/io/PrintStream.println(Ljava/lang/String;)V

   ; done
   return
.end method
