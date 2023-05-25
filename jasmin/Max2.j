; Max2.j - print the maxmimum of two command-line integer arguments

.class public Max2
.super java/lang/Object

; standard initializer
.method public <init>()V
   aload_0
 
   invokespecial java/lang/Object/<init>()V
   return
.end method

.method public static main([Ljava/lang/String;)V
   .limit stack 4
   .limit locals 1

   ; TODO Check to make sure there are exactly 2 command line arguments. If not then
   ;   - print Usage: java Max2 <int> <int>
   ;   and exit

   ; push System.out onto the stack
   getstatic java/lang/System.out Ljava/io/PrintStream;

   ; get first command line argument and conver to int
   aload 0
   iconst_0
   aaload

   ; convert the command-line string argument to int
   invokestatic java.lang.Integer.parseInt(Ljava.lang.String;)I

   ; get the second command-line argument
    aload 0
   iconst_1
   aaload

   ; convert the second command-line string argument to int
   invokestatic java.lang.Integer.parseInt(Ljava.lang.String;)I

   ; call our max method
   invokestatic Max2.max(II)I

   ; output the resulting square
   invokevirtual java/io/PrintStream.println(I)V

   ; done
   return
.end method

.method public static max(II)I
  .limit stack 2
  .limit locals 2

  iload 0
  iload 1
 
  if_icmpge firstIsMax
secondIsMax:
  iload 1
  goto done

firstIsMax:
  iload 0

done:
  ireturn
  .end method
