; Get one command-line String argument and print it
; This version checks to make sure there actually is a command line argument
; 
.class public EchoOneArg
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

   ; get the args array reference at local 0 for static method main
   aload 0

   ; Check to make sure the args array has exactly one element
   arraylength
   iconst_1
   if_icmpeq gotArgOk

   ; oops - user forgot to give a command-line arguments
   ldc "Useage: java EchoOneArg <string>"
   invokevirtual java.io.PrintStream.println(Ljava/lang/String;)V
   goto done

gotArgOk:
   ; get the first argument String at array slot 0
   aload_0
   iconst_0
   aaload

   ; print the argument String
   invokevirtual java/io/PrintStream.println(Ljava.lang.String;)V

done:
   return
.end method
