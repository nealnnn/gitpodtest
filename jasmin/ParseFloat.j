; Get one command-line argment and parse it into an float and print the float
; 
.class public ParseFloat
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

   ; get the first argument String at array slot 0
   iconst_0
   aaload
   
   ; parse the argument string into an int
   invokestatic java.lang.Float.parseFloat(Ljava.lang.String;)F

   ; print the argument float
   invokevirtual java/io/PrintStream.println(F)V

   ; done
   return
.end method
