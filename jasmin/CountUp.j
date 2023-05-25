; Get one command-line argment and parse it into an int and use it as an upper loop bound

.class public CountUp
.super java/lang/Object

; standard initializer
.method public <init>()V
   aload_0
 
   invokespecial java/lang/Object/<init>()V
   return
.end method

.method public static main([Ljava/lang/String;)V
   .limit stack 3
   .limit locals 3

   ; get the args array reference at local 0 for static method main
   aload 0

   ; Check to make sure the args array has at least one element
   arraylength
   ifgt gotArgOk

   ; oops - user forgot to give a command-line arguments
 
   ; push System.out onto the stack
   getstatic java/lang/System.out Ljava/io/PrintStream;
   ldc "Useage: java CountUp <int>"
   invokevirtual java.io.PrintStream.println(Ljava/lang/String;)V
   goto done

gotArgOk:
   ; get the first argument String at array slot 0
   aload_0
   iconst_0
   aaload
   
   ; parse the argument string into an int and use as the upper index bound
   invokestatic java.lang.Integer.parseInt(Ljava.lang.String;)I
   istore_2    ; the upper bound is in local 2

   iconst_0
   istore_1    ; the index is in local 1 starting at 0

top:
   iload 1
   iload 2
   if_icmpge done

   ; push System.out onto the stack
   getstatic java/lang/System.out Ljava/io/PrintStream;

   ; load the index on the stack and print
   iload 1
   invokevirtual java/io/PrintStream.println(I)V

   iinc 1 1
   goto top
   
done:
   return
.end method
